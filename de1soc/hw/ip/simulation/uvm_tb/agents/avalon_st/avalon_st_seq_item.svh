
`ifndef _AVALON_ST_SEQ_ITEM_SVH_
`define _AVALON_ST_SEQ_ITEM_SVH_

class avalon_st_seq_item #(avalon_st_inst_spec_t INST_SPEC) extends uvm_sequence_item;
  `uvm_object_param_utils(avalon_st_seq_item #(INST_SPEC))

  rand bit [INST_SPEC.BUS_WIDTH-1:0]  data[$];
  rand int                            burst_len;

  constraint burst_length
  {
    data.size() == burst_len;
  }

  // Standard UVM Methods:
  extern function new(string name = "avalon_st_seq_item");
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function string convert2string();
endclass : avalon_st_seq_item

function avalon_st_seq_item::new(string name = "avalon_st_seq_item");
  super.new(name);
endfunction : new

function void avalon_st_seq_item::do_copy(uvm_object rhs);
  avalon_st_seq_item #(INST_SPEC) seq_item;

  if (!$cast(seq_item, rhs))
    `uvm_fatal("do_copy", "Cast of rhs object failed.")

  super.do_copy(rhs);
  data      = seq_item.data;
  burst_len = seq_item.burst_len;
endfunction : do_copy

function bit avalon_st_seq_item::do_compare(uvm_object rhs, uvm_comparer comparer);
  avalon_st_seq_item #(INST_SPEC) seq_item;

  if (!$cast(seq_item, rhs))
    `uvm_fatal("do_compare", "Cast of rhs object failed.")

  return (super.do_compare(rhs, comparer) && data == seq_item.data);
endfunction : do_compare

function string avalon_st_seq_item::convert2string();
  bit [INST_SPEC.BUS_WIDTH-1:0] data_queue[$];
  bit [INST_SPEC.BUS_WIDTH-1:0] trans_data;
  string s;
  int i;

  data_queue = { data };

  $sformat(s, "%0d transfers: (radix hex) [ ", data_queue.size());
  while (data_queue.size())
  begin
    trans_data = data_queue.pop_front();

    for (i = INST_SPEC.BUS_WIDTH / 4; i > 0; i--)
      $sformat(s, "%s%01h", s, (trans_data >> 4*(i-1)) & 4'hF);

    $sformat(s, "%s ", s);
  end
  $sformat(s, "%s]", s);

  return s;
endfunction : convert2string

`endif // _AVALON_ST_SEQ_ITEM_SVH_
