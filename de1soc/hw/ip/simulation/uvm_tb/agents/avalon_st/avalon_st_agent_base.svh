
`ifndef _AVALON_ST_AGENT_BASE_SVH_
`define _AVALON_ST_AGENT_BASE_SVH_

virtual class avalon_st_agent_base extends uvm_agent;
  `uvm_component_utils(avalon_st_agent_base)

  // Standard UVM Methods:
  extern function new(string name = "avalon_st_agent_base", uvm_component parent = null);
  // pure virtual function void build_phase(uvm_phase phase);
  // pure virtual function void connect_phase(uvm_phase phase);
endclass : avalon_st_agent_base

function avalon_st_agent_base::new(string name = "avalon_st_agent_base", uvm_component parent = null);
  super.new(name, parent);
endfunction

`endif // _AVALON_ST_AGENT_BASE_SVH_
