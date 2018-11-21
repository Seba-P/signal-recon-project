
`ifndef _CSR_REG_BLOCK_CONFIG_SVH_
`define _CSR_REG_BLOCK_CONFIG_SVH_

class csr_reg_block_config extends uvm_object;
  `uvm_object_utils(csr_reg_block_config)

  csr_reg_block_t m_csr_reg_block;

  // Standard UVM Methods:
  extern function new(string name = "csr_reg_block_config");
endclass : csr_reg_block_config

function csr_reg_block_config::new(string name = "csr_reg_block_config");
  super.new(name);
endfunction : new

`endif // _CSR_REG_BLOCK_CONFIG_SVH_
