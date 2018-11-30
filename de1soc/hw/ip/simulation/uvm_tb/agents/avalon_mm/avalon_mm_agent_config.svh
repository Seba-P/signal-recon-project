
`ifndef _AVALON_MM_AGENT_CONFIG_SVH_
`define _AVALON_MM_AGENT_CONFIG_SVH_

class avalon_mm_agent_config #(avalon_mm_inst_spec_t INST_SPEC) extends uvm_object;
  `uvm_object_param_utils(avalon_mm_agent_config #(INST_SPEC))

  int       addr_width  = 32;
  int       data_width  = 32;
  modport_e vif_modport = MODPORT_SLAVE;
  string    agent_name  = "agt";
  uvm_active_passive_enum is_active = UVM_PASSIVE;
  uvm_verbosity           verbosity = UVM_DEBUG;

  avalon_mm_sequencer #(INST_SPEC)  sequencer;
  virtual avalon_mm_if #(INST_SPEC) vif;

  // Standard UVM Methods:
  extern function new(string name = "avalon_mm_agent_config");
  extern virtual function string convert2string();
endclass : avalon_mm_agent_config

function avalon_mm_agent_config::new(string name = "avalon_mm_agent_config");
  super.new(name);
endfunction : new

function string avalon_mm_agent_config::convert2string();
  return $sformatf("%s\naddr_width  = %0d;\ndata_width  = %0d;\nvif_modport = %s;\nagent_name  = \"%s\";\nis_active   = %s;\nverbosity   = %s;",
                  super.convert2string(), addr_width, data_width, vif_modport.name(), agent_name, is_active.name(), verbosity.name());
endfunction : convert2string

`endif // _AVALON_MM_AGENT_CONFIG_SVH_
