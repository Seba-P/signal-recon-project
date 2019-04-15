
`ifndef _ST2MM_VECTOR_SEQ_SVH_
`define _ST2MM_VECTOR_SEQ_SVH_

class st2mm_vector_seq extends base_st2mm_seq;
  `uvm_object_utils(st2mm_vector_seq)

  // Standard UVM Methods:
  extern function new(string name = "st2mm_vector_seq");
  extern virtual task body();

  // Custom methods:
  extern virtual task init(lvl_cross_sample_t samples[$]);
endclass : st2mm_vector_seq

function st2mm_vector_seq::new(string name = "st2mm_vector_seq");
  super.new(name);
endfunction : new

task st2mm_vector_seq::body();
  `uvm_info(get_name().toupper(), $sformatf("*** %s STARTS ***", get_name().toupper()), UVM_LOW)

  collect_values(total_duration);
  
  `uvm_info(get_name().toupper(), $sformatf("*** %s ENDS ***", get_name().toupper()), UVM_LOW)
endtask : body

task st2mm_vector_seq::init(lvl_cross_sample_t samples[$]);
  lvl_cross_sample_t sample;
  automatic int duration;
  automatic int count;

  while (samples.size() > 0)
  begin
  	sample 		= samples.pop_front();
  	duration += sample.timestamp;
  	count++;
  end

  `uvm_info(get_name().toupper(), $sformatf("Expecting %0d samples with total duration: %0d cycles.", count, duration), UVM_LOW)

  total_duration = duration;
endtask : init

`endif // _ST2MM_VECTOR_SEQ_SVH_
