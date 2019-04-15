
`ifndef _STATUS_REG_SVH_
`define _STATUS_REG_SVH_

class status_reg extends uvm_reg;
  `uvm_object_utils(status_reg)

  rand uvm_reg_field busy;
  rand uvm_reg_field ready;
  rand uvm_reg_field error;
  rand uvm_reg_field _reserved1;
  rand uvm_reg_field fifo_err;
  rand uvm_reg_field _reserved2;

  // Standard UVM Methods:
  function new(string name = "status_reg");
    super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
  endfunction : new

  virtual function void build();
    busy        = uvm_reg_field::type_id::create("busy");
    ready       = uvm_reg_field::type_id::create("ready");
    error       = uvm_reg_field::type_id::create("error");
    _reserved1  = uvm_reg_field::type_id::create("_reserved1");
    fifo_err    = uvm_reg_field::type_id::create("fifo_err");
    _reserved2  = uvm_reg_field::type_id::create("_reserved2");

    busy.configure
    (
      .parent                   (this),
      .size                     (CSR_STATUS_BUSY_SIZE),
      .lsb_pos                  (CSR_STATUS_BUSY_OFFSET),
      .access                   (CSR_STATUS_BUSY_ACCESS),
      .volatile                 (CSR_STATUS_BUSY_VOLATILE),
      .reset                    (CSR_STATUS_BUSY_RESET_VAL),
      .has_reset                (CSR_STATUS_BUSY_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    ready.configure
    (
      .parent                   (this),
      .size                     (CSR_STATUS_READY_SIZE),
      .lsb_pos                  (CSR_STATUS_READY_OFFSET),
      .access                   (CSR_STATUS_READY_ACCESS),
      .volatile                 (CSR_STATUS_READY_VOLATILE),
      .reset                    (CSR_STATUS_READY_RESET_VAL),
      .has_reset                (CSR_STATUS_READY_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    error.configure
    (
      .parent                   (this),
      .size                     (CSR_STATUS_ERROR_SIZE),
      .lsb_pos                  (CSR_STATUS_ERROR_OFFSET),
      .access                   (CSR_STATUS_ERROR_ACCESS),
      .volatile                 (CSR_STATUS_ERROR_VOLATILE),
      .reset                    (CSR_STATUS_ERROR_RESET_VAL),
      .has_reset                (CSR_STATUS_ERROR_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    _reserved1.configure
    (
      .parent                   (this),
      .size                     (CSR_STATUS_RESERVED1_SIZE),
      .lsb_pos                  (CSR_STATUS_RESERVED1_OFFSET),
      .access                   (CSR_STATUS_RESERVED1_ACCESS),
      .volatile                 (CSR_STATUS_RESERVED1_VOLATILE),
      .reset                    (CSR_STATUS_RESERVED1_RESET_VAL),
      .has_reset                (CSR_STATUS_RESERVED1_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    fifo_err.configure
    (
      .parent                   (this),
      .size                     (CSR_STATUS_FIFO_ERR_SIZE),
      .lsb_pos                  (CSR_STATUS_FIFO_ERR_OFFSET),
      .access                   (CSR_STATUS_FIFO_ERR_ACCESS),
      .volatile                 (CSR_STATUS_FIFO_ERR_VOLATILE),
      .reset                    (CSR_STATUS_FIFO_ERR_RESET_VAL),
      .has_reset                (CSR_STATUS_FIFO_ERR_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    _reserved2.configure
    (
      .parent                   (this),
      .size                     (CSR_STATUS_RESERVED2_SIZE),
      .lsb_pos                  (CSR_STATUS_RESERVED2_OFFSET),
      .access                   (CSR_STATUS_RESERVED2_ACCESS),
      .volatile                 (CSR_STATUS_RESERVED2_VOLATILE),
      .reset                    (CSR_STATUS_RESERVED2_RESET_VAL),
      .has_reset                (CSR_STATUS_RESERVED2_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    add_hdl_path_slice(.name("status.busy"), .offset(CSR_STATUS_BUSY_OFFSET), .size(CSR_STATUS_BUSY_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("status.ready"), .offset(CSR_STATUS_READY_OFFSET), .size(CSR_STATUS_READY_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("status.error"), .offset(CSR_STATUS_ERROR_OFFSET), .size(CSR_STATUS_ERROR_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("status._reserved1"), .offset(CSR_STATUS_RESERVED1_OFFSET), .size(CSR_STATUS_RESERVED1_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("status.fifo_err"), .offset(CSR_STATUS_FIFO_ERR_OFFSET), .size(CSR_STATUS_FIFO_ERR_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("status._reserved2"), .offset(CSR_STATUS_RESERVED2_OFFSET), .size(CSR_STATUS_RESERVED2_SIZE), .kind("RTL"));
  endfunction : build
endclass : status_reg

`endif // _STATUS_REG_SVH_
