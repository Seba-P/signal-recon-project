
`ifndef _AVALON_ST_MONITOR_SVH_
`define _AVALON_ST_MONITOR_SVH_

class avalon_st_monitor #(avalon_st_inst_spec_t INST_SPEC) extends uvm_component;
  `uvm_component_param_utils(avalon_st_monitor #(INST_SPEC));

  avalon_st_agent_config #(INST_SPEC) m_config;
  int                                 m_transactions_num;
  int                                 m_transfers_num;

  uvm_analysis_port #(avalon_st_seq_item #(INST_SPEC)) m_ap;
  virtual avalon_st_if #(INST_SPEC)                    m_vif;

  // Standard UVM methods:
  extern function new(string name = "avalon_st_monitor", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern function void report_phase(uvm_phase phase);

  // Custom methods:
  extern function void notify_transaction(avalon_st_seq_item #(INST_SPEC) item);
endclass : avalon_st_monitor

function avalon_st_monitor::new(string name = "avalon_st_monitor", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void avalon_st_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if (!uvm_config_db#(avalon_st_agent_config #(INST_SPEC))::get(this, "", "m_config", m_config))
    `uvm_fatal("CONFIG", $sformatf("Cannot get() 'm_config' from uvm_config_db. Have you set() it?"))

  m_transactions_num  = 0;
  m_transfers_num     = 0;

  m_ap  = new("m_ap", this);
  m_vif = m_config.vif;
endfunction : build_phase

task avalon_st_monitor::run_phase(uvm_phase phase);
  avalon_st_seq_item #(INST_SPEC) item;
  avalon_st_seq_item #(INST_SPEC) cloned_item;

  item = avalon_st_seq_item#(INST_SPEC)::type_id::create("item");

  forever
  begin
    item.data       = {};
    item.burst_len  = 0;

    m_vif.get_transaction(item);
    m_transactions_num++;
    m_transfers_num += item.data.size();
  
    // Clone and publish the cloned item to the subscribers
    if (!$cast(cloned_item, item.clone()))
      `uvm_fatal("clone", "Clone of 'item' object failed.")
    
    notify_transaction(cloned_item);
  end
endtask : run_phase

function void avalon_st_monitor::report_phase(uvm_phase phase);
  `uvm_info("REPORT", $sformatf("Total transactions/transfers detected: %0d/%0d", m_transactions_num, m_transfers_num), UVM_LOW)
endfunction : report_phase

function void avalon_st_monitor::notify_transaction(avalon_st_seq_item #(INST_SPEC) item);
  `uvm_info("MONITOR", $sformatf("Detected transaction: %s", item.convert2string()), m_config.verbosity)
  m_ap.write(item);
endfunction : notify_transaction

`endif // _AVALON_ST_MONITOR_SVH_
