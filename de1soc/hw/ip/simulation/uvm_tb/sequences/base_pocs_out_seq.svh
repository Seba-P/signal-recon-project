
`ifndef _BASE_POCS_OUT_SEQ_SVH_
`define _BASE_POCS_OUT_SEQ_SVH_

class base_pocs_out_seq extends uvm_sequence #(pocs_out_seq_item);
  `uvm_object_utils(base_pocs_out_seq)

  int total_duration;

  // Standard UVM Methods:
  extern function new(string name = "base_pocs_out_seq");
  extern virtual task body();

  // Custom methods:
  extern task collect_values(int duration);
endclass : base_pocs_out_seq

function base_pocs_out_seq::new(string name = "base_pocs_out_seq");
  super.new(name);
endfunction : new

task base_pocs_out_seq::body();
  `uvm_info(get_name().toupper(), $sformatf("*** %s STARTS ***", get_name().toupper()), UVM_LOW)
  
  total_duration = 100;

  collect_values(total_duration);

  `uvm_info(get_name().toupper(), $sformatf("*** %s ENDS ***", get_name().toupper()), UVM_LOW)
endtask : body

task base_pocs_out_seq::collect_values(int duration);
  pocs_out_seq_item seq = pocs_out_seq_item::type_id::create("seq");

  start_item(seq);

  seq.data      = {};
  seq.burst_len = duration;

  finish_item(seq);
endtask : collect_values

`endif // _BASE_POCS_OUT_SEQ_SVH_
