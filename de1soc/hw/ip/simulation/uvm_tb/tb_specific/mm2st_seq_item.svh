
`ifndef _MM2ST_SEQ_ITEM_SVH_
`define _MM2ST_SEQ_ITEM_SVH_

class mm2st_seq_item extends avalon_st_seq_item #(avalon_st_inst_specs[MM2ST]);
  `uvm_object_utils(mm2st_seq_item)

  // Standard UVM Methods:
  extern function new(string name = "mm2st_seq_item");
endclass : mm2st_seq_item

function mm2st_seq_item::new(string name = "mm2st_seq_item");
  super.new(name);
endfunction : new

`endif // _MM2ST_SEQ_ITEM_SVH_
