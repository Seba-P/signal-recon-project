
`ifndef _BASE_TEST_SVH_
`define _BASE_TEST_SVH_

class base_test extends uvm_test;
  `uvm_component_utils(base_test)

  fir_subsystem_env         m_env;
  fir_subsystem_env_config  m_env_cfg;

  // Standard UVM Methods:
  extern function new(string name = "base_test", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task main_phase(uvm_phase phase);

  // Custom methods:
  extern function void configure_avalon_st_vip();
  extern function void override_avalon_st_vip_config();
endclass : base_test

function base_test::new(string name = "base_test", uvm_component parent = null);
  super.new(name, parent);
endfunction

function void base_test::build_phase(uvm_phase phase);
  `uvm_info("TEST", "***** START OF BUILD_PHASE *****", UVM_LOW)
  m_env_cfg = fir_subsystem_env_config::type_id::create("m_env_cfg");
  m_env     = fir_subsystem_env::type_id::create("m_env", this);

  m_env_cfg.enable_scoreboard = 1;

  configure_avalon_st_vip();

  uvm_config_db#(fir_subsystem_env_config)::set(this, "m_env", "m_config", m_env_cfg);
  `uvm_info("TEST", "***** END OF BUILD_PHASE *****", UVM_LOW)
endfunction: build_phase

function void base_test::end_of_elaboration_phase(uvm_phase phase);
  uvm_factory factory;

  factory = uvm_factory::get();
  factory.print(1);          // Reports components registered in factory
  uvm_top.print_topology();
endfunction : end_of_elaboration_phase

task base_test::main_phase(uvm_phase phase);
  base_mm2st_seq mm2st_seq;
  base_st2mm_seq st2mm_seq;

  `uvm_info("TEST", "***** START OF MAIN_PHASE *****", UVM_LOW)
  phase.phase_done.set_drain_time(this, 100);  // Delay objection drop 100ns
  phase.raise_objection(this, "");

  mm2st_seq = base_mm2st_seq::type_id::create("mm2st_seq");
  st2mm_seq = base_st2mm_seq::type_id::create("st2mm_seq");

  // mm2st_seq.start(m_env.m_agent_config["mm2st"].sequencer); // TODO: sequencer handle instead of hardcoded
  fork
    mm2st_seq.start(m_env.m_mm2st_agent.m_sequencer);
    st2mm_seq.start(m_env.m_st2mm_agent.m_sequencer);
  join

  phase.drop_objection(this, "");
  `uvm_info("TEST", "***** END OF MAIN_PHASE *****", UVM_LOW)
endtask : main_phase

function void base_test::configure_avalon_st_vip();
  avalon_st_agent_config #(avalon_st_inst_specs[MM2ST]) mm2st_agent_config;
  avalon_st_agent_config #(avalon_st_inst_specs[ST2MM]) st2mm_agent_config;
  avalon_st_agent_params_t  agent_params;
  // string agent_name;
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
                              m_env_cfg.st2mm_agent_config.agent_name, m_env_cfg.st2mm_agent_config.convert2string()), UVM_LOW)
  `uvm_info("TEST", $sformatf("\nAvalon ST agent [%s]:\n%s", 
                              m_env_cfg.mm2st_agent_config.agent_name, m_env_cfg.mm2st_agent_config.convert2string()), UVM_LOW)

  `uvm_info("TEST", "... DONE!", UVM_LOW)
endfunction : configure_avalon_st_vip

function void base_test::override_avalon_st_vip_config();
  // override some default settings here
endfunction : override_avalon_st_vip_config

`endif // _BASE_TEST_SVH_
