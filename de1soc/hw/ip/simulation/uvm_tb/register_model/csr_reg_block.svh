
`ifndef _CSR_REG_BLOCK_SVH_
`define _CSR_REG_BLOCK_SVH_

class csr_reg_block extends uvm_reg_block;
  `uvm_object_utils(csr_reg_block)

  rand status_reg         status;
  rand control_reg        control;
  rand params_reg         params;
  rand lvl_val_00_01_reg  lvl_val_00_01;
  rand lvl_val_02_03_reg  lvl_val_02_03;
  rand lvl_val_04_05_reg  lvl_val_04_05;
  rand lvl_val_06_07_reg  lvl_val_06_07;
  rand lvl_val_08_09_reg  lvl_val_08_09;
  rand lvl_val_10_11_reg  lvl_val_10_11;
  rand lvl_val_12_13_reg  lvl_val_12_13;
  rand lvl_val_14_15_reg  lvl_val_14_15;
  rand lvl_val_16_17_reg  lvl_val_16_17;
  rand lvl_val_18_19_reg  lvl_val_18_19;
  rand lvl_val_20_21_reg  lvl_val_20_21;
  rand lvl_val_22_23_reg  lvl_val_22_23;
  rand lvl_val_24_25_reg  lvl_val_24_25;
  rand lvl_val_26_27_reg  lvl_val_26_27;
  rand lvl_val_28_29_reg  lvl_val_28_29;
  rand lvl_val_30_31_reg  lvl_val_30_31;

  uvm_reg_map             reg_map;

  // Standard UVM Methods:
  function new(string name = "csr_reg_block");
    super.new(.name(name), .has_coverage(UVM_NO_COVERAGE));
  endfunction : new

  virtual function void build();
    reg_map = uvm_reg_map::type_id::create("reg_map");
    // reg_map.create_map(.name("reg_map"), .base_addr(CSR_REG_BLOCK_START), .n_bytes(4), .endian(UVM_LITTLE_ENDIAN));
    reg_map.create_map(.name("reg_map"), .base_addr(8'h00), .n_bytes(1), .endian(UVM_LITTLE_ENDIAN));

    status = uvm_reg::type_id::create("status");
    status.configure(.blk_parent(this));
    status.build();

    reg_map.add_reg
    (
      .rg     (status),
      .offset (CSR_REG_BLOCK_STATUS_OFFSET),
      .rights (CSR_REG_BLOCK_STATUS_ACCESS)
    );

    control = uvm_reg::type_id::create("control");
    control.configure(.blk_parent(this));
    control.build();

    reg_map.add_reg
    (
      .rg     (control),
      .offset (CSR_REG_BLOCK_CONTROL_OFFSET),
      .rights (CSR_REG_BLOCK_CONTROL_ACCESS)
    );

    params = uvm_reg::type_id::create("params");
    params.configure(.blk_parent(this));
    params.build();

    reg_map.add_reg
    (
      .rg     (params),
      .offset (CSR_REG_BLOCK_PARAMS_OFFSET),
      .rights (CSR_REG_BLOCK_PARAMS_ACCESS)
    );

    lvl_val_00_01 = uvm_reg::type_id::create("lvl_val_00_01");
    lvl_val_00_01.configure(.blk_parent(this));
    lvl_val_00_01.build();

    reg_map.add_reg
    (
      .rg     (lvl_val_00_01),
      .offset (CSR_REG_BLOCK_LVL_VAL_00_01_OFFSET),
      .rights (CSR_REG_BLOCK_LVL_VAL_00_01_ACCESS)
    );

    lvl_val_02_03 = uvm_reg::type_id::create("lvl_val_02_03");
    lvl_val_02_03.configure(.blk_parent(this));
    lvl_val_02_03.build();

    reg_map.add_reg
    (
      .rg     (lvl_val_02_03),
      .offset (CSR_REG_BLOCK_LVL_VAL_02_03_OFFSET),
      .rights (CSR_REG_BLOCK_LVL_VAL_02_03_ACCESS)
    );
    
    lvl_val_04_05 = uvm_reg::type_id::create("lvl_val_04_05");
    lvl_val_04_05.configure(.blk_parent(this));
    lvl_val_04_05.build();

    reg_map.add_reg
    (
      .rg     (lvl_val_04_05),
      .offset (CSR_REG_BLOCK_LVL_VAL_04_05_OFFSET),
      .rights (CSR_REG_BLOCK_LVL_VAL_04_05_ACCESS)
    );

    lvl_val_06_07 = uvm_reg::type_id::create("lvl_val_06_07");
    lvl_val_06_07.configure(.blk_parent(this));
    lvl_val_06_07.build();

    reg_map.add_reg
    (
      .rg     (lvl_val_06_07),
      .offset (CSR_REG_BLOCK_LVL_VAL_06_07_OFFSET),
      .rights (CSR_REG_BLOCK_LVL_VAL_06_07_ACCESS)
    );

    lvl_val_08_09 = uvm_reg::type_id::create("lvl_val_08_09");
    lvl_val_08_09.configure(.blk_parent(this));
    lvl_val_08_09.build();

    reg_map.add_reg
    (
      .rg     (lvl_val_08_09),
      .offset (CSR_REG_BLOCK_LVL_VAL_08_09_OFFSET),
      .rights (CSR_REG_BLOCK_LVL_VAL_08_09_ACCESS)
    );

    lvl_val_10_11 = uvm_reg::type_id::create("lvl_val_10_11");
    lvl_val_10_11.configure(.blk_parent(this));
    lvl_val_10_11.build();

    reg_map.add_reg
    (
      .rg     (lvl_val_10_11),
      .offset (CSR_REG_BLOCK_LVL_VAL_10_11_OFFSET),
      .rights (CSR_REG_BLOCK_LVL_VAL_10_11_ACCESS)
    );

    lvl_val_12_13 = uvm_reg::type_id::create("lvl_val_12_13");
    lvl_val_12_13.configure(.blk_parent(this));
    lvl_val_12_13.build();

    reg_map.add_reg
    (
      .rg     (lvl_val_12_13),
      .offset (CSR_REG_BLOCK_LVL_VAL_12_13_OFFSET),
      .rights (CSR_REG_BLOCK_LVL_VAL_12_13_ACCESS)
    );

    lvl_val_14_15 = uvm_reg::type_id::create("lvl_val_14_15");
    lvl_val_14_15.configure(.blk_parent(this));
    lvl_val_14_15.build();

    reg_map.add_reg
    (
      .rg     (lvl_val_14_15),
      .offset (CSR_REG_BLOCK_LVL_VAL_14_15_OFFSET),
      .rights (CSR_REG_BLOCK_LVL_VAL_14_15_ACCESS)
    );

    lvl_val_16_17 = uvm_reg::type_id::create("lvl_val_16_17");
    lvl_val_16_17.configure(.blk_parent(this));
    lvl_val_16_17.build();

    reg_map.add_reg
    (
      .rg     (lvl_val_16_17),
      .offset (CSR_REG_BLOCK_LVL_VAL_16_17_OFFSET),
      .rights (CSR_REG_BLOCK_LVL_VAL_16_17_ACCESS)
    );

    lvl_val_18_19 = uvm_reg::type_id::create("lvl_val_18_19");
    lvl_val_18_19.configure(.blk_parent(this));
    lvl_val_18_19.build();

    reg_map.add_reg
    (
      .rg     (lvl_val_18_19),
      .offset (CSR_REG_BLOCK_LVL_VAL_18_19_OFFSET),
      .rights (CSR_REG_BLOCK_LVL_VAL_18_19_ACCESS)
    );

    lvl_val_20_21 = uvm_reg::type_id::create("lvl_val_20_21");
    lvl_val_20_21.configure(.blk_parent(this));
    lvl_val_20_21.build();

    reg_map.add_reg
    (
      .rg     (lvl_val_20_21),
      .offset (CSR_REG_BLOCK_LVL_VAL_20_21_OFFSET),
      .rights (CSR_REG_BLOCK_LVL_VAL_20_21_ACCESS)
    );

    lvl_val_22_23 = uvm_reg::type_id::create("lvl_val_22_23");
    lvl_val_22_23.configure(.blk_parent(this));
    lvl_val_22_23.build();

    reg_map.add_reg
    (
      .rg     (lvl_val_22_23),
      .offset (CSR_REG_BLOCK_LVL_VAL_22_23_OFFSET),
      .rights (CSR_REG_BLOCK_LVL_VAL_22_23_ACCESS)
    );

    lvl_val_24_25 = uvm_reg::type_id::create("lvl_val_24_25");
    lvl_val_24_25.configure(.blk_parent(this));
    lvl_val_24_25.build();
    
    reg_map.add_reg
    (
      .rg     (lvl_val_24_25),
      .offset (CSR_REG_BLOCK_LVL_VAL_24_25_OFFSET),
      .rights (CSR_REG_BLOCK_LVL_VAL_24_25_ACCESS)
    );

    lvl_val_26_27 = uvm_reg::type_id::create("lvl_val_26_27");
    lvl_val_26_27.configure(.blk_parent(this));
    lvl_val_26_27.build();

    reg_map.add_reg
    (
      .rg     (lvl_val_26_27),
      .offset (CSR_REG_BLOCK_LVL_VAL_26_27_OFFSET),
      .rights (CSR_REG_BLOCK_LVL_VAL_26_27_ACCESS)
    );

    lvl_val_28_29 = uvm_reg::type_id::create("lvl_val_28_29");
    lvl_val_28_29.configure(.blk_parent(this));
    lvl_val_28_29.build();

    reg_map.add_reg
    (
      .rg     (lvl_val_28_29),
      .offset (CSR_REG_BLOCK_LVL_VAL_28_29_OFFSET),
      .rights (CSR_REG_BLOCK_LVL_VAL_28_29_ACCESS)
    );

    lvl_val_30_31 = uvm_reg::type_id::create("lvl_val_30_31");
    lvl_val_30_31.configure(.blk_parent(this));
    lvl_val_30_31.build();

    reg_map.add_reg
    (
      .rg     (lvl_val_30_31),
      .offset (CSR_REG_BLOCK_LVL_VAL_30_31_OFFSET),
      .rights (CSR_REG_BLOCK_LVL_VAL_30_31_ACCESS)
    );

    lock_model();
  endfunction : build
endclass : csr_reg_block

`endif // _CSR_REG_BLOCK_SVH_
