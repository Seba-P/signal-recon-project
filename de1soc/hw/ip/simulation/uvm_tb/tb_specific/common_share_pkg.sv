
package common_share_pkg;

  localparam FIR_TAPS_NUM       = 63;
  localparam MAX_SAMPLES_IN_RAM = 63;
  localparam MAX_LVLS_NUM       = 32;
  localparam MAX_ITER_NUM       = 3;

  localparam DEFAULT_LVLS_NUM   = 20;
  localparam DEFAULT_INIT_LVL   = 9;
  localparam DEFAULT_ITER_NUM   = 3;
  localparam DEFAULT_INIT_GUESS = 1;

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

endpackage : common_share_pkg
