
`ifndef _ST2MM_LVLS_SWEEP_SEQ_SVH_
`define _ST2MM_LVLS_SWEEP_SEQ_SVH_

// class st2mm_lvls_sweep_seq extends uvm_sequence #(avalon_st_seq_item #(avalon_st_inst_specs[ST2MM]));
class st2mm_lvls_sweep_seq extends base_st2mm_seq;
	`uvm_object_utils(st2mm_lvls_sweep_seq)

	// Standard UVM Methods:
	extern function new(string name = "st2mm_lvls_sweep_seq");
	extern virtual task body();
endclass : st2mm_lvls_sweep_seq

function st2mm_lvls_sweep_seq::new(string name = "st2mm_lvls_sweep_seq");
  super.new(name);
endfunction : new

task st2mm_lvls_sweep_seq::body();
  // st2mm_seq_item seq = st2mm_seq_item::type_id::create("seq");
  avalon_st_seq_item #(avalon_st_inst_specs[ST2MM]) seq = avalon_st_seq_item#(avalon_st_inst_specs[ST2MM])::type_id::create("seq");

  `uvm_info("ST2MM_LVLS_SWEEP_SEQ", "*** ST2MM_LVLS_SWEEP_SEQ STARTS ***", UVM_LOW)
  start_item(seq);

  seq.data 			= {};
  seq.burst_len = 10 * (2 * (LVLS_NUM / 2 + 1) + LVLS_NUM + 1);

  finish_item(seq);
  `uvm_info("ST2MM_LVLS_SWEEP_SEQ", "*** ST2MM_LVLS_SWEEP_SEQ ENDS ***", UVM_LOW)
endtask : body

`endif // _ST2MM_LVLS_SWEEP_SEQ_SVH_
