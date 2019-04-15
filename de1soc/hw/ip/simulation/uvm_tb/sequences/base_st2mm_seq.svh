
`ifndef _BASE_ST2MM_SEQ_SVH_
`define _BASE_ST2MM_SEQ_SVH_

class base_st2mm_seq extends uvm_sequence #(st2mm_seq_item);
  `uvm_object_utils(base_st2mm_seq)

  int total_duration;

  // Standard UVM Methods:
  extern function new(string name = "base_st2mm_seq");
  extern virtual task body();

  // Custom methods:
  extern task collect_values(int duration);
endclass : base_st2mm_seq

function base_st2mm_seq::new(string name = "base_st2mm_seq");
  super.new(name);
endfunction : new

task base_st2mm_seq::body();
  `uvm_info(get_name().toupper(), $sformatf("*** %s STARTS ***", get_name().toupper()), UVM_LOW)
  
  total_duration = 100;

  collect_values(total_duration);

  `uvm_info(get_name().toupper(), $sformatf("*** %s ENDS ***", get_name().toupper()), UVM_LOW)
endtask : body

task base_st2mm_seq::collect_values(int duration);
  st2mm_seq_item seq = st2mm_seq_item::type_id::create("seq");

  start_item(seq);

  seq.data      = {};
  seq.burst_len = duration;

  finish_item(seq);
endtask : collect_values

`endif // _BASE_ST2MM_SEQ_SVH_
