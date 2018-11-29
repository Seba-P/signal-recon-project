
`ifndef _REGISTER_MODEL_CONFIG_SVH_
`define _REGISTER_MODEL_CONFIG_SVH_

class register_model_config extends uvm_object;
  `uvm_object_utils(register_model_config)

  // csr_sequencer sequencer;

  // Standard UVM Methods:
  extern function new(string name = "register_model_config");
endclass : register_model_config

function register_model_config::new(string name = "register_model_config");
  super.new(name);
endfunction : new

`endif // _REGISTER_MODEL_CONFIG_SVH_
