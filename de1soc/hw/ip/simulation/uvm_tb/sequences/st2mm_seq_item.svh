
`ifndef _ST2MM_SEQ_ITEM_SVH_
`define _ST2MM_SEQ_ITEM_SVH_

// class st2mm_seq_item extends uvm_sequence_item;
class st2mm_seq_item extends avalon_st_seq_item #(avalon_st_inst_specs[ST2MM]);
  `uvm_object_utils(st2mm_seq_item)

  logic [15:0] value;

  // Standard UVM Methods:
  extern function new(string name = "st2mm_seq_item");
  // extern function void do_copy(uvm_object rhs);
  // extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  // extern function string convert2string();
endclass : st2mm_seq_item

function st2mm_seq_item::new(string name = "st2mm_seq_item");
  super.new(name);
endfunction : new

// function void st2mm_seq_item::do_copy(uvm_object rhs);
//   st2mm_seq_item seq_item;

//   if (!$cast(seq_item, rhs))
//     `uvm_fatal("do_copy", "Cast of rhs object failed.")

//   super.do_copy(rhs);
//   value = seq_item.value;
// endfunction : do_copy

// function bit st2mm_seq_item::do_compare(uvm_object rhs, uvm_comparer comparer);
//   st2mm_seq_item seq_item;

//   if (!$cast(seq_item, rhs))
//     `uvm_fatal("do_compare", "Cast of rhs object failed.")

//   return (super.do_compare(rhs, comparer) && value == seq_item.value);
// endfunction : do_compare

// function string st2mm_seq_item::convert2string();
//   return $sformatf("%s: 0x%0h", super.convert2string(), value);
// endfunction : convert2string

`endif // _ST2MM_SEQ_ITEM_SVH_
