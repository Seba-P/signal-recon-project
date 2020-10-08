
`ifndef _BASE_TEST_SVH_
`define _BASE_TEST_SVH_

class base_test extends uvm_test;
  `uvm_component_utils(base_test)

  pocs_engine_env         m_env;
  pocs_engine_env_config  m_env_cfg;
  csr_reg_block_config    m_csr_config;

  int m_use_register_model  = 1;
  int m_enable_scoreboard   = 1;

  // Standard UVM Methods:
  extern function new(string name = "base_test", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task configure_phase(uvm_phase phase);
  extern virtual task main_phase(uvm_phase phase);
  extern virtual function void report_phase(uvm_phase phase);

  // Custom methods:
  extern virtual function void get_cmdline_options();
  extern virtual function void init_test_config();
  extern virtual function void configure_avalon_mm_vip();
  extern virtual function void override_avalon_mm_vip_config();
  extern virtual function void configure_avalon_st_vip();
  extern virtual function void override_avalon_st_vip_config();
  extern virtual function void configure_register_model();
  extern virtual function void override_register_model_config();
  extern virtual function void configure_csr_reg_block();
  extern virtual function void override_csr_reg_block_config();
endclass : base_test

function base_test::new(string name = "base_test", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void base_test::build_phase(uvm_phase phase);
  `uvm_info("TEST", "***** START OF BUILD_PHASE *****", UVM_LOW)
  m_env_cfg     = pocs_engine_env_config::type_id::create("m_env_cfg", this);
  m_env         = pocs_engine_env::type_id::create("m_env", this);
  m_csr_config  = csr_reg_block_config::type_id::create("m_csr_config", this);

  get_cmdline_options();

  init_test_config();

  m_env_cfg.csr_config          = m_csr_config;
  m_env_cfg.use_register_model  = m_use_register_model;
  m_env_cfg.enable_scoreboard   = m_enable_scoreboard;

  configure_avalon_mm_vip();
  configure_avalon_st_vip();
  configure_register_model();
  configure_csr_reg_block();

  uvm_config_db#(pocs_engine_env_config)::set(this, "m_env", "m_config", m_env_cfg);
  `uvm_info("TEST", "***** END OF BUILD_PHASE *****", UVM_LOW)
endfunction : build_phase

function void base_test::end_of_elaboration_phase(uvm_phase phase);
  uvm_factory factory;

  factory = uvm_factory::get();
  factory.print(1);
  uvm_top.print_topology();
endfunction : end_of_elaboration_phase

task base_test::configure_phase(uvm_phase phase);
  csr_init_config_seq csr_seq;

  `uvm_info("TEST", "***** START OF CONFIGURE_PHASE *****", UVM_LOW)
  phase.phase_done.set_drain_time(this, 10);
  phase.raise_objection(this, "");

  csr_seq = csr_init_config_seq::type_id::create("csr_seq", this);

  csr_seq.csr_config          = m_csr_config;
  csr_seq.reg_model           = m_env.m_reg_model;
  csr_seq.use_register_model  = 1;

  csr_seq.start(m_env.m_config.csr_agent_config.sequencer);

  phase.drop_objection(this, "");
  `uvm_info("TEST", "***** END OF CONFIGURE_PHASE *****", UVM_LOW)
endtask : configure_phase

task base_test::main_phase(uvm_phase phase);
  base_pocs_in_seq  pocs_in_seq;
  base_pocs_out_seq pocs_out_seq;

  `uvm_info("TEST", "***** START OF MAIN_PHASE *****", UVM_LOW)
  phase.phase_done.set_drain_time(this, 100);
  phase.raise_objection(this, "");

  pocs_in_seq   = base_pocs_in_seq::type_id::create("pocs_in_seq", this);
  pocs_out_seq  = base_pocs_out_seq::type_id::create("pocs_out_seq", this);

  fork
    pocs_in_seq.start(m_env.m_config.pocs_in_agent_config.sequencer);
    pocs_out_seq.start(m_env.m_config.pocs_out_agent_config.sequencer);
  join

  phase.drop_objection(this, "");
  `uvm_info("TEST", "***** END OF MAIN_PHASE *****", UVM_LOW)
endtask : main_phase

function void base_test::report_phase(uvm_phase phase);
  uvm_report_server report_server = uvm_report_server::get_server();

  super.report_phase(phase);

    `uvm_info("TEST", "*******************", UVM_LOW);
  if (report_server.get_severity_count(UVM_FATAL) + report_server.get_severity_count(UVM_ERROR) == 0) begin
    `uvm_info("TEST", "*** TEST PASSED ***", UVM_LOW);
  end else begin
    `uvm_info("TEST", "*** TEST FAILED ***", UVM_LOW);
  end
    `uvm_info("TEST", "*******************", UVM_LOW);
endfunction : report_phase

function void base_test::get_cmdline_options();
  // parse cmdline for some useful arguments
endfunction : get_cmdline_options

function void base_test::init_test_config();
  // do some test-specific tuning
endfunction : init_test_config

function void base_test::configure_avalon_mm_vip();
  avalon_mm_agent_config #(avalon_mm_inst_specs[CSR]) csr_agent_config;
  avalon_mm_agent_params_t agent_params;

  `uvm_info("TEST", "Configuring Avalon MM VIP ...", UVM_LOW)

  // -------------------------------------------------------------------------------------------------------------- //
  csr_agent_config  = avalon_mm_agent_config#(avalon_mm_inst_specs[CSR])::type_id::create("csr_agent_config", this);
  agent_params      = avalon_mm_agent_params[CSR];

  if (!uvm_config_db#(virtual avalon_mm_if #(avalon_mm_inst_specs[CSR]))::get(this, "", $sformatf("%s", agent_params.vif_name),
                                                                                                          csr_agent_config.vif))
    `uvm_fatal("CONFIG", $sformatf("Cannot get() '%s' from uvm_config_db. Have you set() it?", agent_params.vif_name))

  if (agent_params.addr_width == 0)
    `uvm_fatal("CONFIG", $sformatf("Avalon MM agent [%s] has ADDR_WIDTH == '0'! Verify configuration in 'tb_params_pkg.sv'.",
                agent_params.agent_name));

  if (agent_params.data_width == 0)
    `uvm_fatal("CONFIG", $sformatf("Avalon MM agent [%s] has DATA_WIDTH == '0'! Verify configuration in 'tb_params_pkg.sv'.",
                agent_params.agent_name));

  csr_agent_config.addr_width   = agent_params.addr_width;
  csr_agent_config.data_width   = agent_params.data_width;
  csr_agent_config.vif_modport  = agent_params.vif_modport;
  csr_agent_config.agent_name   = agent_params.agent_name;
  csr_agent_config.is_active    = agent_params.is_active;
  csr_agent_config.verbosity    = agent_params.verbosity;
  // -------------------------------------------------------------------------------------------------------------- //
  m_env_cfg.csr_agent_config    = csr_agent_config;

  override_avalon_mm_vip_config();

  `uvm_info("TEST", $sformatf("\nAvalon MM agent [%s]:\n%s", 
                              m_env_cfg.csr_agent_config.agent_name, m_env_cfg.csr_agent_config.convert2string()), UVM_LOW)

  `uvm_info("TEST", "... DONE!", UVM_LOW)
endfunction : configure_avalon_mm_vip

function void base_test::override_avalon_mm_vip_config();
  // override some default settings here
endfunction : override_avalon_mm_vip_config

function void base_test::configure_avalon_st_vip();
  avalon_st_agent_config #(avalon_st_inst_specs[POCS_IN])   pocs_in_agent_config;
  avalon_st_agent_config #(avalon_st_inst_specs[POCS_OUT])  pocs_out_agent_config;
  avalon_st_agent_params_t agent_params;
  int i;

  `uvm_info("TEST", "Configuring Avalon ST VIP ...", UVM_LOW)

  // -------------------------------------------------------------------------------------------------------------- //
  pocs_in_agent_config  = avalon_st_agent_config#(avalon_st_inst_specs[POCS_IN])::type_id::create("pocs_in_agent_config", this);
  agent_params          = avalon_st_agent_params[POCS_IN];

  if (!uvm_config_db#(virtual avalon_st_if #(avalon_st_inst_specs[POCS_IN]))::get(this, "", $sformatf("%s", agent_params.vif_name),
                                                                                                          pocs_in_agent_config.vif))
    `uvm_fatal("CONFIG", $sformatf("Cannot get() '%s' from uvm_config_db. Have you set() it?", agent_params.vif_name))

  if (agent_params.bus_width == 0)
    `uvm_fatal("CONFIG", $sformatf("Avalon ST agent [%s] has BUS_WIDTH == '0'! Verify configuration in 'tb_params_pkg.sv'.",
                agent_params.agent_name));

  pocs_in_agent_config.bus_width    = agent_params.bus_width;
  pocs_in_agent_config.vif_modport  = agent_params.vif_modport;
  pocs_in_agent_config.agent_name   = agent_params.agent_name;
  pocs_in_agent_config.is_active    = agent_params.is_active;
  pocs_in_agent_config.verbosity    = agent_params.verbosity;

  // -------------------------------------------------------------------------------------------------------------- //
  pocs_out_agent_config = avalon_st_agent_config#(avalon_st_inst_specs[POCS_OUT])::type_id::create("pocs_out_agent_config", this);
  agent_params          = avalon_st_agent_params[POCS_OUT];

  if (!uvm_config_db#(virtual avalon_st_if #(avalon_st_inst_specs[POCS_OUT]))::get(this, "", $sformatf("%s", agent_params.vif_name),
                                                                                                          pocs_out_agent_config.vif))
    `uvm_fatal("CONFIG", $sformatf("Cannot get() '%s' from uvm_config_db. Have you set() it?", agent_params.vif_name))

  if (agent_params.bus_width == 0)
    `uvm_fatal("CONFIG", $sformatf("Avalon ST agent [%s] has BUS_WIDTH == '0'! Verify configuration in 'tb_params_pkg.sv'.",
                agent_params.agent_name));

  pocs_out_agent_config.bus_width   = agent_params.bus_width;
  pocs_out_agent_config.vif_modport = agent_params.vif_modport;
  pocs_out_agent_config.agent_name  = agent_params.agent_name;
  pocs_out_agent_config.is_active   = agent_params.is_active;
  pocs_out_agent_config.verbosity   = agent_params.verbosity;

  // -------------------------------------------------------------------------------------------------------------- //
  m_env_cfg.pocs_in_agent_config  = pocs_in_agent_config;
  m_env_cfg.pocs_out_agent_config = pocs_out_agent_config;

  override_avalon_st_vip_config();

  `uvm_info("TEST", $sformatf("\nAvalon ST agent [%s]:\n%s", 
                              m_env_cfg.pocs_in_agent_config.agent_name, m_env_cfg.pocs_in_agent_config.convert2string()), UVM_LOW)
  `uvm_info("TEST", $sformatf("\nAvalon ST agent [%s]:\n%s", 
                              m_env_cfg.pocs_out_agent_config.agent_name, m_env_cfg.pocs_out_agent_config.convert2string()), UVM_LOW)

  `uvm_info("TEST", "... DONE!", UVM_LOW)
endfunction : configure_avalon_st_vip

function void base_test::override_avalon_st_vip_config();
  // override some default settings here
endfunction : override_avalon_st_vip_config

function void base_test::configure_register_model();
  register_model_config reg_model_config;

  `uvm_info("TEST", "Configuring Register Model ...", UVM_LOW)

  // -------------------------------------------------------------------------------------------------------------- //
  reg_model_config = register_model_config::type_id::create("reg_model_config", this);

  reg_model_config.reg_model_name = register_model_params.reg_model_name;
  reg_model_config.hdl_path_root  = register_model_params.hdl_path_root;
  reg_model_config.default_path   = register_model_params.default_path;
  reg_model_config.verbosity      = register_model_params.verbosity;
  // -------------------------------------------------------------------------------------------------------------- //
  m_env_cfg.reg_model_config = reg_model_config;

  override_register_model_config();

  `uvm_info("TEST", $sformatf("\nRegister Model:\n%s", m_env_cfg.reg_model_config.convert2string()), UVM_LOW)

  `uvm_info("TEST", "... DONE!", UVM_LOW)
