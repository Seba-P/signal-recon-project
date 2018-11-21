
`ifndef _AVALON_MM_AGENT_SVH_
`define _AVALON_MM_AGENT_SVH_

class avalon_mm_agent #(avalon_mm_inst_spec_t INST_SPEC) extends uvm_agent;
  `uvm_component_param_utils(avalon_mm_agent #(INST_SPEC))

  avalon_mm_agent_config #(INST_SPEC) m_config;

  uvm_analysis_port #(avalon_mm_seq_item #(INST_SPEC)) m_ap;
  avalon_mm_monitor #(INST_SPEC)   m_monitor;
  avalon_mm_sequencer #(INST_SPEC) m_sequencer;
  avalon_mm_driver #(INST_SPEC)    m_driver;

  // Standard UVM Methods:
  extern function new(string name = "avalon_mm_agent", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
endclass : avalon_mm_agent

function avalon_mm_agent::new(string name = "avalon_mm_agent", uvm_component parent = null);
  super.new(name, parent);
endfunction

function void avalon_mm_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  // Get the agent configuration object
  if (!uvm_config_db#(avalon_mm_agent_config #(INST_SPEC))::get(this, "", "m_config", m_config))
    `uvm_fatal("CONFIG", $sformatf("Cannot get() 'm_config' from uvm_config_db. Have you set() it?"))

  // Monitor is always present
  m_monitor = avalon_mm_monitor#(INST_SPEC)::type_id::create("m_monitor", this);

  // Only build the driver and sequencer if active
  if (m_config.is_active == UVM_ACTIVE)
  begin
    m_driver    = avalon_mm_driver#(INST_SPEC)::type_id::create("m_driver", this);
    m_sequencer = avalon_mm_sequencer#(INST_SPEC)::type_id::create("m_sequencer", this);
    // m_config.sequencer    = m_sequencer; // TODO:
  end
endfunction: build_phase

function void avalon_mm_agent::connect_phase(uvm_phase phase);
  m_ap = m_monitor.m_ap;

  // Only connect the driver and the sequencer if active
  if (m_config.is_active == UVM_ACTIVE)
  begin
    m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
  end
endfunction: connect_phase

`endif // _AVALON_MM_AGENT_SVH_
