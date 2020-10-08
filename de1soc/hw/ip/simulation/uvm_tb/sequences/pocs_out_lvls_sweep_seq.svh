
`ifndef _POCS_OUT_LVLS_SWEEP_SEQ_SVH_
`define _POCS_OUT_LVLS_SWEEP_SEQ_SVH_

class pocs_out_lvls_sweep_seq extends base_pocs_out_seq;
  `uvm_object_utils(pocs_out_lvls_sweep_seq)

  // Standard UVM Methods:
  extern function new(string name = "pocs_out_lvls_sweep_seq");
  extern virtual task body();
endclass : pocs_out_lvls_sweep_seq

function pocs_out_lvls_sweep_seq::new(string name = "pocs_out_lvls_sweep_seq");
  super.new(name);
endfunction : new

task pocs_out_lvls_sweep_seq::body();
  `uvm_info(get_name().toupper(), $sformatf("*** %s STARTS ***", get_name().toupper()), UVM_LOW)
  
  total_duration = 10 * (2 * (DEFAULT_LVLS_NUM / 2 + 1) + DEFAULT_LVLS_NUM + 1);

  collect_values(total_duration);
  
  `uvm_info(get_name().toupper(), $sformatf("*** %s ENDS ***", get_name().toupper()), UVM_LOW)
endtask : body

`endif // _POCS_OUT_LVLS_SWEEP_SEQ_SVH_
