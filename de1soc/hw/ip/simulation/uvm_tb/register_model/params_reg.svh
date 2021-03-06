
`ifndef _PARAMS_REG_SVH_
`define _PARAMS_REG_SVH_

class params_reg extends uvm_reg;
  `uvm_object_utils(params_reg)

  rand uvm_reg_field lvls_num;
  rand uvm_reg_field _reserved1;
  rand uvm_reg_field init_lvl;
  rand uvm_reg_field _reserved2;
  rand uvm_reg_field iter_num;
  rand uvm_reg_field _reserved3;
  rand uvm_reg_field init_guess;
  rand uvm_reg_field _reserved4;

  // Standard UVM Methods:
  function new(string name = "params_reg");
    super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
  endfunction : new

  virtual function void build();
    lvls_num    = uvm_reg_field::type_id::create("lvls_num");
    _reserved1  = uvm_reg_field::type_id::create("_reserved1");
    init_lvl    = uvm_reg_field::type_id::create("init_lvl");
    _reserved2  = uvm_reg_field::type_id::create("_reserved2");
    iter_num    = uvm_reg_field::type_id::create("iter_num");
    _reserved3  = uvm_reg_field::type_id::create("_reserved3");
    init_guess  = uvm_reg_field::type_id::create("init_guess");
    _reserved4  = uvm_reg_field::type_id::create("_reserved4");

    lvls_num.configure
    (
      .parent                   (this),
      .size                     (CSR_PARAMS_LVLS_NUM_SIZE),
      .lsb_pos                  (CSR_PARAMS_LVLS_NUM_OFFSET),
      .access                   (CSR_PARAMS_LVLS_NUM_ACCESS),
      .volatile                 (CSR_PARAMS_LVLS_NUM_VOLATILE),
      .reset                    (CSR_PARAMS_LVLS_NUM_RESET_VAL),
      .has_reset                (CSR_PARAMS_LVLS_NUM_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    _reserved1.configure
    (
      .parent                   (this),
      .size                     (CSR_PARAMS_RESERVED1_SIZE),
      .lsb_pos                  (CSR_PARAMS_RESERVED1_OFFSET),
      .access                   (CSR_PARAMS_RESERVED1_ACCESS),
      .volatile                 (CSR_PARAMS_RESERVED1_VOLATILE),
      .reset                    (CSR_PARAMS_RESERVED1_RESET_VAL),
      .has_reset                (CSR_PARAMS_RESERVED1_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    init_lvl.configure
    (
      .parent                   (this),
      .size                     (CSR_PARAMS_INIT_LVL_SIZE),
      .lsb_pos                  (CSR_PARAMS_INIT_LVL_OFFSET),
      .access                   (CSR_PARAMS_INIT_LVL_ACCESS),
      .volatile                 (CSR_PARAMS_INIT_LVL_VOLATILE),
      .reset                    (CSR_PARAMS_INIT_LVL_RESET_VAL),
      .has_reset                (CSR_PARAMS_INIT_LVL_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    _reserved2.configure
    (
      .parent                   (this),
      .size                     (CSR_PARAMS_RESERVED2_SIZE),
      .lsb_pos                  (CSR_PARAMS_RESERVED2_OFFSET),
      .access                   (CSR_PARAMS_RESERVED2_ACCESS),
      .volatile                 (CSR_PARAMS_RESERVED2_VOLATILE),
      .reset                    (CSR_PARAMS_RESERVED2_RESET_VAL),
      .has_reset                (CSR_PARAMS_RESERVED2_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    iter_num.configure
    (
      .parent                   (this),
      .size                     (CSR_PARAMS_ITER_NUM_SIZE),
      .lsb_pos                  (CSR_PARAMS_ITER_NUM_OFFSET),
      .access                   (CSR_PARAMS_ITER_NUM_ACCESS),
      .volatile                 (CSR_PARAMS_ITER_NUM_VOLATILE),
      .reset                    (CSR_PARAMS_ITER_NUM_RESET_VAL),
      .has_reset                (CSR_PARAMS_ITER_NUM_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    _reserved3.configure
    (
      .parent                   (this),
      .size                     (CSR_PARAMS_RESERVED3_SIZE),
      .lsb_pos                  (CSR_PARAMS_RESERVED3_OFFSET),
      .access                   (CSR_PARAMS_RESERVED3_ACCESS),
      .volatile                 (CSR_PARAMS_RESERVED3_VOLATILE),
      .reset                    (CSR_PARAMS_RESERVED3_RESET_VAL),
      .has_reset                (CSR_PARAMS_RESERVED3_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    init_guess.configure
    (
      .parent                   (this),
      .size                     (CSR_PARAMS_INIT_GUESS_SIZE),
      .lsb_pos                  (CSR_PARAMS_INIT_GUESS_OFFSET),
      .access                   (CSR_PARAMS_INIT_GUESS_ACCESS),
      .volatile                 (CSR_PARAMS_INIT_GUESS_VOLATILE),
      .reset                    (CSR_PARAMS_INIT_GUESS_RESET_VAL),
      .has_reset                (CSR_PARAMS_INIT_GUESS_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    _reserved4.configure
    (
      .parent                   (this),
      .size                     (CSR_PARAMS_RESERVED4_SIZE),
      .lsb_pos                  (CSR_PARAMS_RESERVED4_OFFSET),
      .access                   (CSR_PARAMS_RESERVED4_ACCESS),
      .volatile                 (CSR_PARAMS_RESERVED4_VOLATILE),
      .reset                    (CSR_PARAMS_RESERVED4_RESET_VAL),
      .has_reset                (CSR_PARAMS_RESERVED4_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    add_hdl_path_slice(.name("params.lvls_num"), .offset(CSR_PARAMS_LVLS_NUM_OFFSET), .size(CSR_PARAMS_LVLS_NUM_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("params._reserved1"), .offset(CSR_PARAMS_RESERVED1_OFFSET), .size(CSR_PARAMS_RESERVED1_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("params.init_lvl"), .offset(CSR_PARAMS_INIT_LVL_OFFSET), .size(CSR_PARAMS_INIT_LVL_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("params._reserved2"), .offset(CSR_PARAMS_RESERVED2_OFFSET), .size(CSR_PARAMS_RESERVED2_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("params.iter_num"), .offset(CSR_PARAMS_ITER_NUM_OFFSET), .size(CSR_PARAMS_ITER_NUM_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("params._reserved3"), .offset(CSR_PARAMS_RESERVED3_OFFSET), .size(CSR_PARAMS_RESERVED3_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("params.init_guess"), .offset(CSR_PARAMS_INIT_GUESS_OFFSET), .size(CSR_PARAMS_INIT_GUESS_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("params._reserved4"), .offset(CSR_PARAMS_RESERVED4_OFFSET), .size(CSR_PARAMS_RESERVED4_SIZE), .kind("RTL"));
  endfunction : build
endclass : params_reg

`endif // _PARAMS_REG_SVH_
