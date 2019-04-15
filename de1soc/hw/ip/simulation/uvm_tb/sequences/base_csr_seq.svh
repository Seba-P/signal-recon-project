
`ifndef _BASE_CSR_SEQ_SVH_
`define _BASE_CSR_SEQ_SVH_

class base_csr_seq extends uvm_sequence #(csr_seq_item);
  `uvm_object_utils(base_csr_seq)

  csr_reg_block_config csr_config;
  register_model       reg_model;

  bit use_register_model = 0;

  // Standard UVM Methods:
  extern function new(string name = "base_csr_seq");
  extern virtual task body();

  // Custom methods:
  extern task read_reg(input bit [31:0] reg_offset, input bit [ 7:0] byte_mask, output bit [31:0] value, output uvm_status_e status);
  extern task write_reg(input bit [31:0] reg_offset, input bit [ 7:0] byte_mask, input bit [31:0] value, output uvm_status_e status);
endclass : base_csr_seq

function base_csr_seq::new(string name = "base_csr_seq");
  super.new(name);
endfunction : new

task base_csr_seq::body();
  csr_reg_block_t csr_reg_block;
  uvm_status_e    status;

  /* Dummy delay */
  #20;
  `uvm_info(get_name().toupper(), $sformatf("*** %s STARTS ***", get_name().toupper()), UVM_LOW)

  csr_reg_block = csr_config.m_csr_reg_block;

  read_reg(CSR_REG_BLOCK_STATUS_START, '1, csr_reg_block.status, status);

  #2;
  `uvm_info(get_name().toupper(), $sformatf("*** %s ENDS ***", get_name().toupper()), UVM_LOW)
endtask : body

task base_csr_seq::read_reg(input bit [31:0] reg_offset, input bit [ 7:0] byte_mask, output bit [31:0] value, output uvm_status_e status);
  if (use_register_model)
  begin
    reg_model.read_reg(reg_offset, byte_mask, value, status);
  end
  else
  begin
    csr_seq_item seq = csr_seq_item::type_id::create("seq");

    start_item(seq);

    seq.operation = READ_OP;
    seq.addr.push_back(reg_offset);
    seq.byteen.push_back(byte_mask);
    seq.burst_len = 1;

    finish_item(seq);

    value   = seq.data.pop_front();
    status  = (seq.resp.pop_front() === 'd0) ? UVM_IS_OK : UVM_NOT_OK;
  end

  if (status == UVM_IS_OK)
    `uvm_info("read_reg", $sformatf("Read operation succeded ('%s'): reg_offset = 0x%08h, byte_mask = 'b%4b, value = 0x%08h.",
                                      status.name(), reg_offset, byte_mask, value), UVM_DEBUG)
  else
    `uvm_error("read_reg", $sformatf("Read operation failed ('%s'): reg_offset = 0x%08h, byte_mask = 'b%4b, value = 0x%08h.",
                                      status.name(), reg_offset, byte_mask, value))
endtask : read_reg

task base_csr_seq::write_reg(input bit [31:0] reg_offset, input bit [ 7:0] byte_mask, input bit [31:0] value, output uvm_status_e status);
  if (use_register_model)
  begin
    reg_model.write_reg(reg_offset, byte_mask, value, status);
  end
  else
  begin
    csr_seq_item seq = csr_seq_item::type_id::create("seq");

    start_item(seq);

    seq.operation = WRITE_OP;
    seq.addr.push_back(reg_offset);
    seq.byteen.push_back(byte_mask);
    seq.data.push_back(value);
    seq.burst_len = 1;

    finish_item(seq);

    status = (seq.resp.pop_front() === 'd0) ? UVM_IS_OK : UVM_NOT_OK;
  end

  if (status == UVM_IS_OK)
    `uvm_info("write_reg", $sformatf("Write operation succeded ('%s'): reg_offset = 0x%08h, byte_mask = 'b%4b, value = 0x%08h.",
                                      status.name(), reg_offset, byte_mask, value), UVM_DEBUG)
  else
    `uvm_error("write_reg", $sformatf("Write operation failed ('%s'): reg_offset = 0x%08h, byte_mask = 'b%4b, value = 0x%08h.",
                                      status.name(), reg_offset, byte_mask, value))
endtask : write_reg

`endif // _BASE_CSR_SEQ_SVH_