endfunction : configure_register_model

function void base_test::override_register_model_config();
  // override some default settings here
endfunction : override_register_model_config

function void base_test::configure_csr_reg_block();
  csr_reg_block_t csr_reg_block;

  `uvm_info("TEST", "Configuring CSR Register Block ...", UVM_LOW)

  csr_reg_block =
  '{
    /*status*/  '{ /*_reserved2*/'0, /*fifo_err*/'0, /*_reserved1*/'0, /*error*/'0, /*ready*/'0, /*busy*/'0 }, // read-only, discard
    /*control*/ '{ /*_reserved1*/'0, /*init*/'0, /*flush*/'0, /*halt*/'0, /*run*/'0 },
    /*params*/  '{ /*_reserved4*/'0, /*init_guess*/DEFAULT_INIT_GUESS, /*_reserved3*/'0, /*iter_num*/DEFAULT_ITER_NUM, /*_reserved2*/'0, /*init_lvl*/DEFAULT_INIT_LVL, /*_reserved1*/'0, /*lvls_num*/DEFAULT_LVLS_NUM },
    /*lvl_val_00_01*/ '{ /*lvl_val_01*/'h9333, /*lvl_val_00*/'h8666 },
    /*lvl_val_02_03*/ '{ /*lvl_val_03*/'hACCC, /*lvl_val_02*/'h9FFF },
    /*lvl_val_04_05*/ '{ /*lvl_val_05*/'hC666, /*lvl_val_04*/'hB999 },
    /*lvl_val_06_07*/ '{ /*lvl_val_07*/'hE000, /*lvl_val_06*/'hD333 },
    /*lvl_val_08_09*/ '{ /*lvl_val_09*/'hF999, /*lvl_val_08*/'hECCC },
    /*lvl_val_10_11*/ '{ /*lvl_val_11*/'h1333, /*lvl_val_10*/'h0666 },
    /*lvl_val_12_13*/ '{ /*lvl_val_13*/'h2CCC, /*lvl_val_12*/'h2000 },
    /*lvl_val_14_15*/ '{ /*lvl_val_15*/'h4666, /*lvl_val_14*/'h3999 },
    /*lvl_val_16_17*/ '{ /*lvl_val_17*/'h6000, /*lvl_val_16*/'h5333 },
    /*lvl_val_18_19*/ '{ /*lvl_val_19*/'h7999, /*lvl_val_18*/'h6CCC },
    /*lvl_val_20_21*/ '{ /*lvl_val_21*/'hFFFF, /*lvl_val_20*/'hFFFF },
    /*lvl_val_22_23*/ '{ /*lvl_val_23*/'hFFFF, /*lvl_val_22*/'hFFFF },
    /*lvl_val_24_25*/ '{ /*lvl_val_25*/'hFFFF, /*lvl_val_24*/'hFFFF },
    /*lvl_val_26_27*/ '{ /*lvl_val_27*/'hFFFF, /*lvl_val_26*/'hFFFF },
    /*lvl_val_28_29*/ '{ /*lvl_val_29*/'hFFFF, /*lvl_val_28*/'hFFFF },
    /*lvl_val_30_31*/ '{ /*lvl_val_31*/'hFFFF, /*lvl_val_30*/'hFFFF } 
  };

  m_csr_config.m_csr_reg_block = csr_reg_block;

  override_csr_reg_block_config();

  `uvm_info("TEST", "... DONE!", UVM_LOW)
endfunction : configure_csr_reg_block

function void base_test::override_csr_reg_block_config();
  // override some default settings here
endfunction : override_csr_reg_block_config

`endif // _BASE_TEST_SVH_
