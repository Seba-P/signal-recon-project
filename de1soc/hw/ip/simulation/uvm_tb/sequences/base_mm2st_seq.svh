
`ifndef _BASE_MM2ST_SEQ_SVH_
`define _BASE_MM2ST_SEQ_SVH_

typedef avalon_st_sequencer #(avalon_st_inst_specs[MM2ST]) mm2st_sequencer;

class base_mm2st_seq extends uvm_sequence #(mm2st_seq_item);
	`uvm_object_utils(base_mm2st_seq)

  rand lvl_cross_sample_t sample;

	// Standard UVM Methods:
	extern function new(string name = "base_mm2st_seq");
	extern virtual task body();
endclass : base_mm2st_seq

function base_mm2st_seq::new(string name = "base_mm2st_seq");
  super.new(name);
endfunction : new

task base_mm2st_seq::body();
  mm2st_seq_item seq = mm2st_seq_item::type_id::create("seq");

  /* Dummy delay */
  #15;

  `uvm_info("BASE_MM2ST_SEQ", "*** BASE_MM2ST_SEQ STARTS ***", UVM_LOW)
  start_item(seq);

  sample = '{ LVL_UP, 'd100 };
  seq.data.push_back(avalon_st_inst_specs[MM2ST].BUS_WIDTH'(sample));
  seq.burst_len++;

  finish_item(seq);
  `uvm_info("BASE_MM2ST_SEQ", "*** BASE_MM2ST_SEQ ENDS ***", UVM_LOW)

endtask : body

`endif // _BASE_MM2ST_SEQ_SVH_
