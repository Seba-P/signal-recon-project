
`ifndef _BASE_CSR_SEQ_SVH_
`define _BASE_CSR_SEQ_SVH_

class base_csr_seq extends uvm_sequence #(csr_seq_item);
	`uvm_object_utils(base_csr_seq)

  csr_reg_block_config csr_config;

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

  seq.operation = READ_OP;
  seq.addr.push_back(CSR_REG_BLOCK_STATUS_START);
  seq.byteen.push_back('1);
  seq.burst_len = 1;

  finish_item(seq);

  #2;
  `uvm_info("BASE_CSR_SEQ", "*** BASE_CSR_SEQ ENDS ***", UVM_LOW)

endtask : body

`endif // _BASE_CSR_SEQ_SVH_
