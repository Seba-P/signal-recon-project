
`ifndef _AVALON_MM_SEQ_SVH_
`define _AVALON_MM_SEQ_SVH_

class avalon_mm_seq #(avalon_mm_inst_spec_t INST_SPEC) extends uvm_sequence #(avalon_mm_seq_item #(INST_SPEC));
  // `uvm_declare_p_sequencer(avalon_mm_sequencer #(BUS_WIDTH))
  `uvm_object_param_utils(avalon_mm_seq #(INST_SPEC))

  // Standard UVM Methods:
  extern function new(string name = "avalon_mm_seq");
  extern virtual task body();
endclass : avalon_mm_seq

function avalon_mm_seq::new(string name = "avalon_mm_seq");
  super.new(name);
endfunction : new

task avalon_mm_seq::body();
  avalon_mm_seq_item #(INST_SPEC) seq = avalon_mm_seq_item#(INST_SPEC)::type_id::create("seq");

  start_item(seq);
  if (!seq.randomize())
    `uvm_fatal("SEQUENCE", "Randomization failed.")
  finish_item(seq);
endtask : body

`endif // _AVALON_MM_SEQ_SVH_
