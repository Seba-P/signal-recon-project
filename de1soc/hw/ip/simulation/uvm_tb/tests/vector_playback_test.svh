
`ifndef _VECTOR_PLAYBACK_TEST_SVH_
`define _VECTOR_PLAYBACK_TEST_SVH_

class vector_playback_test extends base_test;
  `uvm_component_utils(vector_playback_test)

  string m_vector     = "";
  string m_vector_dir = "";

  // Standard UVM Methods:
  extern function new(string name = "vector_playback_test", uvm_component parent = null);
  extern virtual task main_phase(uvm_phase phase);

  // Custom methods:
  extern virtual function void get_cmdline_options();
  extern virtual function void init_test_config();
endclass : vector_playback_test

function vector_playback_test::new(string name = "vector_playback_test", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

task vector_playback_test::main_phase(uvm_phase phase);
  mm2st_vector_seq  mm2st_seq;
  st2mm_vector_seq  st2mm_seq;
  lvl_cross_sample_t samples[$];

  `uvm_info("TEST", "***** START OF MAIN_PHASE *****", UVM_LOW)
  phase.phase_done.set_drain_time(this, 100);
  phase.raise_objection(this, "");

  mm2st_seq = mm2st_vector_seq::type_id::create("mm2st_seq");
  st2mm_seq = st2mm_vector_seq::type_id::create("st2mm_seq");

  repeat (5)
	  samples.push_back('{ LVL_UP, 'd100 });

  /* Temporary placeholder for vector handlers */
  mm2st_seq.init(samples);
  st2mm_seq.init(samples);

  fork
    mm2st_seq.start(m_env.m_config.mm2st_agent_config.sequencer);
    st2mm_seq.start(m_env.m_config.st2mm_agent_config.sequencer);
  join

  phase.drop_objection(this, "");
  `uvm_info("TEST", "***** END OF MAIN_PHASE *****", UVM_LOW)
endtask : main_phase

function void vector_playback_test::get_cmdline_options();
  uvm_cmdline_processor cmdline_processor;
  string cmdline_option;

  super.get_cmdline_options();

  cmdline_processor = uvm_cmdline_processor::get_inst();

  if (cmdline_processor.get_arg_value("+TEST_VECTOR=", cmdline_option) != "") begin
    m_vector = cmdline_option;
    `uvm_info("get_cmdline_options", $sformatf("Provided test vector '%s'.", m_vector), UVM_LOW);
  end else begin
    `uvm_info("get_cmdline_options", $sformatf("No test vector provided."), UVM_LOW);
  end

  if (cmdline_processor.get_arg_value("+TEST_VECTOR_DIR=", cmdline_option) != "") begin
    m_vector_dir = cmdline_option;
    `uvm_info("get_cmdline_options", $sformatf("Provided test vector directory '%s'.", m_vector_dir), UVM_LOW);
  end else begin
    `uvm_info("get_cmdline_options", $sformatf("No test vector directory provided."), UVM_LOW);
  end
endfunction : get_cmdline_options

function void vector_playback_test::init_test_config();
  // do some test-specific tuning
endfunction : init_test_config

`endif // _VECTOR_PLAYBACK_TEST_SVH_
