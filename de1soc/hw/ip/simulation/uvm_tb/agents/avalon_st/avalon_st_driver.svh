
`ifndef _AVALON_ST_DRIVER_SVH_
`define _AVALON_ST_DRIVER_SVH_

class avalon_st_driver #(avalon_st_inst_spec_t INST_SPEC) extends uvm_driver #(avalon_st_seq_item #(INST_SPEC), avalon_st_seq_item #(INST_SPEC));
  `uvm_component_param_utils(avalon_st_driver #(INST_SPEC))

  avalon_st_agent_config #(INST_SPEC) m_config;
  virtual avalon_st_if #(INST_SPEC)   m_vif;

  // Standard UVM Methods:
  extern function new(string name = "avalon_st_driver", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
endclass : avalon_st_driver

function avalon_st_driver::new(string name = "avalon_st_driver", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void avalon_st_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if (!uvm_config_db#(avalon_st_agent_config #(INST_SPEC))::get(this, "", "m_config", m_config))
    `uvm_fatal("CONFIG", $sformatf("Cannot get() 'm_config' from uvm_config_db. Have you set() it?"))

  m_vif = m_config.vif;
endfunction : build_phase
  
task avalon_st_driver::run_phase(uvm_phase phase);
  avalon_st_seq_item #(INST_SPEC) seq;

  m_vif.wait_for_reset();
  m_vif.clear_bus();

  forever
  begin
    seq_item_port.get_next_item(seq);

    if (INST_SPEC.VIF_MODPORT == MODPORT_SOURCE)
      m_vif.push_data(seq);
    else
      m_vif.pull_data(seq);

    seq_item_port.item_done();
  end
endtask : run_phase

`endif // _AVALON_ST_DRIVER_SVH_
