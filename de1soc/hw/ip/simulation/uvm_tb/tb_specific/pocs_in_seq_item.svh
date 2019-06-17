
`ifndef _POCS_IN_SEQ_ITEM_SVH_
`define _POCS_IN_SEQ_ITEM_SVH_

class pocs_in_seq_item extends avalon_st_seq_item #(avalon_st_inst_specs[POCS_IN]);
  `uvm_object_utils(pocs_in_seq_item)

  // Standard UVM Methods:
  extern function new(string name = "pocs_in_seq_item");
endclass : pocs_in_seq_item

function pocs_in_seq_item::new(string name = "pocs_in_seq_item");
  super.new(name);
endfunction : new

`endif // _POCS_IN_SEQ_ITEM_SVH_
