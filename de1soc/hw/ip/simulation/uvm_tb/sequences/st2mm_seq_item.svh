
`ifndef _ST2MM_SEQ_ITEM_SVH_
`define _ST2MM_SEQ_ITEM_SVH_

class st2mm_seq_item extends avalon_st_seq_item #(avalon_st_inst_specs[ST2MM]);
  `uvm_object_utils(st2mm_seq_item)

  // Standard UVM Methods:
  extern function new(string name = "st2mm_seq_item");
endclass : st2mm_seq_item

function st2mm_seq_item::new(string name = "st2mm_seq_item");
  super.new(name);
endfunction : new

`endif // _ST2MM_SEQ_ITEM_SVH_
