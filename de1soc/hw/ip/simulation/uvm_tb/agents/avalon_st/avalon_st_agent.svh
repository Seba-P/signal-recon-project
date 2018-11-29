
`ifndef _AVALON_ST_AGENT_SVH_
`define _AVALON_ST_AGENT_SVH_

class avalon_st_agent #(avalon_st_inst_spec_t INST_SPEC) extends uvm_agent;
  `uvm_component_param_utils(avalon_st_agent #(INST_SPEC))

  avalon_st_agent_config #(INST_SPEC) m_config;

  uvm_analysis_port #(avalon_st_seq_item #(INST_SPEC)) m_ap;
  avalon_st_monitor #(INST_SPEC)   m_monitor;
  avalon_st_sequencer #(INST_SPEC) m_sequencer;
  avalon_st_driver #(INST_SPEC)    m_driver;

  // Standard UVM Methods:
  extern function new(string name = "avalon_st_agent", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
endclass : avalon_st_agent

function avalon_st_agent::new(string name = "avalon_st_agent", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void avalon_st_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  // Get the agent configuration object
  if (!uvm_config_db#(avalon_st_agent_config #(INST_SPEC))::get(this, "", "m_config", m_config))
    `uvm_fatal("CONFIG", $sformatf("Cannot get() 'm_config' from uvm_config_db. Have you set() it?"))

  // Monitor is always present
  m_monitor = avalon_st_monitor#(INST_SPEC)::type_id::create("m_monitor", this);

  // Only build the driver and sequencer if active
  if (m_config.is_active == UVM_ACTIVE)
  begin
    m_driver            = avalon_st_driver#(INST_SPEC)::type_id::create("m_driver", this);
    m_sequencer         = avalon_st_sequencer#(INST_SPEC)::type_id::create("m_sequencer", this);
    m_config.sequencer  = m_sequencer;
  end
endfunction : build_phase

function void avalon_st_agent::connect_phase(uvm_phase phase);
  m_ap = m_monitor.m_ap;

  // Only connect the driver and the sequencer if active
  if (m_config.is_active == UVM_ACTIVE)
  begin
    m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
  end
endfunction : connect_phase

`endif // _AVALON_ST_AGENT_SVH_
