
`ifndef _MM2ST_VECTOR_SEQ_SVH_
`define _MM2ST_VECTOR_SEQ_SVH_

class mm2st_vector_seq extends base_mm2st_seq;
  `uvm_object_utils(mm2st_vector_seq)

  // Standard UVM Methods:
  extern function new(string name = "mm2st_vector_seq");
  extern virtual task body();

  // Custom methods:
  extern virtual task init(lvl_cross_sample_t samples[$]);
endclass : mm2st_vector_seq

function mm2st_vector_seq::new(string name = "mm2st_vector_seq");
  super.new(name);
endfunction : new

task mm2st_vector_seq::body();
  lvl_cross_sample_t sample;

  /* Dummy delay */
  #40;
  `uvm_info(get_name().toupper(), $sformatf("*** %s STARTS ***", get_name().toupper()), UVM_LOW)

  send_samples();

  `uvm_info(get_name().toupper(), $sformatf("*** %s ENDS ***", get_name().toupper()), UVM_LOW)
endtask : body

task mm2st_vector_seq::init(lvl_cross_sample_t samples[$]);
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

`endif // _MM2ST_VECTOR_SEQ_SVH_
