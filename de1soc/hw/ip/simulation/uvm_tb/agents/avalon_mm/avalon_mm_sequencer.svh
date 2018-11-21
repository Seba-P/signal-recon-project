
`ifndef _AVALON_MM_SEQUENCER_SVH_
`define _AVALON_MM_SEQUENCER_SVH_

class avalon_mm_sequencer #(avalon_mm_inst_spec_t INST_SPEC) extends uvm_sequencer #(avalon_mm_seq_item #(INST_SPEC));
  `uvm_component_param_utils(avalon_mm_sequencer #(INST_SPEC))

  // Standard UVM Methods:
  extern function new(string name = "avalon_mm_sequencer", uvm_component parent = null);
endclass : avalon_mm_sequencer

function avalon_mm_sequencer::new(string name = "avalon_mm_sequencer", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

`endif // _AVALON_MM_SEQUENCER_SVH_
