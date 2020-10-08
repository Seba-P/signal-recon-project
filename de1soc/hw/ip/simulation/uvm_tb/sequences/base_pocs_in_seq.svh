
`ifndef _BASE_POCS_IN_SEQ_SVH_
`define _BASE_POCS_IN_SEQ_SVH_

class base_pocs_in_seq extends uvm_sequence #(pocs_in_seq_item);
  `uvm_object_utils(base_pocs_in_seq)

  rand lvl_cross_sample_t samples[$];

  // Standard UVM Methods:
  extern function new(string name = "base_pocs_in_seq");
  extern virtual task body();

  // Custom methods:
  extern task send_samples();
endclass : base_pocs_in_seq

function base_pocs_in_seq::new(string name = "base_pocs_in_seq");
  super.new(name);
endfunction : new

task base_pocs_in_seq::body();
  lvl_cross_sample_t sample;

  /* Dummy delay */
  #50;
  `uvm_info(get_name().toupper(), $sformatf("*** %s STARTS ***", get_name().toupper()), UVM_LOW)

  repeat (20) begin
    sample = '{ lvl_cross_dir_e'($urandom_range(0,100)%2), $urandom_range(6,60) };
    samples.push_back(sample);
  end

  send_samples();

  `uvm_info(get_name().toupper(), $sformatf("*** %s ENDS ***", get_name().toupper()), UVM_LOW)
endtask : body

task base_pocs_in_seq::send_samples();
  pocs_in_seq_item seq = pocs_in_seq_item::type_id::create("seq");

  start_item(seq);

  while (samples.size())
  begin
    seq.data.push_back(avalon_st_inst_specs[POCS_IN].BUS_WIDTH'(samples.pop_front()));
    seq.burst_len++;
  end

  finish_item(seq);
endtask : send_samples

`endif // _BASE_POCS_IN_SEQ_SVH_
