
`ifndef _AVALON_ST_SEQUENCER_SVH_
`define _AVALON_ST_SEQUENCER_SVH_

class avalon_st_sequencer #(avalon_st_inst_spec_t INST_SPEC) extends uvm_sequencer #(avalon_st_seq_item #(INST_SPEC));
  `uvm_component_param_utils(avalon_st_sequencer #(INST_SPEC))

  // Standard UVM Methods:
  extern function new(string name = "avalon_st_sequencer", uvm_component parent = null);
endclass : avalon_st_sequencer

function avalon_st_sequencer::new(string name = "avalon_st_sequencer", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

`endif // _AVALON_ST_SEQUENCER_SVH_
