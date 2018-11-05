
`ifndef _BASE_ST2MM_SEQ_SVH_
`define _BASE_ST2MM_SEQ_SVH_

// typedef uvm_sequencer #(st2mm_seq_item) st2mm_sequencer;
typedef avalon_st_sequencer #(avalon_st_inst_specs[ST2MM]) st2mm_sequencer;

// class base_st2mm_seq extends uvm_sequence #(st2mm_seq_item);
class base_st2mm_seq extends uvm_sequence #(avalon_st_seq_item #(avalon_st_inst_specs[ST2MM]));
	`uvm_object_utils(base_st2mm_seq)

	// Standard UVM Methods:
	extern function new(string name = "base_st2mm_seq");
	extern virtual task body();
endclass : base_st2mm_seq

function base_st2mm_seq::new(string name = "base_st2mm_seq");
  super.new(name);
endfunction : new

task base_st2mm_seq::body();
  // st2mm_seq_item seq = st2mm_seq_item::type_id::create("seq");
  avalon_st_seq_item #(avalon_st_inst_specs[ST2MM]) seq = avalon_st_seq_item#(avalon_st_inst_specs[ST2MM])::type_id::create("seq");

  `uvm_info("BASE_ST2MM_SEQ", "*** BASE_ST2MM_SEQ STARTS ***", UVM_LOW)
  start_item(seq);

  seq.data 			= {};
  seq.burst_len = 10 * (2 * (LVLS_NUM / 2 + 1) + LVLS_NUM + 1);

  finish_item(seq);
  `uvm_info("BASE_ST2MM_SEQ", "*** BASE_ST2MM_SEQ ENDS ***", UVM_LOW)
endtask : body

`endif // _BASE_ST2MM_SEQ_SVH_
