
`ifndef _REGISTER_MODEL_CONFIG_SVH_
`define _REGISTER_MODEL_CONFIG_SVH_

class register_model_config extends uvm_object;
  `uvm_object_utils(register_model_config)

  string        reg_model_name  = "reg_model";
  uvm_path_e    default_path    = UVM_DEFAULT_PATH;
  uvm_verbosity verbosity       = UVM_DEBUG;
  
  // csr_sequencer sequencer;

  // Standard UVM Methods:
  extern function new(string name = "register_model_config");
  extern virtual function string convert2string();
endclass : register_model_config

function register_model_config::new(string name = "register_model_config");
  super.new(name);
endfunction : new

function string register_model_config::convert2string();
  return $sformatf("%s\nreg_model_name  = \"%s\";\ndefault_path    = %s;\nverbosity       = %s;",
                  super.convert2string(), reg_model_name, default_path.name(), verbosity.name());
endfunction : convert2string

`endif // _REGISTER_MODEL_CONFIG_SVH_
