
`ifndef _FIR_SUBSYSTEM_ENV_CONFIG_SVH_
`define _FIR_SUBSYSTEM_ENV_CONFIG_SVH_

class fir_subsystem_env_config extends uvm_object;
  `uvm_object_utils(fir_subsystem_env_config)

  avalon_mm_agent_config #(avalon_mm_inst_specs[CSR]) 	csr_agent_config;
  avalon_st_agent_config #(avalon_st_inst_specs[MM2ST]) mm2st_agent_config;
  avalon_st_agent_config #(avalon_st_inst_specs[ST2MM]) st2mm_agent_config;

  bit enable_scoreboard = 0;

  // Standard UVM Methods:
  extern function new(string name = "fir_subsystem_env_config");
endclass: fir_subsystem_env_config

function fir_subsystem_env_config::new(string name = "fir_subsystem_env_config");
  super.new(name);
endfunction

`endif // _FIR_SUBSYSTEM_ENV_CONFIG_SVH_
