
`ifndef _MM2ST_LVLS_SWEEP_SEQ_SVH_
`define _MM2ST_LVLS_SWEEP_SEQ_SVH_

class mm2st_lvls_sweep_seq extends base_mm2st_seq;
	`uvm_object_utils(mm2st_lvls_sweep_seq)

	// Standard UVM Methods:
	extern function new(string name = "mm2st_lvls_sweep_seq");
	extern virtual task body();
endclass : mm2st_lvls_sweep_seq

function mm2st_lvls_sweep_seq::new(string name = "mm2st_lvls_sweep_seq");
  super.new(name);
endfunction : new

task mm2st_lvls_sweep_seq::body();
  lvl_cross_sample_t sample;

  /* Dummy delay */
  #40;
  `uvm_info("MM2ST_LVLS_SWEEP_SEQ", "*** MM2ST_LVLS_SWEEP_SEQ STARTS ***", UVM_LOW)

  repeat (LVLS_NUM / 2 + 1)
  begin
    sample = '{ LVL_DOWN, 'd10 };
    samples.push_back(sample);
  end

  repeat (LVLS_NUM + 1)
  begin
    sample = '{ LVL_UP, 'd10 };
    samples.push_back(sample);
  end

  repeat (LVLS_NUM / 2 + 1)
  begin
    sample = '{ LVL_DOWN, 'd10 };
    samples.push_back(sample);
  end

  send_samples();

  `uvm_info("MM2ST_LVLS_SWEEP_SEQ", "*** MM2ST_LVLS_SWEEP_SEQ ENDS ***", UVM_LOW)
endtask : body

`endif // _MM2ST_LVLS_SWEEP_SEQ_SVH_
