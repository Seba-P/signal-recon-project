
`ifndef _BASE_MM2ST_SEQ_SVH_
`define _BASE_MM2ST_SEQ_SVH_

class base_mm2st_seq extends uvm_sequence #(mm2st_seq_item);
	`uvm_object_utils(base_mm2st_seq)

  rand lvl_cross_sample_t samples[$];

	// Standard UVM Methods:
	extern function new(string name = "base_mm2st_seq");
	extern virtual task body();

  // Custom methods:
  extern task send_samples();
endclass : base_mm2st_seq

function base_mm2st_seq::new(string name = "base_mm2st_seq");
  super.new(name);
endfunction : new

task base_mm2st_seq::body();
  lvl_cross_sample_t sample;

  /* Dummy delay */
  #50;
  `uvm_info("BASE_MM2ST_SEQ", "*** BASE_MM2ST_SEQ STARTS ***", UVM_LOW)

  sample = '{ LVL_UP, 'd100 };
  samples.push_back(sample);

  send_samples();

  `uvm_info("BASE_MM2ST_SEQ", "*** BASE_MM2ST_SEQ ENDS ***", UVM_LOW)
endtask : body

task base_mm2st_seq::send_samples();
  mm2st_seq_item seq = mm2st_seq_item::type_id::create("seq");

  start_item(seq);

  while (samples.size())
  begin
    seq.data.push_back(avalon_st_inst_specs[MM2ST].BUS_WIDTH'(samples.pop_front()));
    seq.burst_len++;
  end

  finish_item(seq);
endtask : send_samples

`endif // _BASE_MM2ST_SEQ_SVH_
