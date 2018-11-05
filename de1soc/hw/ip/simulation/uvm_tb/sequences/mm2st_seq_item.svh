
`ifndef _MM2ST_SEQ_ITEM_SVH_
`define _MM2ST_SEQ_ITEM_SVH_

// class mm2st_seq_item extends uvm_sequence_item;
class mm2st_seq_item extends avalon_st_seq_item #(avalon_st_inst_specs[MM2ST]);
  `uvm_object_utils(mm2st_seq_item)

  rand lvl_cross_sample_t sample;

  // Standard UVM Methods:
  extern function new(string name = "mm2st_seq_item");
  // extern function void do_copy(uvm_object rhs);
  // extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  // extern function string convert2string();
endclass : mm2st_seq_item

function mm2st_seq_item::new(string name = "mm2st_seq_item");
  super.new(name);
endfunction : new

// function void mm2st_seq_item::do_copy(uvm_object rhs);
//   mm2st_seq_item  seq_item;

//   if (!$cast(seq_item, rhs))
//     `uvm_fatal("do_copy", "Cast of rhs object failed.")

//   super.do_copy(rhs);
//   data = seq_item.data;
// endfunction : do_copy

// function bit mm2st_seq_item::do_compare(uvm_object rhs, uvm_comparer comparer);
//   mm2st_seq_item  seq_item;

//   if (!$cast(seq_item, rhs))
//     `uvm_fatal("do_compare", "Cast of rhs object failed.")

//   return (super.do_compare(rhs, comparer) && data[0] == 16'(sample));
// endfunction : do_compare

// function string mm2st_seq_item::convert2string();
//   return $sformatf("%s: %s::%0d [0x%0h]", super.convert2string(), sample.lvl_cross_dir.name(), sample.timestamp, 16'(sample));
// endfunction : convert2string

`endif // _MM2ST_SEQ_ITEM_SVH_
