
`ifndef _AVALON_ST_AGENT_CONFIG_BASE_SVH_
`define _AVALON_ST_AGENT_CONFIG_BASE_SVH_

virtual class avalon_st_agent_config_base extends uvm_object;
	`uvm_object_utils(avalon_st_agent_config_base)

	int       bus_width   = 16;
	modport_e vif_modport = MODPORT_SINK;
	string		agent_name 	= "agt";
	uvm_active_passive_enum is_active = UVM_PASSIVE;
	int       verbosity   = UVM_DEBUG;

	virtual avalon_st_if #(INST_SPEC) vif;

	// Standard UVM Methods:
	extern function new(string name = "avalon_st_agent_config_base");
	// extern virtual function string convert2string();
endclass : avalon_st_agent_config_base

function avalon_st_agent_config_base::new(string name = "avalon_st_agent_config_base");
  super.new(name);
endfunction : new

`endif // _AVALON_ST_AGENT_CONFIG_BASE_SVH_
