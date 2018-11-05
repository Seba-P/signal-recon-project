
`ifndef _FIR_SUBSYSTEM_ENV_SVH_
`define _FIR_SUBSYSTEM_ENV_SVH_

class fir_subsystem_env extends uvm_env;
  `uvm_component_utils(fir_subsystem_env)

  fir_subsystem_env_config m_config;

  avalon_st_agent #(avalon_st_inst_specs[MM2ST]) m_mm2st_agent;
  avalon_st_agent #(avalon_st_inst_specs[ST2MM]) m_st2mm_agent;

  // Standard UVM Methods:
  extern function new(string name = "fir_subsystem_env", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
endclass: fir_subsystem_env

function fir_subsystem_env::new(string name = "fir_subsystem_env", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Only required if you have sub-components
function void fir_subsystem_env::build_phase(uvm_phase phase);
  if (!uvm_config_db#(fir_subsystem_env_config)::get(this, "", "m_config", m_config))
    `uvm_fatal("CONFIG", "Cannot get() configuration 'm_config' from uvm_config_db. Have you set() it?")

  m_mm2st_agent = avalon_st_agent#(avalon_st_inst_specs[MM2ST])::type_id::create("m_mm2st_agent", this);
  m_st2mm_agent = avalon_st_agent#(avalon_st_inst_specs[ST2MM])::type_id::create("m_st2mm_agent", this);

  uvm_config_db#(avalon_st_agent_config #(avalon_st_inst_specs[MM2ST]))::set(this, "m_mm2st_agent*", "m_config", m_config.mm2st_agent_config);
  uvm_config_db#(avalon_st_agent_config #(avalon_st_inst_specs[ST2MM]))::set(this, "m_st2mm_agent*", "m_config", m_config.st2mm_agent_config);
endfunction: build_phase

// Only required if you have sub-components which are connected
function void fir_subsystem_env::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction: connect_phase

`endif // _FIR_SUBSYSTEM_ENV_SVH_