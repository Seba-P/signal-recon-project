
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
  csr_seq_item seq = csr_seq_item::type_id::create("seq");

  `uvm_info("CSR_INIT_CONFIG_SEQ", "*** CSR_INIT_CONFIG_SEQ STARTS ***", UVM_LOW)
  start_item(seq);

  seq.data 			= {};
  seq.burst_len = 10 * (2 * (LVLS_NUM / 2 + 1) + LVLS_NUM + 1);

  finish_item(seq);
  `uvm_info("CSR_INIT_CONFIG_SEQ", "*** CSR_INIT_CONFIG_SEQ ENDS ***", UVM_LOW)
endtask : body

`endif // _CSR_INIT_CONFIG_SEQ_SVH_
