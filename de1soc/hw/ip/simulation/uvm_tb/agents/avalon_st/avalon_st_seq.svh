
`ifndef _AVALON_ST_SEQ_SVH_
`define _AVALON_ST_SEQ_SVH_

class avalon_st_seq #(avalon_st_inst_spec_t INST_SPEC) extends uvm_sequence #(avalon_st_seq_item #(INST_SPEC));
	// `uvm_declare_p_sequencer(avalon_st_sequencer #(BUS_WIDTH))
	`uvm_object_param_utils(avalon_st_seq #(INST_SPEC))

	// Standard UVM Methods:
	extern function new(string name = "avalon_st_seq");
	extern virtual task body();
endclass : avalon_st_seq

function avalon_st_seq::new(string name = "avalon_st_seq");
  super.new(name);
endfunction : new

task avalon_st_seq::body();
  avalon_st_seq_item #(INST_SPEC) seq = avalon_st_seq_item#(INST_SPEC)::type_id::create("seq");

  start_item(seq);
  if (!seq.randomize())
  	`uvm_fatal("SEQUENCE", "Randomization failed.")
  finish_item(seq);
endtask : body

`endif // _AVALON_ST_SEQ_SVH_
