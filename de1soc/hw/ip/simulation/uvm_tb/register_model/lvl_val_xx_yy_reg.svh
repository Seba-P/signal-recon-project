
`ifndef _LVL_VAL_XX_YY_REG_SVH_
`define _LVL_VAL_XX_YY_REG_SVH_

class lvl_val_00_01_reg extends uvm_reg;
  `uvm_object_utils(lvl_val_00_01_reg)

  rand uvm_reg_field lvl_val_00;
  rand uvm_reg_field lvl_val_01;

  // Standard UVM Methods:
  function new(string name = "lvl_val_00_01_reg");
    super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
  endfunction : new

  virtual function void build();
    lvl_val_00  = uvm_reg_field::type_id::create("lvl_val_00");
    lvl_val_01  = uvm_reg_field::type_id::create("lvl_val_01");

    lvl_val_00.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_00_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_00_OFFSET),
      .access                   (CSR_LVL_VAL_00_ACCESS),
      .volatile                 (CSR_LVL_VAL_00_VOLATILE),
      .reset                    (CSR_LVL_VAL_00_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_00_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    lvl_val_01.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_01_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_01_OFFSET),
      .access                   (CSR_LVL_VAL_01_ACCESS),
      .volatile                 (CSR_LVL_VAL_01_VOLATILE),
      .reset                    (CSR_LVL_VAL_01_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_01_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    add_hdl_path_slice(.name("lvl_val_00_01.lvl_val_00"), .offset(CSR_LVL_VAL_00_OFFSET), .size(CSR_LVL_VAL_00_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("lvl_val_00_01.lvl_val_01"), .offset(CSR_LVL_VAL_01_OFFSET), .size(CSR_LVL_VAL_01_SIZE), .kind("RTL"));
  endfunction : build
endclass : lvl_val_00_01_reg

class lvl_val_02_03_reg extends uvm_reg;
  `uvm_object_utils(lvl_val_02_03_reg)

  rand uvm_reg_field lvl_val_02;
  rand uvm_reg_field lvl_val_03;

  // Standard UVM Methods:
  function new(string name = "lvl_val_02_03_reg");
    super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
  endfunction : new

  virtual function void build();
    lvl_val_02  = uvm_reg_field::type_id::create("lvl_val_02");
    lvl_val_03  = uvm_reg_field::type_id::create("lvl_val_03");

    lvl_val_02.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_02_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_02_OFFSET),
      .access                   (CSR_LVL_VAL_02_ACCESS),
      .volatile                 (CSR_LVL_VAL_02_VOLATILE),
      .reset                    (CSR_LVL_VAL_02_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_02_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    lvl_val_03.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_03_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_03_OFFSET),
      .access                   (CSR_LVL_VAL_03_ACCESS),
      .volatile                 (CSR_LVL_VAL_03_VOLATILE),
      .reset                    (CSR_LVL_VAL_03_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_03_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );
  
    add_hdl_path_slice(.name("lvl_val_02_03.lvl_val_02"), .offset(CSR_LVL_VAL_02_OFFSET), .size(CSR_LVL_VAL_02_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("lvl_val_02_03.lvl_val_03"), .offset(CSR_LVL_VAL_03_OFFSET), .size(CSR_LVL_VAL_03_SIZE), .kind("RTL"));
  endfunction : build
endclass : lvl_val_02_03_reg

class lvl_val_04_05_reg extends uvm_reg;
  `uvm_object_utils(lvl_val_04_05_reg)

  rand uvm_reg_field lvl_val_04;
  rand uvm_reg_field lvl_val_05;

  // Standard UVM Methods:
  function new(string name = "lvl_val_04_05_reg");
    super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
  endfunction : new

  virtual function void build();
    lvl_val_04  = uvm_reg_field::type_id::create("lvl_val_04");
    lvl_val_05  = uvm_reg_field::type_id::create("lvl_val_05");

    lvl_val_04.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_04_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_04_OFFSET),
      .access                   (CSR_LVL_VAL_04_ACCESS),
      .volatile                 (CSR_LVL_VAL_04_VOLATILE),
      .reset                    (CSR_LVL_VAL_04_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_04_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    lvl_val_05.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_05_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_05_OFFSET),
      .access                   (CSR_LVL_VAL_05_ACCESS),
      .volatile                 (CSR_LVL_VAL_05_VOLATILE),
      .reset                    (CSR_LVL_VAL_05_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_05_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );
  
    add_hdl_path_slice(.name("lvl_val_04_05.lvl_val_04"), .offset(CSR_LVL_VAL_04_OFFSET), .size(CSR_LVL_VAL_04_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("lvl_val_04_05.lvl_val_05"), .offset(CSR_LVL_VAL_05_OFFSET), .size(CSR_LVL_VAL_05_SIZE), .kind("RTL"));
  endfunction : build
endclass : lvl_val_04_05_reg

class lvl_val_06_07_reg extends uvm_reg;
  `uvm_object_utils(lvl_val_06_07_reg)

  rand uvm_reg_field lvl_val_06;
  rand uvm_reg_field lvl_val_07;

  // Standard UVM Methods:
  function new(string name = "lvl_val_06_07_reg");
    super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
  endfunction : new

  virtual function void build();
    lvl_val_06  = uvm_reg_field::type_id::create("lvl_val_06");
    lvl_val_07  = uvm_reg_field::type_id::create("lvl_val_07");

    lvl_val_06.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_06_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_06_OFFSET),
      .access                   (CSR_LVL_VAL_06_ACCESS),
      .volatile                 (CSR_LVL_VAL_06_VOLATILE),
      .reset                    (CSR_LVL_VAL_06_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_06_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    lvl_val_07.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_07_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_07_OFFSET),
      .access                   (CSR_LVL_VAL_07_ACCESS),
      .volatile                 (CSR_LVL_VAL_07_VOLATILE),
      .reset                    (CSR_LVL_VAL_07_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_07_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );
  
    add_hdl_path_slice(.name("lvl_val_06_07.lvl_val_06"), .offset(CSR_LVL_VAL_06_OFFSET), .size(CSR_LVL_VAL_06_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("lvl_val_06_07.lvl_val_07"), .offset(CSR_LVL_VAL_07_OFFSET), .size(CSR_LVL_VAL_07_SIZE), .kind("RTL"));
  endfunction : build
endclass : lvl_val_06_07_reg

class lvl_val_08_09_reg extends uvm_reg;
  `uvm_object_utils(lvl_val_08_09_reg)

  rand uvm_reg_field lvl_val_08;
  rand uvm_reg_field lvl_val_09;

  // Standard UVM Methods:
  function new(string name = "lvl_val_08_09_reg");
    super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
  endfunction : new

  virtual function void build();
    lvl_val_08  = uvm_reg_field::type_id::create("lvl_val_08");
    lvl_val_09  = uvm_reg_field::type_id::create("lvl_val_09");

    lvl_val_08.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_08_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_08_OFFSET),
      .access                   (CSR_LVL_VAL_08_ACCESS),
      .volatile                 (CSR_LVL_VAL_08_VOLATILE),
      .reset                    (CSR_LVL_VAL_08_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_08_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    lvl_val_09.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_09_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_09_OFFSET),
      .access                   (CSR_LVL_VAL_09_ACCESS),
      .volatile                 (CSR_LVL_VAL_09_VOLATILE),
      .reset                    (CSR_LVL_VAL_09_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_09_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );
  
    add_hdl_path_slice(.name("lvl_val_08_09.lvl_val_08"), .offset(CSR_LVL_VAL_08_OFFSET), .size(CSR_LVL_VAL_08_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("lvl_val_08_09.lvl_val_09"), .offset(CSR_LVL_VAL_09_OFFSET), .size(CSR_LVL_VAL_09_SIZE), .kind("RTL"));
  endfunction : build
endclass : lvl_val_08_09_reg

class lvl_val_10_11_reg extends uvm_reg;
  `uvm_object_utils(lvl_val_10_11_reg)

  rand uvm_reg_field lvl_val_10;
  rand uvm_reg_field lvl_val_11;

  // Standard UVM Methods:
  function new(string name = "lvl_val_10_11_reg");
    super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
  endfunction : new

  virtual function void build();
    lvl_val_10  = uvm_reg_field::type_id::create("lvl_val_10");
    lvl_val_11  = uvm_reg_field::type_id::create("lvl_val_11");

    lvl_val_10.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_10_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_10_OFFSET),
      .access                   (CSR_LVL_VAL_10_ACCESS),
      .volatile                 (CSR_LVL_VAL_10_VOLATILE),
      .reset                    (CSR_LVL_VAL_10_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_10_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    lvl_val_11.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_11_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_11_OFFSET),
      .access                   (CSR_LVL_VAL_11_ACCESS),
      .volatile                 (CSR_LVL_VAL_11_VOLATILE),
      .reset                    (CSR_LVL_VAL_11_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_11_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );
  
    add_hdl_path_slice(.name("lvl_val_10_11.lvl_val_10"), .offset(CSR_LVL_VAL_10_OFFSET), .size(CSR_LVL_VAL_10_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("lvl_val_10_11.lvl_val_11"), .offset(CSR_LVL_VAL_11_OFFSET), .size(CSR_LVL_VAL_11_SIZE), .kind("RTL"));
  endfunction : build
endclass : lvl_val_10_11_reg

class lvl_val_12_13_reg extends uvm_reg;
  `uvm_object_utils(lvl_val_12_13_reg)

  rand uvm_reg_field lvl_val_12;
  rand uvm_reg_field lvl_val_13;

  // Standard UVM Methods:
  function new(string name = "lvl_val_12_13_reg");
    super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
  endfunction : new

  virtual function void build();
    lvl_val_12  = uvm_reg_field::type_id::create("lvl_val_12");
    lvl_val_13  = uvm_reg_field::type_id::create("lvl_val_13");

    lvl_val_12.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_12_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_12_OFFSET),
      .access                   (CSR_LVL_VAL_12_ACCESS),
      .volatile                 (CSR_LVL_VAL_12_VOLATILE),
      .reset                    (CSR_LVL_VAL_12_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_12_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    lvl_val_13.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_13_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_13_OFFSET),
      .access                   (CSR_LVL_VAL_13_ACCESS),
      .volatile                 (CSR_LVL_VAL_13_VOLATILE),
      .reset                    (CSR_LVL_VAL_13_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_13_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );
  
    add_hdl_path_slice(.name("lvl_val_12_13.lvl_val_12"), .offset(CSR_LVL_VAL_12_OFFSET), .size(CSR_LVL_VAL_12_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("lvl_val_12_13.lvl_val_13"), .offset(CSR_LVL_VAL_13_OFFSET), .size(CSR_LVL_VAL_13_SIZE), .kind("RTL"));
  endfunction : build
endclass : lvl_val_12_13_reg

class lvl_val_14_15_reg extends uvm_reg;
  `uvm_object_utils(lvl_val_14_15_reg)

  rand uvm_reg_field lvl_val_14;
  rand uvm_reg_field lvl_val_15;

  // Standard UVM Methods:
  function new(string name = "lvl_val_14_15_reg");
    super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
  endfunction : new

  virtual function void build();
    lvl_val_14  = uvm_reg_field::type_id::create("lvl_val_14");
    lvl_val_15  = uvm_reg_field::type_id::create("lvl_val_15");

    lvl_val_14.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_14_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_14_OFFSET),
      .access                   (CSR_LVL_VAL_14_ACCESS),
      .volatile                 (CSR_LVL_VAL_14_VOLATILE),
      .reset                    (CSR_LVL_VAL_14_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_14_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    lvl_val_15.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_15_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_15_OFFSET),
      .access                   (CSR_LVL_VAL_15_ACCESS),
      .volatile                 (CSR_LVL_VAL_15_VOLATILE),
      .reset                    (CSR_LVL_VAL_15_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_15_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );
  
    add_hdl_path_slice(.name("lvl_val_14_15.lvl_val_14"), .offset(CSR_LVL_VAL_14_OFFSET), .size(CSR_LVL_VAL_14_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("lvl_val_14_15.lvl_val_15"), .offset(CSR_LVL_VAL_15_OFFSET), .size(CSR_LVL_VAL_15_SIZE), .kind("RTL"));
  endfunction : build
endclass : lvl_val_14_15_reg

class lvl_val_16_17_reg extends uvm_reg;
  `uvm_object_utils(lvl_val_16_17_reg)

  rand uvm_reg_field lvl_val_16;
  rand uvm_reg_field lvl_val_17;

  // Standard UVM Methods:
  function new(string name = "lvl_val_16_17_reg");
    super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
  endfunction : new

  virtual function void build();
    lvl_val_16  = uvm_reg_field::type_id::create("lvl_val_16");
    lvl_val_17  = uvm_reg_field::type_id::create("lvl_val_17");

    lvl_val_16.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_16_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_16_OFFSET),
      .access                   (CSR_LVL_VAL_16_ACCESS),
      .volatile                 (CSR_LVL_VAL_16_VOLATILE),
      .reset                    (CSR_LVL_VAL_16_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_16_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    lvl_val_17.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_17_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_17_OFFSET),
      .access                   (CSR_LVL_VAL_17_ACCESS),
      .volatile                 (CSR_LVL_VAL_17_VOLATILE),
      .reset                    (CSR_LVL_VAL_17_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_17_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );
  
    add_hdl_path_slice(.name("lvl_val_16_17.lvl_val_16"), .offset(CSR_LVL_VAL_16_OFFSET), .size(CSR_LVL_VAL_16_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("lvl_val_16_17.lvl_val_17"), .offset(CSR_LVL_VAL_17_OFFSET), .size(CSR_LVL_VAL_17_SIZE), .kind("RTL"));
  endfunction : build
endclass : lvl_val_16_17_reg

class lvl_val_18_19_reg extends uvm_reg;
  `uvm_object_utils(lvl_val_18_19_reg)

  rand uvm_reg_field lvl_val_18;
  rand uvm_reg_field lvl_val_19;

  // Standard UVM Methods:
  function new(string name = "lvl_val_18_19_reg");
    super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
  endfunction : new

  virtual function void build();
    lvl_val_18  = uvm_reg_field::type_id::create("lvl_val_18");
    lvl_val_19  = uvm_reg_field::type_id::create("lvl_val_19");

    lvl_val_18.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_18_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_18_OFFSET),
      .access                   (CSR_LVL_VAL_18_ACCESS),
      .volatile                 (CSR_LVL_VAL_18_VOLATILE),
      .reset                    (CSR_LVL_VAL_18_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_18_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    lvl_val_19.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_19_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_19_OFFSET),
      .access                   (CSR_LVL_VAL_19_ACCESS),
      .volatile                 (CSR_LVL_VAL_19_VOLATILE),
      .reset                    (CSR_LVL_VAL_19_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_19_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );
  
    add_hdl_path_slice(.name("lvl_val_18_19.lvl_val_18"), .offset(CSR_LVL_VAL_18_OFFSET), .size(CSR_LVL_VAL_18_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("lvl_val_18_19.lvl_val_19"), .offset(CSR_LVL_VAL_19_OFFSET), .size(CSR_LVL_VAL_19_SIZE), .kind("RTL"));
  endfunction : build
endclass : lvl_val_18_19_reg

class lvl_val_20_21_reg extends uvm_reg;
  `uvm_object_utils(lvl_val_20_21_reg)

  rand uvm_reg_field lvl_val_20;
  rand uvm_reg_field lvl_val_21;

  // Standard UVM Methods:
  function new(string name = "lvl_val_20_21_reg");
    super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
  endfunction : new

  virtual function void build();
    lvl_val_20  = uvm_reg_field::type_id::create("lvl_val_20");
    lvl_val_21  = uvm_reg_field::type_id::create("lvl_val_21");

    lvl_val_20.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_20_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_20_OFFSET),
      .access                   (CSR_LVL_VAL_20_ACCESS),
      .volatile                 (CSR_LVL_VAL_20_VOLATILE),
      .reset                    (CSR_LVL_VAL_20_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_20_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    lvl_val_21.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_21_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_21_OFFSET),
      .access                   (CSR_LVL_VAL_21_ACCESS),
      .volatile                 (CSR_LVL_VAL_21_VOLATILE),
      .reset                    (CSR_LVL_VAL_21_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_21_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );
  
    add_hdl_path_slice(.name("lvl_val_20_21.lvl_val_20"), .offset(CSR_LVL_VAL_20_OFFSET), .size(CSR_LVL_VAL_20_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("lvl_val_20_21.lvl_val_21"), .offset(CSR_LVL_VAL_21_OFFSET), .size(CSR_LVL_VAL_21_SIZE), .kind("RTL"));
  endfunction : build
endclass : lvl_val_20_21_reg

class lvl_val_22_23_reg extends uvm_reg;
  `uvm_object_utils(lvl_val_22_23_reg)

  rand uvm_reg_field lvl_val_22;
  rand uvm_reg_field lvl_val_23;

  // Standard UVM Methods:
  function new(string name = "lvl_val_22_23_reg");
    super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
  endfunction : new

  virtual function void build();
    lvl_val_22  = uvm_reg_field::type_id::create("lvl_val_22");
    lvl_val_23  = uvm_reg_field::type_id::create("lvl_val_23");

    lvl_val_22.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_22_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_22_OFFSET),
      .access                   (CSR_LVL_VAL_22_ACCESS),
      .volatile                 (CSR_LVL_VAL_22_VOLATILE),
      .reset                    (CSR_LVL_VAL_22_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_22_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    lvl_val_23.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_23_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_23_OFFSET),
      .access                   (CSR_LVL_VAL_23_ACCESS),
      .volatile                 (CSR_LVL_VAL_23_VOLATILE),
      .reset                    (CSR_LVL_VAL_23_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_23_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );
  
    add_hdl_path_slice(.name("lvl_val_22_23.lvl_val_22"), .offset(CSR_LVL_VAL_22_OFFSET), .size(CSR_LVL_VAL_22_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("lvl_val_22_23.lvl_val_23"), .offset(CSR_LVL_VAL_23_OFFSET), .size(CSR_LVL_VAL_23_SIZE), .kind("RTL"));
  endfunction : build
endclass : lvl_val_22_23_reg

class lvl_val_24_25_reg extends uvm_reg;
  `uvm_object_utils(lvl_val_24_25_reg)

  rand uvm_reg_field lvl_val_24;
  rand uvm_reg_field lvl_val_25;

  // Standard UVM Methods:
  function new(string name = "lvl_val_24_25_reg");
    super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
  endfunction : new

  virtual function void build();
    lvl_val_24  = uvm_reg_field::type_id::create("lvl_val_24");
    lvl_val_25  = uvm_reg_field::type_id::create("lvl_val_25");

    lvl_val_24.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_24_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_24_OFFSET),
      .access                   (CSR_LVL_VAL_24_ACCESS),
      .volatile                 (CSR_LVL_VAL_24_VOLATILE),
      .reset                    (CSR_LVL_VAL_24_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_24_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    lvl_val_25.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_25_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_25_OFFSET),
      .access                   (CSR_LVL_VAL_25_ACCESS),
      .volatile                 (CSR_LVL_VAL_25_VOLATILE),
      .reset                    (CSR_LVL_VAL_25_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_25_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );
  
    add_hdl_path_slice(.name("lvl_val_24_25.lvl_val_24"), .offset(CSR_LVL_VAL_24_OFFSET), .size(CSR_LVL_VAL_24_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("lvl_val_24_25.lvl_val_25"), .offset(CSR_LVL_VAL_25_OFFSET), .size(CSR_LVL_VAL_25_SIZE), .kind("RTL"));
  endfunction : build
endclass : lvl_val_24_25_reg

class lvl_val_26_27_reg extends uvm_reg;
  `uvm_object_utils(lvl_val_26_27_reg)

  rand uvm_reg_field lvl_val_26;
  rand uvm_reg_field lvl_val_27;

  // Standard UVM Methods:
  function new(string name = "lvl_val_26_27_reg");
    super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
  endfunction : new

  virtual function void build();
    lvl_val_26  = uvm_reg_field::type_id::create("lvl_val_26");
    lvl_val_27  = uvm_reg_field::type_id::create("lvl_val_27");

    lvl_val_26.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_26_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_26_OFFSET),
      .access                   (CSR_LVL_VAL_26_ACCESS),
      .volatile                 (CSR_LVL_VAL_26_VOLATILE),
      .reset                    (CSR_LVL_VAL_26_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_26_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    lvl_val_27.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_27_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_27_OFFSET),
      .access                   (CSR_LVL_VAL_27_ACCESS),
      .volatile                 (CSR_LVL_VAL_27_VOLATILE),
      .reset                    (CSR_LVL_VAL_27_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_27_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );
  
    add_hdl_path_slice(.name("lvl_val_26_27.lvl_val_26"), .offset(CSR_LVL_VAL_26_OFFSET), .size(CSR_LVL_VAL_26_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("lvl_val_26_27.lvl_val_27"), .offset(CSR_LVL_VAL_27_OFFSET), .size(CSR_LVL_VAL_27_SIZE), .kind("RTL"));
  endfunction : build
endclass : lvl_val_26_27_reg

class lvl_val_28_29_reg extends uvm_reg;
  `uvm_object_utils(lvl_val_28_29_reg)

  rand uvm_reg_field lvl_val_28;
  rand uvm_reg_field lvl_val_29;

  // Standard UVM Methods:
  function new(string name = "lvl_val_28_29_reg");
    super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
  endfunction : new

  virtual function void build();
    lvl_val_28  = uvm_reg_field::type_id::create("lvl_val_28");
    lvl_val_29  = uvm_reg_field::type_id::create("lvl_val_29");

    lvl_val_28.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_28_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_28_OFFSET),
      .access                   (CSR_LVL_VAL_28_ACCESS),
      .volatile                 (CSR_LVL_VAL_28_VOLATILE),
      .reset                    (CSR_LVL_VAL_28_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_28_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    lvl_val_29.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_29_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_29_OFFSET),
      .access                   (CSR_LVL_VAL_29_ACCESS),
      .volatile                 (CSR_LVL_VAL_29_VOLATILE),
      .reset                    (CSR_LVL_VAL_29_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_29_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );
  
    add_hdl_path_slice(.name("lvl_val_28_29.lvl_val_28"), .offset(CSR_LVL_VAL_28_OFFSET), .size(CSR_LVL_VAL_28_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("lvl_val_28_29.lvl_val_29"), .offset(CSR_LVL_VAL_29_OFFSET), .size(CSR_LVL_VAL_29_SIZE), .kind("RTL"));
  endfunction : build
endclass : lvl_val_28_29_reg

class lvl_val_30_31_reg extends uvm_reg;
  `uvm_object_utils(lvl_val_30_31_reg)

  rand uvm_reg_field lvl_val_30;
  rand uvm_reg_field lvl_val_31;

  // Standard UVM Methods:
  function new(string name = "lvl_val_30_31_reg");
    super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
  endfunction : new

  virtual function void build();
    lvl_val_30  = uvm_reg_field::type_id::create("lvl_val_30");
    lvl_val_31  = uvm_reg_field::type_id::create("lvl_val_31");

    lvl_val_30.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_30_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_30_OFFSET),
      .access                   (CSR_LVL_VAL_30_ACCESS),
      .volatile                 (CSR_LVL_VAL_30_VOLATILE),
      .reset                    (CSR_LVL_VAL_30_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_30_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );

    lvl_val_31.configure
    (
      .parent                   (this),
      .size                     (CSR_LVL_VAL_31_SIZE),
      .lsb_pos                  (CSR_LVL_VAL_31_OFFSET),
      .access                   (CSR_LVL_VAL_31_ACCESS),
      .volatile                 (CSR_LVL_VAL_31_VOLATILE),
      .reset                    (CSR_LVL_VAL_31_RESET_VAL),
      .has_reset                (CSR_LVL_VAL_31_HAS_RESET),
      .is_rand                  (0),
      .individually_accessible  (0)
    );
  
    add_hdl_path_slice(.name("lvl_val_30_31.lvl_val_30"), .offset(CSR_LVL_VAL_30_OFFSET), .size(CSR_LVL_VAL_30_SIZE), .kind("RTL"));
    add_hdl_path_slice(.name("lvl_val_30_31.lvl_val_31"), .offset(CSR_LVL_VAL_31_OFFSET), .size(CSR_LVL_VAL_31_SIZE), .kind("RTL"));
  endfunction : build
endclass : lvl_val_30_31_reg

`endif // _LVL_VAL_XX_YY_REG_SVH_
