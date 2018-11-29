
`ifndef _REGISTER_MODEL_SVH_
`define _REGISTER_MODEL_SVH_

class register_model extends uvm_env;
  `uvm_component_utils(register_model)

  register_model_config   m_config;

  csr_reg_block           m_reg_block;
  csr_reg_block_adapter   m_adapter;
  csr_reg_block_predictor m_predictor;

  // Standard UVM Methods:
  extern function new(string name = "register_model", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
endclass : register_model

function register_model::new(string name = "register_model", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void register_model::build_phase(uvm_phase phase);
  if (!uvm_config_db#(register_model_config)::get(this, "", "m_config", m_config))
    `uvm_fatal("CONFIG", "Cannot get() 'm_config' from uvm_config_db. Have you set() it?")

  m_reg_block = csr_reg_block::type_id::create("m_reg_block", this);
  m_adapter   = csr_reg_block_adapter::type_id::create("m_adapter", this);
  m_predictor = csr_reg_block_predictor::type_id::create("m_predictor", this);

  m_reg_block.build();
  m_reg_block.reset("HARD");
endfunction : build_phase

function void register_model::connect_phase(uvm_phase phase);
  // m_reg_block.default_map.set_sequencer(m_config.sequencer, m_adapter);

  m_predictor.map     = m_reg_block.default_map;
  m_predictor.adapter = m_adapter;
endfunction : connect_phase

`endif // _REGISTER_MODEL_SVH_
