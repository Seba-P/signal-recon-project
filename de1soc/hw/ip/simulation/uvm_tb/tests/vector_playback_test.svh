
`ifndef _VECTOR_PLAYBACK_TEST_SVH_
`define _VECTOR_PLAYBACK_TEST_SVH_

class vector_playback_test extends base_test;
  `uvm_component_utils(vector_playback_test)

  string m_vector     = "";
  string m_vector_dir = "../vectors";

  vector_handler #(avalon_st_inst_specs[POCS_OUT]) m_vector_handler;

  // Standard UVM Methods:
  extern function new(string name = "vector_playback_test", uvm_component parent = null);
  extern virtual task main_phase(uvm_phase phase);

  // Custom methods:
  extern virtual function void get_cmdline_options();
  extern virtual function void init_test_config();
  extern virtual function void override_csr_reg_block_config();
endclass : vector_playback_test

function vector_playback_test::new(string name = "vector_playback_test", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

task vector_playback_test::main_phase(uvm_phase phase);
  pocs_in_vector_seq  pocs_in_seq;
  pocs_out_vector_seq pocs_out_seq;
  lvl_cross_sample_t  samples[$];

  `uvm_info("TEST", "***** START OF MAIN_PHASE *****", UVM_LOW)
  phase.phase_done.set_drain_time(this, 100);
  phase.raise_objection(this, "");

  pocs_in_seq   = pocs_in_vector_seq::type_id::create("pocs_in_seq", this);
  pocs_out_seq  = pocs_out_vector_seq::type_id::create("pocs_out_seq", this);

  m_vector_handler.get_samples(samples);

  pocs_in_seq.init(samples);
  pocs_out_seq.init(samples);

  fork
    pocs_in_seq.start(m_env.m_config.pocs_in_agent_config.sequencer);
    pocs_out_seq.start(m_env.m_config.pocs_out_agent_config.sequencer);
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
  string vector = { m_vector_dir, "/", m_vector };

  m_vector_handler = vector_handler#(avalon_st_inst_specs[POCS_OUT])::type_id::create("m_vector_handler", this);
  m_vector_handler.parse_vector(vector);
endfunction : init_test_config

function void vector_playback_test::override_csr_reg_block_config();
  m_vector_handler.get_config(m_csr_config.m_csr_reg_block);
endfunction : override_csr_reg_block_config

`endif // _VECTOR_PLAYBACK_TEST_SVH_
