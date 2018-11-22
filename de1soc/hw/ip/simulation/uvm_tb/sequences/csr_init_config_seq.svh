
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
  csr_reg_block_t csr_reg_block = csr_config.m_csr_reg_block;
  csr_seq_item    seq = csr_seq_item::type_id::create("seq");

  `uvm_info("CSR_INIT_CONFIG_SEQ", "*** CSR_INIT_CONFIG_SEQ STARTS ***", UVM_LOW)
  start_item(seq);

  seq.clear();
  seq.operation = READ_OP;
  seq.addr.push_back(CSR_REG_BLOCK_STATUS_START);
  seq.byteen.push_back('1);
  seq.burst_len = 1;

  finish_item(seq);

  #5;

  start_item(seq);

  csr_reg_block.control = '{ /*_reserved*/'0, /*init*/'0, /*flush*/'0, /*halt*/'0, /*run*/'0 };
  seq.clear();
  seq.operation = WRITE_OP;
  seq.addr.push_back(CSR_REG_BLOCK_CONTROL_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_reg_block.control));
  seq.burst_len = 1;

  finish_item(seq);

  #5;

  start_item(seq);

  seq.clear();
  seq.operation = WRITE_OP;
  seq.addr.push_back(CSR_REG_BLOCK_PARAMS_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.params));
  seq.burst_len = 1;

  finish_item(seq);

  #5;

  start_item(seq);

  seq.clear();
  seq.operation = WRITE_OP;
  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_00_01_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_00_01));
  seq.burst_len = 1;

  finish_item(seq);

  #5;

  start_item(seq);

  seq.clear();
  seq.operation = WRITE_OP;
  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_02_03_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_02_03));
  seq.burst_len = 1;

  finish_item(seq);

  #5;

  start_item(seq);

  seq.clear();
  seq.operation = WRITE_OP;
  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_04_05_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_04_05));
  seq.burst_len = 1;

  finish_item(seq);

  #5;

  start_item(seq);

  seq.clear();
  seq.operation = WRITE_OP;
  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_06_07_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_06_07));
  seq.burst_len = 1;

  finish_item(seq);

  #5;

  start_item(seq);

  seq.clear();
  seq.operation = WRITE_OP;
  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_08_09_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_08_09));
  seq.burst_len = 1;

  finish_item(seq);

  #5;

  start_item(seq);

  seq.clear();
  seq.operation = WRITE_OP;
  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_10_11_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_10_11));
  seq.burst_len = 1;

  finish_item(seq);

  #5;

  start_item(seq);

  seq.clear();
  seq.operation = WRITE_OP;
  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_12_13_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_12_13));
  seq.burst_len = 1;

  finish_item(seq);

  #5;

  start_item(seq);

  seq.clear();
  seq.operation = WRITE_OP;
  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_14_15_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_14_15));
  seq.burst_len = 1;

  finish_item(seq);

  #5;

  start_item(seq);

  seq.clear();
  seq.operation = WRITE_OP;
  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_16_17_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_16_17));
  seq.burst_len = 1;

  finish_item(seq);

  #5;

  start_item(seq);

  seq.clear();
  seq.operation = WRITE_OP;
  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_18_19_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_18_19));
  seq.burst_len = 1;

  finish_item(seq);

  #5;

  start_item(seq);

  seq.clear();
  seq.operation = WRITE_OP;
  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_20_21_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_20_21));
  seq.burst_len = 1;

  finish_item(seq);

  #5;

  start_item(seq);

  seq.clear();
  seq.operation = WRITE_OP;
  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_22_23_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_22_23));
  seq.burst_len = 1;

  finish_item(seq);

  #5;

  start_item(seq);

  seq.clear();
  seq.operation = WRITE_OP;
  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_24_25_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_24_25));
  seq.burst_len = 1;

  finish_item(seq);

  #5;

  start_item(seq);

  seq.clear();
  seq.operation = WRITE_OP;
  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_26_27_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_26_27));
  seq.burst_len = 1;

  finish_item(seq);

  #5;

  start_item(seq);

  seq.clear();
  seq.operation = WRITE_OP;
  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_28_29_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_28_29));
  seq.burst_len = 1;

  finish_item(seq);

  #5;

  start_item(seq);

  seq.clear();
  seq.operation = WRITE_OP;
  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_30_31_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_30_31));
  seq.burst_len = 1;

  finish_item(seq);

  #5;

  start_item(seq);

  csr_reg_block.control = '{ /*_reserved*/'0, /*init*/'1, /*flush*/'0, /*halt*/'0, /*run*/'0 };
  seq.clear();
  seq.operation = WRITE_OP;
  seq.addr.push_back(CSR_REG_BLOCK_CONTROL_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_reg_block.control));
  seq.burst_len = 1;

  finish_item(seq);

  #15;

  start_item(seq);

  csr_reg_block.control = '{ /*_reserved*/'0, /*init*/'0, /*flush*/'0, /*halt*/'0, /*run*/'1 };
  seq.clear();
  seq.operation = WRITE_OP;
  seq.addr.push_back(CSR_REG_BLOCK_CONTROL_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_reg_block.control));
  seq.burst_len = 1;

  finish_item(seq);

  #5;
  `uvm_info("CSR_INIT_CONFIG_SEQ", "*** CSR_INIT_CONFIG_SEQ ENDS ***", UVM_LOW)
endtask : body

`endif // _CSR_INIT_CONFIG_SEQ_SVH_
