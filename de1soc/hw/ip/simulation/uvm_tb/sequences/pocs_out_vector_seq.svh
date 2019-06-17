
`ifndef _POCS_OUT_VECTOR_SEQ_SVH_
`define _POCS_OUT_VECTOR_SEQ_SVH_

class pocs_out_vector_seq extends base_pocs_out_seq;
  `uvm_object_utils(pocs_out_vector_seq)

  // Standard UVM Methods:
  extern function new(string name = "pocs_out_vector_seq");
  extern virtual task body();

  // Custom methods:
  extern virtual task init(lvl_cross_sample_t samples[$]);
endclass : pocs_out_vector_seq

function pocs_out_vector_seq::new(string name = "pocs_out_vector_seq");
  super.new(name);
endfunction : new

task pocs_out_vector_seq::body();
  `uvm_info(get_name().toupper(), $sformatf("*** %s STARTS ***", get_name().toupper()), UVM_LOW)

  collect_values(total_duration);
  
  `uvm_info(get_name().toupper(), $sformatf("*** %s ENDS ***", get_name().toupper()), UVM_LOW)
endtask : body

task pocs_out_vector_seq::init(lvl_cross_sample_t samples[$]);
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

`endif // _POCS_OUT_VECTOR_SEQ_SVH_
