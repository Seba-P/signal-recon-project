
`ifndef _CSR_SEQ_ITEM_SVH_
`define _CSR_SEQ_ITEM_SVH_

class csr_seq_item extends avalon_mm_seq_item #(avalon_mm_inst_specs[CSR]);
  `uvm_object_utils(csr_seq_item)

  // Standard UVM Methods:
  extern function new(string name = "csr_seq_item");
endclass : csr_seq_item

function csr_seq_item::new(string name = "csr_seq_item");
  super.new(name);
endfunction : new

`endif // _CSR_SEQ_ITEM_SVH_
