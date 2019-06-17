
`ifndef _POCS_OUT_SEQ_ITEM_SVH_
`define _POCS_OUT_SEQ_ITEM_SVH_

class pocs_out_seq_item extends avalon_st_seq_item #(avalon_st_inst_specs[POCS_OUT]);
  `uvm_object_utils(pocs_out_seq_item)

  // Standard UVM Methods:
  extern function new(string name = "pocs_out_seq_item");
endclass : pocs_out_seq_item

function pocs_out_seq_item::new(string name = "pocs_out_seq_item");
  super.new(name);
endfunction : new

`endif // _POCS_OUT_SEQ_ITEM_SVH_
