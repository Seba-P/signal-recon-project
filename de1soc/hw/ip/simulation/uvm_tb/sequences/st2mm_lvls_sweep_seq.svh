
`ifndef _ST2MM_LVLS_SWEEP_SEQ_SVH_
`define _ST2MM_LVLS_SWEEP_SEQ_SVH_

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
  `uvm_info("ST2MM_LVLS_SWEEP_SEQ", "*** ST2MM_LVLS_SWEEP_SEQ STARTS ***", UVM_LOW)
  
  total_duration = 10 * (2 * (LVLS_NUM / 2 + 1) + LVLS_NUM + 1);

  collect_values(total_duration);
  
  `uvm_info("ST2MM_LVLS_SWEEP_SEQ", "*** ST2MM_LVLS_SWEEP_SEQ ENDS ***", UVM_LOW)
endtask : body

`endif // _ST2MM_LVLS_SWEEP_SEQ_SVH_
