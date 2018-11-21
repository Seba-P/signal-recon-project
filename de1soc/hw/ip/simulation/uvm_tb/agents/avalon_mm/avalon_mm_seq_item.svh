
`ifndef _AVALON_MM_SEQ_ITEM_SVH_
`define _AVALON_MM_SEQ_ITEM_SVH_

class avalon_mm_seq_item #(avalon_mm_inst_spec_t INST_SPEC) extends uvm_sequence_item;
  `uvm_object_param_utils(avalon_mm_seq_item #(INST_SPEC))

  rand operation_e                          operation;
  rand bit       [INST_SPEC.ADDR_WIDTH-1:0] addr[$];
  rand bit   [(INST_SPEC.DATA_WIDTH/8)-1:0] byteen[$];
  rand logic     [INST_SPEC.DATA_WIDTH-1:0] data[$];
  logic                              [ 1:0] resp[$];
  rand int                                  burst_len;

  constraint burst_length
  {
    data.size() == burst_len;
  }

  // Standard UVM Methods:
  extern function new(string name = "avalon_mm_seq_item");
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function string convert2string();

  // Custom methods:
  extern function void clear();
endclass : avalon_mm_seq_item

function avalon_mm_seq_item::new(string name = "avalon_mm_seq_item");
  super.new(name);
endfunction : new

function void avalon_mm_seq_item::do_copy(uvm_object rhs);
  avalon_mm_seq_item #(INST_SPEC) seq_item;

  if (!$cast(seq_item, rhs))
    `uvm_fatal("do_copy", "Cast of rhs object failed.")

  super.do_copy(rhs);
  data      = seq_item.data;
  burst_len = seq_item.burst_len;
endfunction : do_copy

function bit avalon_mm_seq_item::do_compare(uvm_object rhs, uvm_comparer comparer);
  avalon_mm_seq_item #(INST_SPEC) seq_item;

  if (!$cast(seq_item, rhs))
    `uvm_fatal("do_compare", "Cast of rhs object failed.")

  return (super.do_compare(rhs, comparer) && data == seq_item.data);
endfunction : do_compare

function string avalon_mm_seq_item::convert2string();
  logic [INST_SPEC.DATA_WIDTH-1:0]  data_queue[$];
  bit   [INST_SPEC.DATA_WIDTH-1:0]  trans_data;
  bit   [INST_SPEC.ADDR_WIDTH-1:0]  trans_addr;
  string s;
  int i;

  data_queue = { data };
  trans_addr = addr.pop_front(); // TODO: support multi addr transactions
  addr.push_front(trans_addr);

  $sformat(s, "%s operation with %0d transfers @ addr 0x%08h: (radix hex) [ ",
              operation == READ_OP ? "read" : "write", data_queue.size(), trans_addr);
  while (data_queue.size())
  begin
    trans_data = data_queue.pop_front();

    for (i = INST_SPEC.DATA_WIDTH / 4; i > 0; i--)
      $sformat(s, "%s%01h", s, (trans_data >> 4*(i-1)) & 4'hF);

    $sformat(s, "%s ", s);
  end
  $sformat(s, "%s]", s);

  return s;
endfunction : convert2string

function void avalon_mm_seq_item::clear();
  addr      = {};
  byteen    = {};
  data      = {};
  resp      = {};
  burst_len = 0;
endfunction : clear

`endif // _AVALON_MM_SEQ_ITEM_SVH_
