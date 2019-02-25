
`ifndef _BASE_TEST_SVH_
`define _BASE_TEST_SVH_

class base_test extends uvm_test;
  `uvm_component_utils(base_test)

  pocs_engine_env         m_env;
  pocs_engine_env_config  m_env_cfg;
  csr_reg_block_config    m_csr_init_config;

  // Standard UVM Methods:
  extern function new(string name = "base_test", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task configure_phase(uvm_phase phase);
  extern virtual task main_phase(uvm_phase phase);

  // Custom methods:
  extern function void configure_avalon_mm_vip();
  extern function void override_avalon_mm_vip_config();
  extern function void configure_avalon_st_vip();
  extern function void override_avalon_st_vip_config();
  extern function void configure_register_model();
  extern function void override_register_model_config();
  extern function void override_csr_init_config();
endclass : base_test

function base_test::new(string name = "base_test", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void base_test::build_phase(uvm_phase phase);
  `uvm_info("TEST", "***** START OF BUILD_PHASE *****", UVM_LOW)
  m_env_cfg         = pocs_engine_env_config::type_id::create("m_env_cfg");
  m_env             = pocs_engine_env::type_id::create("m_env", this);
  m_csr_init_config = csr_reg_block_config::type_id::create("m_csr_init_config", this);

  m_env_cfg.csr_config          = m_csr_init_config;
  m_env_cfg.use_register_model  = 1;
  m_env_cfg.enable_scoreboard   = 1;

  configure_avalon_mm_vip();
  configure_avalon_st_vip();
  configure_register_model();

  override_csr_init_config();
  m_csr_init_config.m_csr_reg_block = csr_init_config;

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

  csr_seq = csr_init_config_seq::type_id::create("csr_seq");

  csr_seq.csr_config          = m_csr_init_config;
  csr_seq.reg_model           = m_env.m_reg_model;
  csr_seq.use_register_model  = 1;

  csr_seq.start(m_env.m_config.csr_agent_config.sequencer);

  phase.drop_objection(this, "");
  `uvm_info("TEST", "***** END OF CONFIGURE_PHASE *****", UVM_LOW)
endtask : configure_phase

task base_test::main_phase(uvm_phase phase);
  base_mm2st_seq  mm2st_seq;
  base_st2mm_seq  st2mm_seq;

  `uvm_info("TEST", "***** START OF MAIN_PHASE *****", UVM_LOW)
  phase.phase_done.set_drain_time(this, 100);
  phase.raise_objection(this, "");

  mm2st_seq = base_mm2st_seq::type_id::create("mm2st_seq");
  st2mm_seq = base_st2mm_seq::type_id::create("st2mm_seq");

  fork
    mm2st_seq.start(m_env.m_config.mm2st_agent_config.sequencer);
    st2mm_seq.start(m_env.m_config.st2mm_agent_config.sequencer);
  join

  phase.drop_objection(this, "");
  `uvm_info("TEST", "***** END OF MAIN_PHASE *****", UVM_LOW)
endtask : main_phase

function void base_test::configure_avalon_mm_vip();
  avalon_mm_agent_config #(avalon_mm_inst_specs[CSR]) csr_agent_config;
  avalon_mm_agent_params_t agent_params;

  `uvm_info("TEST", "Configuring Avalon MM VIP...", UVM_LOW)

  // -------------------------------------------------------------------------------------------------------------- //
  csr_agent_config  = avalon_mm_agent_config#(avalon_mm_inst_specs[CSR])::type_id::create("csr_agent_config");
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
  avalon_st_agent_config #(avalon_st_inst_specs[MM2ST]) mm2st_agent_config;
  avalon_st_agent_config #(avalon_st_inst_specs[ST2MM]) st2mm_agent_config;
  avalon_st_agent_params_t agent_params;
  int i;

  `uvm_info("TEST", "Configuring Avalon ST VIP...", UVM_LOW)

  // -------------------------------------------------------------------------------------------------------------- //
  mm2st_agent_config  = avalon_st_agent_config#(avalon_st_inst_specs[MM2ST])::type_id::create("mm2st_agent_config");
  agent_params        = avalon_st_agent_params[MM2ST];

  if (!uvm_config_db#(virtual avalon_st_if #(avalon_st_inst_specs[MM2ST]))::get(this, "", $sformatf("%s", agent_params.vif_name),
                                                                                                          mm2st_agent_config.vif))
    `uvm_fatal("CONFIG", $sformatf("Cannot get() '%s' from uvm_config_db. Have you set() it?", agent_params.vif_name))

  if (agent_params.bus_width == 0)
    `uvm_fatal("CONFIG", $sformatf("Avalon ST agent [%s] has BUS_WIDTH == '0'! Verify configuration in 'tb_params_pkg.sv'.",
                agent_params.agent_name));

  mm2st_agent_config.bus_width    = agent_params.bus_width;
  mm2st_agent_config.vif_modport  = agent_params.vif_modport;
  mm2st_agent_config.agent_name   = agent_params.agent_name;
  mm2st_agent_config.is_active    = agent_params.is_active;
  mm2st_agent_config.verbosity    = agent_params.verbosity;

  // -------------------------------------------------------------------------------------------------------------- //
  st2mm_agent_config  = avalon_st_agent_config#(avalon_st_inst_specs[ST2MM])::type_id::create("st2mm_agent_config");
  agent_params        = avalon_st_agent_params[ST2MM];

  if (!uvm_config_db#(virtual avalon_st_if #(avalon_st_inst_specs[ST2MM]))::get(this, "", $sformatf("%s", agent_params.vif_name),
                                                                                                          st2mm_agent_config.vif))
    `uvm_fatal("CONFIG", $sformatf("Cannot get() '%s' from uvm_config_db. Have you set() it?", agent_params.vif_name))

  if (agent_params.bus_width == 0)
    `uvm_fatal("CONFIG", $sformatf("Avalon ST agent [%s] has BUS_WIDTH == '0'! Verify configuration in 'tb_params_pkg.sv'.",
                agent_params.agent_name));

  st2mm_agent_config.bus_width    = agent_params.bus_width;
  st2mm_agent_config.vif_modport  = agent_params.vif_modport;
  st2mm_agent_config.agent_name   = agent_params.agent_name;
  st2mm_agent_config.is_active    = agent_params.is_active;
  st2mm_agent_config.verbosity    = agent_params.verbosity;

  // -------------------------------------------------------------------------------------------------------------- //
  m_env_cfg.mm2st_agent_config = mm2st_agent_config;
  m_env_cfg.st2mm_agent_config = st2mm_agent_config;

  override_avalon_st_vip_config();

  `uvm_info("TEST", $sformatf("\nAvalon ST agent [%s]:\n%s", 
                              m_env_cfg.mm2st_agent_config.agent_name, m_env_cfg.mm2st_agent_config.convert2string()), UVM_LOW)
  `uvm_info("TEST", $sformatf("\nAvalon ST agent [%s]:\n%s", 
                              m_env_cfg.st2mm_agent_config.agent_name, m_env_cfg.st2mm_agent_config.convert2string()), UVM_LOW)

  `uvm_info("TEST", "... DONE!", UVM_LOW)
endfunction : configure_avalon_st_vip

function void base_test::override_avalon_st_vip_config();
  // override some default settings here
endfunction : override_avalon_st_vip_config

function void base_test::configure_register_model();
  register_model_config reg_model_config;

  `uvm_info("TEST", "Configuring Register Model...", UVM_LOW)

  // -------------------------------------------------------------------------------------------------------------- //
  reg_model_config = register_model_config::type_id::create("reg_model_config");

  reg_model_config.reg_model_name = register_model_params.reg_model_name;
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

function void base_test::override_csr_init_config();
  // override some default settings here
endfunction : override_csr_init_config

`endif // _BASE_TEST_SVH_
