
package common_share_pkg;

  localparam FIR_TAPS_NUM       = 63;
  localparam MAX_SAMPLES_IN_RAM = 63;
  localparam LVLS_NUM           = 20;
  localparam LVL_RESET_VALUE    = 9;
  localparam ITER_NUM           = 3;

  typedef enum bit
  {
    LVL_DOWN = 0,
    LVL_UP   = 1
  } lvl_cross_dir_e;

  typedef struct packed
  {
    lvl_cross_dir_e lvl_cross_dir;
    bit [14:0]      timestamp;
  } lvl_cross_sample_t;

  bit [0:31][15:0] lvls_values = 
  {
    16'h8666, 16'h9333, 16'h9FFF, 16'hACCC,
    16'hB999, 16'hC666, 16'hD333, 16'hE000,
    16'hECCC, 16'hF999, 16'h0666, 16'h1333,
    16'h2000, 16'h2CCC, 16'h3999, 16'h4666,
    16'h5333, 16'h6000, 16'h6CCC, 16'h7999,
    /* UNUSED BELOW */
    16'hFFFF, 16'hFFFF, 16'hFFFF, 16'hFFFF,
    16'hFFFF, 16'hFFFF, 16'hFFFF, 16'hFFFF,
    16'hFFFF, 16'hFFFF, 16'hFFFF, 16'hFFFF 
  };

endpackage : common_share_pkg
