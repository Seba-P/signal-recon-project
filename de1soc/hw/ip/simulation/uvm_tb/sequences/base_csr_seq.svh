
`ifndef _BASE_CSR_SEQ_SVH_
`define _BASE_CSR_SEQ_SVH_

typedef avalon_mm_sequencer #(avalon_mm_inst_specs[CSR]) csr_sequencer;

class base_csr_seq extends uvm_sequence #(csr_seq_item);
	`uvm_object_utils(base_csr_seq)

  csr_reg_block_config csr_config = { 0 };

	// Standard UVM Methods:
	extern function new(string name = "base_csr_seq");
	extern virtual task body();
endclass : base_csr_seq

function base_csr_seq::new(string name = "base_csr_seq");
  super.new(name);
endfunction : new

task base_csr_seq::body();
  csr_seq_item seq = csr_seq_item::type_id::create("seq");

  /* Dummy delay */
  #20;

  `uvm_info("BASE_CSR_SEQ", "*** BASE_CSR_SEQ STARTS ***", UVM_LOW)
  start_item(seq);

  seq.addr.push_back(CSR_REG_BLOCK_CONTROL_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.control));

  seq.addr.push_back(CSR_REG_BLOCK_PARAMS_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.params));

  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_00_01_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_00_01));

  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_02_03_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_02_03));

  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_04_05_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_04_05));

  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_06_07_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_06_07));

  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_08_09_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_08_09));

  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_10_11_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_10_11));

  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_12_13_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_12_13));

  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_14_15_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_14_15));

  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_16_17_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_16_17));

  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_18_19_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_18_19));

  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_20_21_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_20_21));

  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_22_23_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_22_23));

  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_24_25_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_24_25));

  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_26_27_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_26_27));

  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_28_29_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_28_29));

  seq.addr.push_back(CSR_REG_BLOCK_LVL_VAL_30_31_START);
  seq.byteen.push_back('1);
  seq.data.push_back(32'(csr_config.m_csr_reg_block.lvl_val_30_31));

  finish_item(seq);
  `uvm_info("BASE_CSR_SEQ", "*** BASE_CSR_SEQ ENDS ***", UVM_LOW)

endtask : body

`endif // _BASE_CSR_SEQ_SVH_
