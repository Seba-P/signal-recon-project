
`ifndef _AVALON_MM_MONITOR_SVH_
`define _AVALON_MM_MONITOR_SVH_

class avalon_mm_monitor #(avalon_mm_inst_spec_t INST_SPEC) extends uvm_component;
  `uvm_component_param_utils(avalon_mm_monitor #(INST_SPEC));

  avalon_mm_agent_config #(INST_SPEC) m_config;
  int                                 m_transactions_num;
  int                                 m_transfers_num;

  uvm_analysis_port #(avalon_mm_seq_item #(INST_SPEC)) m_ap;
  virtual avalon_mm_if #(INST_SPEC)                    m_vif;

  // Standard UVM methods:
  extern function new(string name = "avalon_mm_monitor", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern function void report_phase(uvm_phase phase);

  // Custom methods:
  extern function void notify_transaction(avalon_mm_seq_item #(INST_SPEC) item);
endclass : avalon_mm_monitor

function avalon_mm_monitor::new(string name = "avalon_mm_monitor", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void avalon_mm_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if (!uvm_config_db#(avalon_mm_agent_config #(INST_SPEC))::get(this, "", "m_config", m_config))
    `uvm_fatal("CONFIG", $sformatf("Cannot get() 'm_config' from uvm_config_db. Have you set() it?"))

  m_transactions_num  = 0;
  m_transfers_num     = 0;

  m_ap  = new("m_ap", this);
  m_vif = m_config.vif;
endfunction : build_phase

task avalon_mm_monitor::run_phase(uvm_phase phase);
  avalon_mm_seq_item #(INST_SPEC) item;
  avalon_mm_seq_item #(INST_SPEC) cloned_item;

  item = avalon_mm_seq_item#(INST_SPEC)::type_id::create("item");

  forever
  begin
    item.clear();

    m_vif.get_transaction(item);
    m_transactions_num++;
    m_transfers_num += item.data.size();
  
    // Clone and publish the cloned item to the subscribers
    if (!$cast(cloned_item, item.clone()))
      `uvm_fatal("clone", "Clone of 'item' object failed.")
    
    notify_transaction(cloned_item);
  end
endtask : run_phase

function void avalon_mm_monitor::report_phase(uvm_phase phase);
  `uvm_info("REPORT", $sformatf("Total transactions/transfers detected: %0d/%0d", m_transactions_num, m_transfers_num), UVM_LOW)
endfunction : report_phase

function void avalon_mm_monitor::notify_transaction(avalon_mm_seq_item #(INST_SPEC) item);
  `uvm_info("MONITOR", $sformatf("Detected transaction: %s", item.convert2string()), m_config.verbosity)
  m_ap.write(item);
endfunction : notify_transaction

`endif // _AVALON_MM_MONITOR_SVH_
