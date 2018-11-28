
`ifndef _CONTROL_REG_SVH_
`define _CONTROL_REG_SVH_

class control_reg extends uvm_reg;
  `uvm_object_utils(control_reg)

  rand uvm_reg_field run;
  rand uvm_reg_field halt;
  rand uvm_reg_field flush;
  rand uvm_reg_field init;
  rand uvm_reg_field _reserved1;

  // Standard UVM Methods:
  function new(string name = "control_reg");
    super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
  endfunction : new

  virtual function void build();
    run         = uvm_reg_field::type_id::create("run");
    halt        = uvm_reg_field::type_id::create("halt");
    flush       = uvm_reg_field::type_id::create("flush");
    init        = uvm_reg_field::type_id::create("init");
    _reserved1  = uvm_reg_field::type_id::create("_reserved1");

    run.configure
    (
      .parent                   (this),
      .size                     (CSR_CONTROL_RUN_SIZE),
      .lsb_pos                  (CSR_CONTROL_RUN_OFFSET),
      .access                   (CSR_CONTROL_RUN_ACCESS),
      .volatile                 (CSR_CONTROL_RUN_VOLATILE),
      .reset                    (CSR_CONTROL_RUN_RESET_VAL),
      .has_reset                (CSR_CONTROL_RUN_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    halt.configure
    (
      .parent                   (this),
      .size                     (CSR_CONTROL_HALT_SIZE),
      .lsb_pos                  (CSR_CONTROL_HALT_OFFSET),
      .access                   (CSR_CONTROL_HALT_ACCESS),
      .volatile                 (CSR_CONTROL_HALT_VOLATILE),
      .reset                    (CSR_CONTROL_HALT_RESET_VAL),
      .has_reset                (CSR_CONTROL_HALT_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    flush.configure
    (
      .parent                   (this),
      .size                     (CSR_CONTROL_FLUSH_SIZE),
      .lsb_pos                  (CSR_CONTROL_FLUSH_OFFSET),
      .access                   (CSR_CONTROL_FLUSH_ACCESS),
      .volatile                 (CSR_CONTROL_FLUSH_VOLATILE),
      .reset                    (CSR_CONTROL_FLUSH_RESET_VAL),
      .has_reset                (CSR_CONTROL_FLUSH_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    init.configure
    (
      .parent                   (this),
      .size                     (CSR_CONTROL_INIT_SIZE),
      .lsb_pos                  (CSR_CONTROL_INIT_OFFSET),
      .access                   (CSR_CONTROL_INIT_ACCESS),
      .volatile                 (CSR_CONTROL_INIT_VOLATILE),
      .reset                    (CSR_CONTROL_INIT_RESET_VAL),
      .has_reset                (CSR_CONTROL_INIT_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    _reserved1.configure
    (
      .parent                   (this),
      .size                     (CSR_CONTROL_RESERVED1_SIZE),
      .lsb_pos                  (CSR_CONTROL_RESERVED1_OFFSET),
      .access                   (CSR_CONTROL_RESERVED1_ACCESS),
      .volatile                 (CSR_CONTROL_RESERVED1_VOLATILE),
      .reset                    (CSR_CONTROL_RESERVED1_RESET_VAL),
      .has_reset                (CSR_CONTROL_RESERVED1_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );
  endfunction : build
endclass : control_reg

`endif // _CONTROL_REG_SVH_
