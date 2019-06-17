
`ifndef _POCS_IN_LVLS_SWEEP_SEQ_SVH_
`define _POCS_IN_LVLS_SWEEP_SEQ_SVH_

class pocs_in_lvls_sweep_seq extends base_pocs_in_seq;
  `uvm_object_utils(pocs_in_lvls_sweep_seq)

  // Standard UVM Methods:
  extern function new(string name = "pocs_in_lvls_sweep_seq");
  extern virtual task body();
endclass : pocs_in_lvls_sweep_seq

function pocs_in_lvls_sweep_seq::new(string name = "pocs_in_lvls_sweep_seq");
  super.new(name);
endfunction : new

task pocs_in_lvls_sweep_seq::body();
  lvl_cross_sample_t sample;

  /* Dummy delay */
  #40;
  `uvm_info(get_name().toupper(), $sformatf("*** %s STARTS ***", get_name().toupper()), UVM_LOW)

  repeat (LVLS_NUM / 2 + 1)
  begin
    sample = '{ LVL_DOWN, 'd10 };
    samples.push_back(sample);
  end

  repeat (LVLS_NUM + 1)
  begin
    sample = '{ LVL_UP, 'd10 };
    samples.push_back(sample);
  end

  repeat (LVLS_NUM / 2 + 1)
  begin
    sample = '{ LVL_DOWN, 'd10 };
    samples.push_back(sample);
  end

  send_samples();

  `uvm_info(get_name().toupper(), $sformatf("*** %s ENDS ***", get_name().toupper()), UVM_LOW)
endtask : body

`endif // _POCS_IN_LVLS_SWEEP_SEQ_SVH_
