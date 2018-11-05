
`ifndef _LVLS_SWEEP_TEST_SVH_
`define _LVLS_SWEEP_TEST_SVH_

class lvls_sweep_test extends base_test;
  `uvm_component_utils(lvls_sweep_test)

  // Standard UVM Methods:
  extern function new(string name = "lvls_sweep_test", uvm_component parent = null);
  // extern virtual function void build_phase(uvm_phase phase);
  extern virtual task main_phase(uvm_phase phase);
endclass : lvls_sweep_test

function lvls_sweep_test::new(string name = "lvls_sweep_test", uvm_component parent = null);
  super.new(name, parent);
endfunction

// function void lvls_sweep_test::build_phase(uvm_phase phase);
//   base_mm2st_seq::type_id::set_type_override(mm2st_lvls_sweep_seq::get_type());
//   base_st2mm_seq::type_id::set_type_override(st2mm_lvls_sweep_seq::get_type());

//   super.build_phase(phase);
// endfunction : build_phase

task lvls_sweep_test::main_phase(uvm_phase phase);
  base_mm2st_seq::type_id::set_type_override(mm2st_lvls_sweep_seq::get_type());
  base_st2mm_seq::type_id::set_type_override(st2mm_lvls_sweep_seq::get_type());

  super.main_phase(phase);
endtask : main_phase

// task lvls_sweep_test::main_phase(uvm_phase phase);
//   mm2st_lvls_sweep_seq mm2st_seq;
//   st2mm_lvls_sweep_seq st2mm_seq;

//   `uvm_info("TEST", "***** START OF MAIN_PHASE *****", UVM_LOW)
//   phase.phase_done.set_drain_time(this, 100);  // Delay objection drop 100ns
//   phase.raise_objection(this, "");

//   mm2st_seq = mm2st_lvls_sweep_seq::type_id::create("mm2st_seq");
//   st2mm_seq = st2mm_lvls_sweep_seq::type_id::create("st2mm_seq");
//   // mm2st_seq.start(m_env.m_agent_config["mm2st"].sequencer); // TODO: sequencer handle instead of hardcoded
//   fork
//     mm2st_seq.start(m_env.m_mm2st_agent.m_sequencer);
//     st2mm_seq.start(m_env.m_st2mm_agent.m_sequencer);
//   join

//   phase.drop_objection(this, "");
//   `uvm_info("TEST", "***** END OF MAIN_PHASE *****", UVM_LOW)
// endtask : main_phase

`endif // _LVLS_SWEEP_TEST_SVH_
