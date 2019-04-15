
`ifndef _POCS_ENGINE_ENV_CONFIG_SVH_
`define _POCS_ENGINE_ENV_CONFIG_SVH_

class pocs_engine_env_config extends uvm_object;
  `uvm_object_utils(pocs_engine_env_config)

  avalon_mm_agent_config #(avalon_mm_inst_specs[CSR])   csr_agent_config;
  avalon_st_agent_config #(avalon_st_inst_specs[MM2ST]) mm2st_agent_config;
  avalon_st_agent_config #(avalon_st_inst_specs[ST2MM]) st2mm_agent_config;
  register_model_config                                 reg_model_config;
  csr_reg_block_config                                  csr_config;

  bit use_register_model  = 0;
  bit enable_scoreboard   = 0;

  // Standard UVM Methods:
  extern function new(string name = "pocs_engine_env_config");
endclass : pocs_engine_env_config

function pocs_engine_env_config::new(string name = "pocs_engine_env_config");
  super.new(name);
endfunction : new

`endif // _POCS_ENGINE_ENV_CONFIG_SVH_
