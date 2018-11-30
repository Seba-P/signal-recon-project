
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

  m_reg_block.build();
  m_reg_block.reset("HARD");
endfunction : build_phase

function void register_model::connect_phase(uvm_phase phase);
  // m_reg_block.default_map.set_sequencer(m_config.sequencer, m_adapter);

  m_predictor.map     = m_reg_block.default_map;
  m_predictor.adapter = m_adapter;
endfunction : connect_phase

task register_model::read_reg(input bit [31:0] reg_offset, input bit [ 7:0] byte_mask, output bit [31:0] value, output uvm_status_e status);
  case (reg_offset)
    CSR_REG_BLOCK_STATUS_OFFSET:
    begin
      m_reg_block.status.read(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_CONTROL_OFFSET:
    begin
      m_reg_block.control.read(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_PARAMS_OFFSET:
    begin
      m_reg_block.params.read(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_00_01_OFFSET:
    begin
      m_reg_block.lvl_val_00_01.read(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_02_03_OFFSET:
    begin
      m_reg_block.lvl_val_02_03.read(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_04_05_OFFSET:
    begin
      m_reg_block.lvl_val_04_05.read(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_06_07_OFFSET:
    begin
      m_reg_block.lvl_val_06_07.read(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_08_09_OFFSET:
    begin
      m_reg_block.lvl_val_08_09.read(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_10_11_OFFSET:
    begin
      m_reg_block.lvl_val_10_11.read(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_12_13_OFFSET:
    begin
      m_reg_block.lvl_val_12_13.read(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_14_15_OFFSET:
    begin
      m_reg_block.lvl_val_14_15.read(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_16_17_OFFSET:
    begin
      m_reg_block.lvl_val_16_17.read(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_18_19_OFFSET:
    begin
      m_reg_block.lvl_val_18_19.read(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_20_21_OFFSET:
    begin
      m_reg_block.lvl_val_20_21.read(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_22_23_OFFSET:
    begin
      m_reg_block.lvl_val_22_23.read(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_24_25_OFFSET:
    begin
      m_reg_block.lvl_val_24_25.read(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_26_27_OFFSET:
    begin
      m_reg_block.lvl_val_26_27.read(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_28_29_OFFSET:
    begin
      m_reg_block.lvl_val_28_29.read(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_30_31_OFFSET:
    begin
      m_reg_block.lvl_val_30_31.read(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    default:
    begin
      `uvm_error("read_reg", $sformatf("No register at address: 0x%08h.", reg_offset))

      value   = 'X;
      status  = UVM_NOT_OK;
    end
  endcase
endtask : read_reg

task register_model::write_reg(input bit [31:0] reg_offset, input bit [ 7:0] byte_mask, input bit [31:0] value, output uvm_status_e status);
  case (reg_offset)
    CSR_REG_BLOCK_STATUS_OFFSET:
    begin
      m_reg_block.status.write(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_CONTROL_OFFSET:
    begin
      m_reg_block.control.write(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_PARAMS_OFFSET:
    begin
      m_reg_block.params.write(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_00_01_OFFSET:
    begin
      m_reg_block.lvl_val_00_01.write(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_02_03_OFFSET:
    begin
      m_reg_block.lvl_val_02_03.write(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_04_05_OFFSET:
    begin
      m_reg_block.lvl_val_04_05.write(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_06_07_OFFSET:
    begin
      m_reg_block.lvl_val_06_07.write(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_08_09_OFFSET:
    begin
      m_reg_block.lvl_val_08_09.write(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_10_11_OFFSET:
    begin
      m_reg_block.lvl_val_10_11.write(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_12_13_OFFSET:
    begin
      m_reg_block.lvl_val_12_13.write(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_14_15_OFFSET:
    begin
      m_reg_block.lvl_val_14_15.write(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_16_17_OFFSET:
    begin
      m_reg_block.lvl_val_16_17.write(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_18_19_OFFSET:
    begin
      m_reg_block.lvl_val_18_19.write(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_20_21_OFFSET:
    begin
      m_reg_block.lvl_val_20_21.write(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_22_23_OFFSET:
    begin
      m_reg_block.lvl_val_22_23.write(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_24_25_OFFSET:
    begin
      m_reg_block.lvl_val_24_25.write(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_26_27_OFFSET:
    begin
      m_reg_block.lvl_val_26_27.write(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_28_29_OFFSET:
    begin
      m_reg_block.lvl_val_28_29.write(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    CSR_REG_BLOCK_LVL_VAL_30_31_OFFSET:
    begin
      m_reg_block.lvl_val_30_31.write(.status(status), .value(value), .path(UVM_DEFAULT_PATH), .parent(null));
    end

    default:
    begin
      `uvm_error("write_reg", $sformatf("No register at address: 0x%08h.", reg_offset))

      status  = UVM_NOT_OK;
    end
  endcase
endtask : write_reg

`endif // _REGISTER_MODEL_SVH_
