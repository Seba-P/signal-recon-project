
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

  // Custom methods:
  extern task read_reg(input bit [31:0] reg_offset, input bit [ 7:0] byte_mask, output bit [31:0] value, output uvm_status_e status);
  extern task write_reg(input bit [31:0] reg_offset, input bit [ 7:0] byte_mask, input bit [31:0] value, output uvm_status_e status);
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

  m_reg_block.default_path = m_config.default_path;
  // m_reg_block.set_hdl_path_root(.path(m_config.hdl_path_root), .kind("RTL"));
  m_reg_block.add_hdl_path(.path(m_config.hdl_path_root), .kind("RTL"));
  m_reg_block.build();
  m_reg_block.reset("HARD");
endfunction : build_phase

function void register_model::connect_phase(uvm_phase phase);
  // m_reg_block.default_map.set_sequencer(m_config.sequencer, m_adapter);

  m_predictor.map     = m_reg_block.default_map;
  m_predictor.adapter = m_adapter;
endfunction : connect_phase

task register_model::read_reg(input bit [31:0] reg_offset, input bit [ 7:0] byte_mask, output bit [31:0] value, output uvm_status_e status);
  uvm_reg register;

  register = m_reg_block.default_map.get_reg_by_offset(.offset(reg_offset), .read(1));

  if (register != null)
  begin
    register.read(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
  end
  else
  begin
    `uvm_error("read_reg", $sformatf("No register at address: 0x%08h.", reg_offset))

    value   = 'X;
    status  = UVM_NOT_OK;
  end
endtask : read_reg

task register_model::write_reg(input bit [31:0] reg_offset, input bit [ 7:0] byte_mask, input bit [31:0] value, output uvm_status_e status);
  uvm_reg register;

  register = m_reg_block.default_map.get_reg_by_offset(.offset(reg_offset), .read(0));

  if (register != null)
  begin
    register.write(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
  end
  else
  begin
    `uvm_error("read_reg", $sformatf("No register at address: 0x%08h.", reg_offset))

    value   = 'X;
    status  = UVM_NOT_OK;
  end
endtask : write_reg

`endif // _REGISTER_MODEL_SVH_
