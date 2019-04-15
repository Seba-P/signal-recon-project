
`ifndef _CSR_INIT_CONFIG_SEQ_SVH_
`define _CSR_INIT_CONFIG_SEQ_SVH_

class csr_init_config_seq extends base_csr_seq;
  `uvm_object_utils(csr_init_config_seq)

  // Standard UVM Methods:
  extern function new(string name = "csr_init_config_seq");
  extern virtual task body();
endclass : csr_init_config_seq

function csr_init_config_seq::new(string name = "csr_init_config_seq");
  super.new(name);
endfunction : new

task csr_init_config_seq::body();
  csr_reg_block_t csr_reg_block;
  uvm_status_e    status;

  `uvm_info(get_name().toupper(), $sformatf("*** %s STARTS ***", get_name().toupper()), UVM_LOW)

  csr_reg_block = csr_config.m_csr_reg_block;

  read_reg(CSR_REG_BLOCK_STATUS_START, '1, csr_reg_block.status, status);
  #5;

  csr_reg_block.control = '{ /*_reserved*/'0, /*init*/'0, /*flush*/'0, /*halt*/'0, /*run*/'0 };
  write_reg(CSR_REG_BLOCK_CONTROL_START, '1, csr_reg_block.control, status);
  #5;

  write_reg(CSR_REG_BLOCK_PARAMS_START, '1, csr_reg_block.params, status);
  #5;

  write_reg(CSR_REG_BLOCK_LVL_VAL_00_01_START, '1, csr_reg_block.lvl_val_00_01, status);
  #5;

  write_reg(CSR_REG_BLOCK_LVL_VAL_02_03_START, '1, csr_reg_block.lvl_val_02_03, status);
  #5;

  write_reg(CSR_REG_BLOCK_LVL_VAL_04_05_START, '1, csr_reg_block.lvl_val_04_05, status);
  #5;

  write_reg(CSR_REG_BLOCK_LVL_VAL_06_07_START, '1, csr_reg_block.lvl_val_06_07, status);
  #5;

  write_reg(CSR_REG_BLOCK_LVL_VAL_08_09_START, '1, csr_reg_block.lvl_val_08_09, status);
  #5;

  write_reg(CSR_REG_BLOCK_LVL_VAL_10_11_START, '1, csr_reg_block.lvl_val_10_11, status);
  #5;

  write_reg(CSR_REG_BLOCK_LVL_VAL_12_13_START, '1, csr_reg_block.lvl_val_12_13, status);
  #5;

  write_reg(CSR_REG_BLOCK_LVL_VAL_14_15_START, '1, csr_reg_block.lvl_val_14_15, status);
  #5;

  write_reg(CSR_REG_BLOCK_LVL_VAL_16_17_START, '1, csr_reg_block.lvl_val_16_17, status);
  #5;

  write_reg(CSR_REG_BLOCK_LVL_VAL_18_19_START, '1, csr_reg_block.lvl_val_18_19, status);
  #5;

  write_reg(CSR_REG_BLOCK_LVL_VAL_20_21_START, '1, csr_reg_block.lvl_val_20_21, status);
  #5;

  write_reg(CSR_REG_BLOCK_LVL_VAL_22_23_START, '1, csr_reg_block.lvl_val_22_23, status);
  #5;

  write_reg(CSR_REG_BLOCK_LVL_VAL_24_25_START, '1, csr_reg_block.lvl_val_24_25, status);
  #5;

  write_reg(CSR_REG_BLOCK_LVL_VAL_26_27_START, '1, csr_reg_block.lvl_val_26_27, status);
  #5;

  write_reg(CSR_REG_BLOCK_LVL_VAL_28_29_START, '1, csr_reg_block.lvl_val_28_29, status);
  #5;

  write_reg(CSR_REG_BLOCK_LVL_VAL_30_31_START, '1, csr_reg_block.lvl_val_30_31, status);
  #5;

  csr_reg_block.control = '{ /*_reserved*/'0, /*init*/'1, /*flush*/'0, /*halt*/'0, /*run*/'0 };
  write_reg(CSR_REG_BLOCK_CONTROL_START, '1, csr_reg_block.control, status);
  #5;

  csr_reg_block.control = '{ /*_reserved*/'0, /*init*/'0, /*flush*/'0, /*halt*/'0, /*run*/'1 };
  write_reg(CSR_REG_BLOCK_CONTROL_START, '1, csr_reg_block.control, status);
  #5;

  `uvm_info(get_name().toupper(), $sformatf("*** %s ENDS ***", get_name().toupper()), UVM_LOW)
endtask : body

`endif // _CSR_INIT_CONFIG_SEQ_SVH_
