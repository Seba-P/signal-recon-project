
`ifndef _CSR_REG_BLOCK_ADAPTER_SVH_
`define _CSR_REG_BLOCK_ADAPTER_SVH_

class csr_reg_block_adapter extends uvm_reg_adapter;
  `uvm_object_utils(csr_reg_block_adapter)

  // Standard UVM Methods:
  extern function new(string name = "csr_reg_block_adapter");
  extern virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
  extern virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
 
  endfunction : build
endclass : csr_reg_block_adapter

function csr_reg_block_adapter::new(string name = "csr_reg_block_adapter");
  super.new(.name(name));
endfunction : new

function uvm_sequence_item csr_reg_block_adapter::reg2bus(const ref uvm_reg_bus_op rw);
  csr_seq_item seq_item = csr_seq_item::type_id::create("seq_item");

  if (rw.kind == UVM_WRITE)
     seq_item.operation = WRITE_OP;
  else
     seq_item.operation = READ_OP;
        
  seq_item.addr       = { rw.addr };
  seq_item.byteen     = { rw.byte_en };
  seq_item.data       = { rw.data };
  seq_item.burst_len  = 1;
  
  return seq_item;
endfunction
    
function void csr_reg_block_adapter::bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
  csr_seq_item seq_item;
        
  if (!$cast(seq_item, bus_item))
    `uvm_fatal("bus2reg", "Cast of 'bus_item' object failed.")

  if (seq_item.operation == WRITE_OP)
    rw.kind = UVM_WRITE;
  else
    rw.kind = UVM_READ;

  rw.addr    = seq_item.addr.pop_front();
  // seq_item.addr.push_front(rw.addr);
  rw.byte_en = seq_item.byteen.pop_front();
  // seq_item.byteen.push_front(rw.byte_en);
  rw.data    = seq_item.data.pop_front();
  // seq_item.data.push_front(rw.data);
  rw.status  = UVM_IS_OK;
endfunction

`endif // _CSR_REG_BLOCK_ADAPTER_SVH_
