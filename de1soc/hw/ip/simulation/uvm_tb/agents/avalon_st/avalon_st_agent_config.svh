
`ifndef _AVALON_ST_AGENT_CONFIG_SVH_
`define _AVALON_ST_AGENT_CONFIG_SVH_

class avalon_st_agent_config #(avalon_st_inst_spec_t INST_SPEC) extends uvm_object;
  `uvm_object_param_utils(avalon_st_agent_config #(INST_SPEC))

  int       bus_width   = 16;
  modport_e vif_modport = MODPORT_SINK;
  string    agent_name  = "agt";
  uvm_active_passive_enum is_active = UVM_PASSIVE;
  int       verbosity   = UVM_DEBUG;

  avalon_st_sequencer #(INST_SPEC)  sequencer;
  virtual avalon_st_if #(INST_SPEC) vif;

  // Standard UVM Methods:
  extern function new(string name = "avalon_st_agent_config");
  extern virtual function string convert2string();
endclass : avalon_st_agent_config

function avalon_st_agent_config::new(string name = "avalon_st_agent_config");
  super.new(name);
endfunction : new

function string avalon_st_agent_config::convert2string();
  return $sformatf("%s\nbus_width   = %0d;\nvif_modport = %s;\nagent_name  = \"%s\";\nis_active   = %s;\nverbosity   = %0d;",
                  super.convert2string(), bus_width, vif_modport.name(), agent_name, is_active, verbosity);
endfunction : convert2string

`endif // _AVALON_ST_AGENT_CONFIG_SVH_
