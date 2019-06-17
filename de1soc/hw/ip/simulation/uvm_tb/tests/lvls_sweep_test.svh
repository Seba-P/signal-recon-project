
`ifndef _LVLS_SWEEP_TEST_SVH_
`define _LVLS_SWEEP_TEST_SVH_

class lvls_sweep_test extends base_test;
  `uvm_component_utils(lvls_sweep_test)

  // Standard UVM Methods:
  extern function new(string name = "lvls_sweep_test", uvm_component parent = null);
  extern virtual task main_phase(uvm_phase phase);
endclass : lvls_sweep_test

function lvls_sweep_test::new(string name = "lvls_sweep_test", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

task lvls_sweep_test::main_phase(uvm_phase phase);
  base_pocs_in_seq::type_id::set_type_override(pocs_in_lvls_sweep_seq::get_type());
  base_pocs_out_seq::type_id::set_type_override(pocs_out_lvls_sweep_seq::get_type());

  super.main_phase(phase);
endtask : main_phase

`endif // _LVLS_SWEEP_TEST_SVH_
