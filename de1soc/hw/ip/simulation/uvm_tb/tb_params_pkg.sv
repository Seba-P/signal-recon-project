
package tb_params_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import common_share_pkg::*;
  import register_file_defs_pkg::*;
  import avalon_mm_agent_pkg::*;
  import avalon_st_agent_pkg::*;

  typedef enum bit [1:0]
  {
    CSR,
    AVALON_MM_AGENTS_NUM
  } avalon_mm_agent_e;

  typedef enum bit [1:0]
  {
    MM2ST,
    ST2MM,
    AVALON_ST_AGENTS_NUM
  } avalon_st_agent_e;

  parameter avalon_mm_inst_spec_t avalon_mm_inst_specs[AVALON_MM_AGENTS_NUM] =
  '{
    '{
      /*addr_width*/  32,
      /*data_width*/  32,
      /*vif_modport*/ MODPORT_MASTER
    }
  };

  parameter avalon_mm_agent_params_t avalon_mm_agent_params[AVALON_MM_AGENTS_NUM] =
  '{
    '{
      /*addr_width*/  32,
      /*data_width*/  32,
      /*vif_modport*/ MODPORT_MASTER,
      /*agent_name*/  "CSR",
      /*is_active*/   UVM_ACTIVE,
      /*verbosity*/   UVM_LOW,
      /*vif_name*/    "csr_if"
    }
  };

  parameter avalon_st_inst_spec_t avalon_st_inst_specs[AVALON_ST_AGENTS_NUM] =
  '{
    '{
      /*bus_width*/   16,
      /*vif_modport*/ MODPORT_SOURCE
    },
    '{
      /*bus_width*/   16,
      /*vif_modport*/ MODPORT_SINK
    }
  };

  parameter avalon_st_agent_params_t avalon_st_agent_params[AVALON_ST_AGENTS_NUM] =
  '{
    '{
      /*bus_width*/   16,
      /*vif_modport*/ MODPORT_SOURCE,
      /*agent_name*/  "MM2ST",
      /*is_active*/   UVM_ACTIVE,
      /*verbosity*/   UVM_LOW,
      /*vif_name*/    "mm2st_if"
    },
    '{
      /*bus_width*/   16,
      /*vif_modport*/ MODPORT_SINK,
      /*agent_name*/  "ST2MM",
      /*is_active*/   UVM_ACTIVE,
      /*verbosity*/   UVM_LOW,
      /*vif_name*/    "st2mm_if"
    }
  };

  parameter csr_reg_block_t csr_init_config =
  '{
    /*status*/  '{ /*_reserved*/'0, /*fifo_err*/'0, /*_reserved2*/'0, /*error*/'0, /*ready*/'0, /*busy*/'0 }, // read-only, discard
    /*control*/ '{ /*_reserved*/'0, /*init*/'0, /*flush*/'0, /*halt*/'0, /*run*/'0 },
    /*params*/  '{ /*_reserved*/'0, /*iter_num*/ITER_NUM, /*_reserved2*/'0, /*init_lvl*/INIT_LVL, /*_reserved3*/'0, /*lvls_num*/LVLS_NUM },
    /*lvl_val_00_01*/ '{ /*lvl_val_01*/'h9333, /*lvl_val_00*/'h8666 },
    /*lvl_val_02_03*/ '{ /*lvl_val_03*/'hACCC, /*lvl_val_02*/'h9FFF },
    /*lvl_val_04_05*/ '{ /*lvl_val_05*/'hC666, /*lvl_val_04*/'hB999 },
    /*lvl_val_06_07*/ '{ /*lvl_val_07*/'hE000, /*lvl_val_06*/'hD333 },
    /*lvl_val_08_09*/ '{ /*lvl_val_09*/'hF999, /*lvl_val_08*/'hECCC },
    /*lvl_val_10_11*/ '{ /*lvl_val_11*/'h1333, /*lvl_val_10*/'h0666 },
    /*lvl_val_12_13*/ '{ /*lvl_val_13*/'h2CCC, /*lvl_val_12*/'h2000 },
    /*lvl_val_14_15*/ '{ /*lvl_val_15*/'h4666, /*lvl_val_14*/'h3999 },
    /*lvl_val_16_17*/ '{ /*lvl_val_17*/'h6000, /*lvl_val_16*/'h5333 },
    /*lvl_val_18_19*/ '{ /*lvl_val_19*/'h7999, /*lvl_val_18*/'h6CCC },
    /*lvl_val_20_21*/ '{ /*lvl_val_21*/'hFFFF, /*lvl_val_20*/'hFFFF },
    /*lvl_val_22_23*/ '{ /*lvl_val_23*/'hFFFF, /*lvl_val_22*/'hFFFF },
    /*lvl_val_24_25*/ '{ /*lvl_val_25*/'hFFFF, /*lvl_val_24*/'hFFFF },
    /*lvl_val_26_27*/ '{ /*lvl_val_27*/'hFFFF, /*lvl_val_26*/'hFFFF },
    /*lvl_val_28_29*/ '{ /*lvl_val_29*/'hFFFF, /*lvl_val_28*/'hFFFF },
    /*lvl_val_30_31*/ '{ /*lvl_val_31*/'hFFFF, /*lvl_val_30*/'hFFFF } 
  };

endpackage : tb_params_pkg
