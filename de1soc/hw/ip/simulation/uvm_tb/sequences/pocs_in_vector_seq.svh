
`ifndef _POCS_IN_VECTOR_SEQ_SVH_
`define _POCS_IN_VECTOR_SEQ_SVH_

class pocs_in_vector_seq extends base_pocs_in_seq;
  `uvm_object_utils(pocs_in_vector_seq)

  // Standard UVM Methods:
  extern function new(string name = "pocs_in_vector_seq");
  extern virtual task body();

  // Custom methods:
  extern virtual task init(lvl_cross_sample_t samples[$]);
endclass : pocs_in_vector_seq

function pocs_in_vector_seq::new(string name = "pocs_in_vector_seq");
  super.new(name);
endfunction : new

task pocs_in_vector_seq::body();
  lvl_cross_sample_t sample;

  /* Dummy delay */
  #40;
  `uvm_info(get_name().toupper(), $sformatf("*** %s STARTS ***", get_name().toupper()), UVM_LOW)

  send_samples();

  `uvm_info(get_name().toupper(), $sformatf("*** %s ENDS ***", get_name().toupper()), UVM_LOW)
endtask : body

task pocs_in_vector_seq::init(lvl_cross_sample_t samples[$]);
  automatic int duration;
  automatic int count;

  foreach (samples[i])
  begin
    duration += samples[i].timestamp;
    count++;
  end

  `uvm_info(get_name().toupper(), $sformatf("Stored %0d samples with total duration: %0d cycles.", count, duration), UVM_LOW)
  
  this.samples = samples;
endtask : init

`endif // _POCS_IN_VECTOR_SEQ_SVH_
