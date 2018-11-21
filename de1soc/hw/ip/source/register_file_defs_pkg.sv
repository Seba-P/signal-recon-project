
package register_file_defs_pkg;

/********************
*      STATUS       *
********************/
typedef struct packed
{
  reg [31:17] _reserved;
  reg [16:16] fifo_err;
  reg [15: 3] _reserved2;
  reg [ 2: 2] error;
  reg [ 1: 1] ready;
  reg [ 0: 0] busy;
} status_reg_t;

parameter CSR_STATUS_BUSY_SIZE          = 1;
parameter CSR_STATUS_BUSY_OFFSET        = 0;
parameter CSR_STATUS_BUSY_ACCESS        = "RO";
parameter CSR_STATUS_BUSY_VOLATILE      = 1;
parameter CSR_STATUS_BUSY_RESET_VAL     = 'd0;
parameter CSR_STATUS_BUSY_HAS_RESET     = 1;

parameter CSR_STATUS_READY_SIZE         = 1;
parameter CSR_STATUS_READY_OFFSET       = 1;
parameter CSR_STATUS_READY_ACCESS       = "RO";
parameter CSR_STATUS_READY_VOLATILE     = 1;
parameter CSR_STATUS_READY_RESET_VAL    = 'd0;
parameter CSR_STATUS_READY_HAS_RESET    = 1;

parameter CSR_STATUS_ERROR_SIZE         = 1;
parameter CSR_STATUS_ERROR_OFFSET       = 2;
parameter CSR_STATUS_ERROR_ACCESS       = "RO";
parameter CSR_STATUS_ERROR_VOLATILE     = 1;
parameter CSR_STATUS_ERROR_RESET_VAL    = 'd0;
parameter CSR_STATUS_ERROR_HAS_RESET    = 1;

parameter CSR_STATUS_FIFO_ERR_SIZE      = 1;
parameter CSR_STATUS_FIFO_ERR_OFFSET    = 16;
parameter CSR_STATUS_FIFO_ERR_ACCESS    = "RO";
parameter CSR_STATUS_FIFO_ERR_VOLATILE  = 1;
parameter CSR_STATUS_FIFO_ERR_RESET_VAL = 'd0;
parameter CSR_STATUS_FIFO_ERR_HAS_RESET = 1;

/********************
*      CONTROL      *
********************/
typedef struct packed
{
  reg [31: 4] _reserved;
  reg [ 3: 3] init;
  reg [ 2: 2] flush;
  reg [ 1: 1] halt;
  reg [ 0: 0] run;
} control_reg_t;

parameter CSR_CONTROL_RUN_SIZE        = 1;
parameter CSR_CONTROL_RUN_OFFSET      = 0;
parameter CSR_CONTROL_RUN_ACCESS      = "WO";
parameter CSR_CONTROL_RUN_VOLATILE    = 0;
parameter CSR_CONTROL_RUN_RESET_VAL   = 'd0;
parameter CSR_CONTROL_RUN_HAS_RESET   = 1;

parameter CSR_CONTROL_HALT_SIZE       = 1;
parameter CSR_CONTROL_HALT_OFFSET     = 1;
parameter CSR_CONTROL_HALT_ACCESS     = "WO";
parameter CSR_CONTROL_HALT_VOLATILE   = 0;
parameter CSR_CONTROL_HALT_RESET_VAL  = 'd0;
parameter CSR_CONTROL_HALT_HAS_RESET  = 1;

parameter CSR_CONTROL_FLUSH_SIZE      = 1;
parameter CSR_CONTROL_FLUSH_OFFSET    = 2;
parameter CSR_CONTROL_FLUSH_ACCESS    = "WO";
parameter CSR_CONTROL_FLUSH_VOLATILE  = 0;
parameter CSR_CONTROL_FLUSH_RESET_VAL = 'd0;
parameter CSR_CONTROL_FLUSH_HAS_RESET = 1;

parameter CSR_CONTROL_INIT_SIZE       = 1;
parameter CSR_CONTROL_INIT_OFFSET     = 3;
parameter CSR_CONTROL_INIT_ACCESS     = "WO";
parameter CSR_CONTROL_INIT_VOLATILE   = 0;
parameter CSR_CONTROL_INIT_RESET_VAL  = 'd0;
parameter CSR_CONTROL_INIT_HAS_RESET  = 1;

/********************
*      PARAMS       *
********************/
typedef struct packed
{
  reg [31:24] _reserved;
  reg [19:16] iter_num;
  reg [12: 8] init_lvl;
  reg [ 4: 0] lvls_num;
} params_reg_t;

parameter CSR_PARAMS_LVLS_NUM_SIZE      = 5;
parameter CSR_PARAMS_LVLS_NUM_OFFSET    = 0;
parameter CSR_PARAMS_LVLS_NUM_ACCESS    = "RW";
parameter CSR_PARAMS_LVLS_NUM_VOLATILE  = 0;
parameter CSR_PARAMS_LVLS_NUM_RESET_VAL = 'd0;
parameter CSR_PARAMS_LVLS_NUM_HAS_RESET = 1;

parameter CSR_PARAMS_INIT_LVL_SIZE      = 5;
parameter CSR_PARAMS_INIT_LVL_OFFSET    = 8;
parameter CSR_PARAMS_INIT_LVL_ACCESS    = "RW";
parameter CSR_PARAMS_INIT_LVL_VOLATILE  = 0;
parameter CSR_PARAMS_INIT_LVL_RESET_VAL = 'd0;
parameter CSR_PARAMS_INIT_LVL_HAS_RESET = 1;

parameter CSR_PARAMS_ITER_NUM_SIZE      = 4;
parameter CSR_PARAMS_ITER_NUM_OFFSET    = 16;
parameter CSR_PARAMS_ITER_NUM_ACCESS    = "RW";
parameter CSR_PARAMS_ITER_NUM_VOLATILE  = 0;
parameter CSR_PARAMS_ITER_NUM_RESET_VAL = 'd0;
parameter CSR_PARAMS_ITER_NUM_HAS_RESET = 1;

/********************
*   LVL_VAL_00_01   *
********************/
typedef struct packed
{
  reg [31:16] lvl_val_01;
  reg [15: 0] lvl_val_00;
} lvl_val_00_01_reg_t;

parameter CSR_LVL_VAL_00_SIZE       = 16;
parameter CSR_LVL_VAL_00_OFFSET     = 0;
parameter CSR_LVL_VAL_00_ACCESS     = "RW";
parameter CSR_LVL_VAL_00_VOLATILE   = 0;
parameter CSR_LVL_VAL_00_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_00_HAS_RESET  = 1;

parameter CSR_LVL_VAL_01_SIZE       = 16;
parameter CSR_LVL_VAL_01_OFFSET     = 16;
parameter CSR_LVL_VAL_01_ACCESS     = "RW";
parameter CSR_LVL_VAL_01_VOLATILE   = 0;
parameter CSR_LVL_VAL_01_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_01_HAS_RESET  = 1;

/********************
*   LVL_VAL_02_03   *
********************/
typedef struct packed
{
  reg [31:16] lvl_val_03;
  reg [15: 0] lvl_val_02;
} lvl_val_02_03_reg_t;

parameter CSR_LVL_VAL_02_SIZE       = 16;
parameter CSR_LVL_VAL_02_OFFSET     = 0;
parameter CSR_LVL_VAL_02_ACCESS     = "RW";
parameter CSR_LVL_VAL_02_VOLATILE   = 0;
parameter CSR_LVL_VAL_02_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_02_HAS_RESET  = 1;

parameter CSR_LVL_VAL_03_SIZE       = 16;
parameter CSR_LVL_VAL_03_OFFSET     = 16;
parameter CSR_LVL_VAL_03_ACCESS     = "RW";
parameter CSR_LVL_VAL_03_VOLATILE   = 0;
parameter CSR_LVL_VAL_03_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_03_HAS_RESET  = 1;

/********************
*   LVL_VAL_04_05   *
********************/
typedef struct packed
{
  reg [31:16] lvl_val_04;
  reg [15: 0] lvl_val_05;
} lvl_val_04_05_reg_t;

parameter CSR_LVL_VAL_04_SIZE       = 16;
parameter CSR_LVL_VAL_04_OFFSET     = 0;
parameter CSR_LVL_VAL_04_ACCESS     = "RW";
parameter CSR_LVL_VAL_04_VOLATILE   = 0;
parameter CSR_LVL_VAL_04_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_04_HAS_RESET  = 1;

parameter CSR_LVL_VAL_05_SIZE       = 16;
parameter CSR_LVL_VAL_05_OFFSET     = 16;
parameter CSR_LVL_VAL_05_ACCESS     = "RW";
parameter CSR_LVL_VAL_05_VOLATILE   = 0;
parameter CSR_LVL_VAL_05_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_05_HAS_RESET  = 1;

/********************
*   LVL_VAL_06_07   *
********************/
typedef struct packed
{
  reg [31:16] lvl_val_06;
  reg [15: 0] lvl_val_07;
} lvl_val_06_07_reg_t;

parameter CSR_LVL_VAL_06_SIZE       = 16;
parameter CSR_LVL_VAL_06_OFFSET     = 0;
parameter CSR_LVL_VAL_06_ACCESS     = "RW";
parameter CSR_LVL_VAL_06_VOLATILE   = 0;
parameter CSR_LVL_VAL_06_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_06_HAS_RESET  = 1;

parameter CSR_LVL_VAL_07_SIZE       = 16;
parameter CSR_LVL_VAL_07_OFFSET     = 16;
parameter CSR_LVL_VAL_07_ACCESS     = "RW";
parameter CSR_LVL_VAL_07_VOLATILE   = 0;
parameter CSR_LVL_VAL_07_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_07_HAS_RESET  = 1;

/********************
*   LVL_VAL_08_09   *
********************/
typedef struct packed
{
  reg [31:16] lvl_val_08;
  reg [15: 0] lvl_val_09;
} lvl_val_08_09_reg_t;

parameter CSR_LVL_VAL_08_SIZE       = 16;
parameter CSR_LVL_VAL_08_OFFSET     = 0;
parameter CSR_LVL_VAL_08_ACCESS     = "RW";
parameter CSR_LVL_VAL_08_VOLATILE   = 0;
parameter CSR_LVL_VAL_08_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_08_HAS_RESET  = 1;

parameter CSR_LVL_VAL_09_SIZE       = 16;
parameter CSR_LVL_VAL_09_OFFSET     = 16;
parameter CSR_LVL_VAL_09_ACCESS     = "RW";
parameter CSR_LVL_VAL_09_VOLATILE   = 0;
parameter CSR_LVL_VAL_09_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_09_HAS_RESET  = 1;

/********************
*   LVL_VAL_10_11   *
********************/
typedef struct packed
{
  reg [31:16] lvl_val_10;
  reg [15: 0] lvl_val_11;
} lvl_val_10_11_reg_t;

parameter CSR_LVL_VAL_10_SIZE       = 16;
parameter CSR_LVL_VAL_10_OFFSET     = 0;
parameter CSR_LVL_VAL_10_ACCESS     = "RW";
parameter CSR_LVL_VAL_10_VOLATILE   = 0;
parameter CSR_LVL_VAL_10_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_10_HAS_RESET  = 1;

parameter CSR_LVL_VAL_11_SIZE       = 16;
parameter CSR_LVL_VAL_11_OFFSET     = 16;
parameter CSR_LVL_VAL_11_ACCESS     = "RW";
parameter CSR_LVL_VAL_11_VOLATILE   = 0;
parameter CSR_LVL_VAL_11_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_11_HAS_RESET  = 1;

/********************
*   LVL_VAL_12_13   *
********************/
typedef struct packed
{
  reg [31:16] lvl_val_12;
  reg [15: 0] lvl_val_13;
} lvl_val_12_13_reg_t;

parameter CSR_LVL_VAL_12_SIZE       = 16;
parameter CSR_LVL_VAL_12_OFFSET     = 0;
parameter CSR_LVL_VAL_12_ACCESS     = "RW";
parameter CSR_LVL_VAL_12_VOLATILE   = 0;
parameter CSR_LVL_VAL_12_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_12_HAS_RESET  = 1;

parameter CSR_LVL_VAL_13_SIZE       = 16;
parameter CSR_LVL_VAL_13_OFFSET     = 16;
parameter CSR_LVL_VAL_13_ACCESS     = "RW";
parameter CSR_LVL_VAL_13_VOLATILE   = 0;
parameter CSR_LVL_VAL_13_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_13_HAS_RESET  = 1;

/********************
*   LVL_VAL_14_15   *
********************/
typedef struct packed
{
  reg [31:16] lvl_val_14;
  reg [15: 0] lvl_val_15;
} lvl_val_14_15_reg_t;

parameter CSR_LVL_VAL_14_SIZE       = 16;
parameter CSR_LVL_VAL_14_OFFSET     = 0;
parameter CSR_LVL_VAL_14_ACCESS     = "RW";
parameter CSR_LVL_VAL_14_VOLATILE   = 0;
parameter CSR_LVL_VAL_14_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_14_HAS_RESET  = 1;

parameter CSR_LVL_VAL_15_SIZE       = 16;
parameter CSR_LVL_VAL_15_OFFSET     = 16;
parameter CSR_LVL_VAL_15_ACCESS     = "RW";
parameter CSR_LVL_VAL_15_VOLATILE   = 0;
parameter CSR_LVL_VAL_15_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_15_HAS_RESET  = 1;

/********************
*   LVL_VAL_16_17   *
********************/
typedef struct packed
{
  reg [31:16] lvl_val_16;
  reg [15: 0] lvl_val_17;
} lvl_val_16_17_reg_t;

parameter CSR_LVL_VAL_16_SIZE       = 16;
parameter CSR_LVL_VAL_16_OFFSET     = 0;
parameter CSR_LVL_VAL_16_ACCESS     = "RW";
parameter CSR_LVL_VAL_16_VOLATILE   = 0;
parameter CSR_LVL_VAL_16_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_16_HAS_RESET  = 1;

parameter CSR_LVL_VAL_17_SIZE       = 16;
parameter CSR_LVL_VAL_17_OFFSET     = 16;
parameter CSR_LVL_VAL_17_ACCESS     = "RW";
parameter CSR_LVL_VAL_17_VOLATILE   = 0;
parameter CSR_LVL_VAL_17_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_17_HAS_RESET  = 1;

/********************
*   LVL_VAL_18_19   *
********************/
typedef struct packed
{
  reg [31:16] lvl_val_18;
  reg [15: 0] lvl_val_19;
} lvl_val_18_19_reg_t;

parameter CSR_LVL_VAL_18_SIZE       = 16;
parameter CSR_LVL_VAL_18_OFFSET     = 0;
parameter CSR_LVL_VAL_18_ACCESS     = "RW";
parameter CSR_LVL_VAL_18_VOLATILE   = 0;
parameter CSR_LVL_VAL_18_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_18_HAS_RESET  = 1;

parameter CSR_LVL_VAL_19_SIZE       = 16;
parameter CSR_LVL_VAL_19_OFFSET     = 16;
parameter CSR_LVL_VAL_19_ACCESS     = "RW";
parameter CSR_LVL_VAL_19_VOLATILE   = 0;
parameter CSR_LVL_VAL_19_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_19_HAS_RESET  = 1;

/********************
*   LVL_VAL_20_21   *
********************/
typedef struct packed
{
  reg [31:16] lvl_val_20;
  reg [15: 0] lvl_val_21;
} lvl_val_20_21_reg_t;

parameter CSR_LVL_VAL_20_SIZE       = 16;
parameter CSR_LVL_VAL_20_OFFSET     = 0;
parameter CSR_LVL_VAL_20_ACCESS     = "RW";
parameter CSR_LVL_VAL_20_VOLATILE   = 0;
parameter CSR_LVL_VAL_20_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_20_HAS_RESET  = 1;

parameter CSR_LVL_VAL_21_SIZE       = 16;
parameter CSR_LVL_VAL_21_OFFSET     = 16;
parameter CSR_LVL_VAL_21_ACCESS     = "RW";
parameter CSR_LVL_VAL_21_VOLATILE   = 0;
parameter CSR_LVL_VAL_21_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_21_HAS_RESET  = 1;

/********************
*   LVL_VAL_22_23   *
********************/
typedef struct packed
{
  reg [31:16] lvl_val_22;
  reg [15: 0] lvl_val_23;
} lvl_val_22_23_reg_t;

parameter CSR_LVL_VAL_22_SIZE       = 16;
parameter CSR_LVL_VAL_22_OFFSET     = 0;
parameter CSR_LVL_VAL_22_ACCESS     = "RW";
parameter CSR_LVL_VAL_22_VOLATILE   = 0;
parameter CSR_LVL_VAL_22_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_22_HAS_RESET  = 1;

parameter CSR_LVL_VAL_23_SIZE       = 16;
parameter CSR_LVL_VAL_23_OFFSET     = 16;
parameter CSR_LVL_VAL_23_ACCESS     = "RW";
parameter CSR_LVL_VAL_23_VOLATILE   = 0;
parameter CSR_LVL_VAL_23_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_23_HAS_RESET  = 1;

/********************
*   LVL_VAL_24_25   *
********************/
typedef struct packed
{
  reg [31:16] lvl_val_24;
  reg [15: 0] lvl_val_25;
} lvl_val_24_25_reg_t;

parameter CSR_LVL_VAL_24_SIZE       = 16;
parameter CSR_LVL_VAL_24_OFFSET     = 0;
parameter CSR_LVL_VAL_24_ACCESS     = "RW";
parameter CSR_LVL_VAL_24_VOLATILE   = 0;
parameter CSR_LVL_VAL_24_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_24_HAS_RESET  = 1;

parameter CSR_LVL_VAL_25_SIZE       = 16;
parameter CSR_LVL_VAL_25_OFFSET     = 16;
parameter CSR_LVL_VAL_25_ACCESS     = "RW";
parameter CSR_LVL_VAL_25_VOLATILE   = 0;
parameter CSR_LVL_VAL_25_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_25_HAS_RESET  = 1;

/********************
*   LVL_VAL_26_27   *
********************/
typedef struct packed
{
  reg [31:16] lvl_val_26;
  reg [15: 0] lvl_val_27;
} lvl_val_26_27_reg_t;

parameter CSR_LVL_VAL_26_SIZE       = 16;
parameter CSR_LVL_VAL_26_OFFSET     = 0;
parameter CSR_LVL_VAL_26_ACCESS     = "RW";
parameter CSR_LVL_VAL_26_VOLATILE   = 0;
parameter CSR_LVL_VAL_26_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_26_HAS_RESET  = 1;

parameter CSR_LVL_VAL_27_SIZE       = 16;
parameter CSR_LVL_VAL_27_OFFSET     = 16;
parameter CSR_LVL_VAL_27_ACCESS     = "RW";
parameter CSR_LVL_VAL_27_VOLATILE   = 0;
parameter CSR_LVL_VAL_27_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_27_HAS_RESET  = 1;

/********************
*   LVL_VAL_28_29   *
********************/
typedef struct packed
{
  reg [31:16] lvl_val_28;
  reg [15: 0] lvl_val_29;
} lvl_val_28_29_reg_t;

parameter CSR_LVL_VAL_28_SIZE       = 16;
parameter CSR_LVL_VAL_28_OFFSET     = 0;
parameter CSR_LVL_VAL_28_ACCESS     = "RW";
parameter CSR_LVL_VAL_28_VOLATILE   = 0;
parameter CSR_LVL_VAL_28_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_28_HAS_RESET  = 1;

parameter CSR_LVL_VAL_29_SIZE       = 16;
parameter CSR_LVL_VAL_29_OFFSET     = 16;
parameter CSR_LVL_VAL_29_ACCESS     = "RW";
parameter CSR_LVL_VAL_29_VOLATILE   = 0;
parameter CSR_LVL_VAL_29_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_29_HAS_RESET  = 1;

/********************
*   LVL_VAL_30_31   *
********************/
typedef struct packed
{
  reg [31:16] lvl_val_30;
  reg [15: 0] lvl_val_31;
} lvl_val_30_31_reg_t;

parameter CSR_LVL_VAL_30_SIZE       = 16;
parameter CSR_LVL_VAL_30_OFFSET     = 0;
parameter CSR_LVL_VAL_30_ACCESS     = "RW";
parameter CSR_LVL_VAL_30_VOLATILE   = 0;
parameter CSR_LVL_VAL_30_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_30_HAS_RESET  = 1;

parameter CSR_LVL_VAL_31_SIZE       = 16;
parameter CSR_LVL_VAL_31_OFFSET     = 16;
parameter CSR_LVL_VAL_31_ACCESS     = "RW";
parameter CSR_LVL_VAL_31_VOLATILE   = 0;
parameter CSR_LVL_VAL_31_RESET_VAL  = 'd0;
parameter CSR_LVL_VAL_31_HAS_RESET  = 1;

/********************
*   CSR_REG_BLOCK   *
********************/
typedef struct packed
{
  status_reg_t        status;
  control_reg_t       control;
  params_reg_t        params;
  lvl_val_00_01_reg_t lvl_val_00_01;
  lvl_val_02_03_reg_t lvl_val_02_03;
  lvl_val_04_05_reg_t lvl_val_04_05;
  lvl_val_06_07_reg_t lvl_val_06_07;
  lvl_val_08_09_reg_t lvl_val_08_09;
  lvl_val_10_11_reg_t lvl_val_10_11;
  lvl_val_12_13_reg_t lvl_val_12_13;
  lvl_val_14_15_reg_t lvl_val_14_15;
  lvl_val_16_17_reg_t lvl_val_16_17;
  lvl_val_18_19_reg_t lvl_val_18_19;
  lvl_val_20_21_reg_t lvl_val_20_21;
  lvl_val_22_23_reg_t lvl_val_22_23;
  lvl_val_24_25_reg_t lvl_val_24_25;
  lvl_val_26_27_reg_t lvl_val_26_27;
  lvl_val_28_29_reg_t lvl_val_28_29;
  lvl_val_30_31_reg_t lvl_val_30_31;
} csr_reg_block_t;

parameter CSR_REG_BLOCK_SIZE                  = 256;
parameter CSR_REG_BLOCK_OFFSET                = 'h0030_0000;
parameter CSR_REG_BLOCK_START                 = CSR_REG_BLOCK_OFFSET;
parameter CSR_REG_BLOCK_END                   = CSR_REG_BLOCK_START + CSR_REG_BLOCK_SIZE - 'd1;

parameter CSR_REG_BLOCK_STATUS_SIZE           = 4;
parameter CSR_REG_BLOCK_STATUS_OFFSET         = 'h0000_0000;
parameter CSR_REG_BLOCK_STATUS_START          = CSR_REG_BLOCK_OFFSET + CSR_REG_BLOCK_STATUS_OFFSET;
parameter CSR_REG_BLOCK_STATUS_END            = CSR_REG_BLOCK_STATUS_START + CSR_REG_BLOCK_STATUS_SIZE - 'd1;

parameter CSR_REG_BLOCK_CONTROL_SIZE          = 4;
parameter CSR_REG_BLOCK_CONTROL_OFFSET        = 'h0000_0004;
parameter CSR_REG_BLOCK_CONTROL_START         = CSR_REG_BLOCK_OFFSET + CSR_REG_BLOCK_CONTROL_OFFSET;
parameter CSR_REG_BLOCK_CONTROL_END           = CSR_REG_BLOCK_CONTROL_START + CSR_REG_BLOCK_CONTROL_SIZE - 'd1;

parameter CSR_REG_BLOCK_PARAMS_SIZE           = 4;
parameter CSR_REG_BLOCK_PARAMS_OFFSET         = 'h0000_0008;
parameter CSR_REG_BLOCK_PARAMS_START          = CSR_REG_BLOCK_OFFSET + CSR_REG_BLOCK_PARAMS_OFFSET;
parameter CSR_REG_BLOCK_PARAMS_END            = CSR_REG_BLOCK_PARAMS_START + CSR_REG_BLOCK_PARAMS_SIZE - 'd1;

parameter CSR_REG_BLOCK_LVL_VAL_00_01_SIZE    = 4;
parameter CSR_REG_BLOCK_LVL_VAL_00_01_OFFSET  = 'h0000_000C;
parameter CSR_REG_BLOCK_LVL_VAL_00_01_START   = CSR_REG_BLOCK_OFFSET + CSR_REG_BLOCK_LVL_VAL_00_01_OFFSET;
parameter CSR_REG_BLOCK_LVL_VAL_00_01_END     = CSR_REG_BLOCK_LVL_VAL_00_01_START + CSR_REG_BLOCK_LVL_VAL_00_01_SIZE - 'd1;

parameter CSR_REG_BLOCK_LVL_VAL_02_03_SIZE    = 4;
parameter CSR_REG_BLOCK_LVL_VAL_02_03_OFFSET  = 'h0000_0010;
parameter CSR_REG_BLOCK_LVL_VAL_02_03_START   = CSR_REG_BLOCK_OFFSET + CSR_REG_BLOCK_LVL_VAL_02_03_OFFSET;
parameter CSR_REG_BLOCK_LVL_VAL_02_03_END     = CSR_REG_BLOCK_LVL_VAL_02_03_START + CSR_REG_BLOCK_LVL_VAL_02_03_SIZE - 'd1;

parameter CSR_REG_BLOCK_LVL_VAL_04_05_SIZE    = 4;
parameter CSR_REG_BLOCK_LVL_VAL_04_05_OFFSET  = 'h0000_0014;
parameter CSR_REG_BLOCK_LVL_VAL_04_05_START   = CSR_REG_BLOCK_OFFSET + CSR_REG_BLOCK_LVL_VAL_04_05_OFFSET;
parameter CSR_REG_BLOCK_LVL_VAL_04_05_END     = CSR_REG_BLOCK_LVL_VAL_04_05_START + CSR_REG_BLOCK_LVL_VAL_04_05_SIZE - 'd1;

parameter CSR_REG_BLOCK_LVL_VAL_06_07_SIZE    = 4;
parameter CSR_REG_BLOCK_LVL_VAL_06_07_OFFSET  = 'h0000_0018;
parameter CSR_REG_BLOCK_LVL_VAL_06_07_START   = CSR_REG_BLOCK_OFFSET + CSR_REG_BLOCK_LVL_VAL_06_07_OFFSET;
parameter CSR_REG_BLOCK_LVL_VAL_06_07_END     = CSR_REG_BLOCK_LVL_VAL_06_07_START + CSR_REG_BLOCK_LVL_VAL_06_07_SIZE - 'd1;

parameter CSR_REG_BLOCK_LVL_VAL_08_09_SIZE    = 4;
parameter CSR_REG_BLOCK_LVL_VAL_08_09_OFFSET  = 'h0000_001C;
parameter CSR_REG_BLOCK_LVL_VAL_08_09_START   = CSR_REG_BLOCK_OFFSET + CSR_REG_BLOCK_LVL_VAL_08_09_OFFSET;
parameter CSR_REG_BLOCK_LVL_VAL_08_09_END     = CSR_REG_BLOCK_LVL_VAL_08_09_START + CSR_REG_BLOCK_LVL_VAL_08_09_SIZE - 'd1;

parameter CSR_REG_BLOCK_LVL_VAL_10_11_SIZE    = 4;
parameter CSR_REG_BLOCK_LVL_VAL_10_11_OFFSET  = 'h0000_0020;
parameter CSR_REG_BLOCK_LVL_VAL_10_11_START   = CSR_REG_BLOCK_OFFSET + CSR_REG_BLOCK_LVL_VAL_10_11_OFFSET;
parameter CSR_REG_BLOCK_LVL_VAL_10_11_END     = CSR_REG_BLOCK_LVL_VAL_10_11_START + CSR_REG_BLOCK_LVL_VAL_10_11_SIZE - 'd1;

parameter CSR_REG_BLOCK_LVL_VAL_12_13_SIZE    = 4;
parameter CSR_REG_BLOCK_LVL_VAL_12_13_OFFSET  = 'h0000_0024;
parameter CSR_REG_BLOCK_LVL_VAL_12_13_START   = CSR_REG_BLOCK_OFFSET + CSR_REG_BLOCK_LVL_VAL_12_13_OFFSET;
parameter CSR_REG_BLOCK_LVL_VAL_12_13_END     = CSR_REG_BLOCK_LVL_VAL_12_13_START + CSR_REG_BLOCK_LVL_VAL_12_13_SIZE - 'd1;

parameter CSR_REG_BLOCK_LVL_VAL_14_15_SIZE    = 4;
parameter CSR_REG_BLOCK_LVL_VAL_14_15_OFFSET  = 'h0000_0028;
parameter CSR_REG_BLOCK_LVL_VAL_14_15_START   = CSR_REG_BLOCK_OFFSET + CSR_REG_BLOCK_LVL_VAL_14_15_OFFSET;
parameter CSR_REG_BLOCK_LVL_VAL_14_15_END     = CSR_REG_BLOCK_LVL_VAL_14_15_START + CSR_REG_BLOCK_LVL_VAL_14_15_SIZE - 'd1;

parameter CSR_REG_BLOCK_LVL_VAL_16_17_SIZE    = 4;
parameter CSR_REG_BLOCK_LVL_VAL_16_17_OFFSET  = 'h0000_002C;
parameter CSR_REG_BLOCK_LVL_VAL_16_17_START   = CSR_REG_BLOCK_OFFSET + CSR_REG_BLOCK_LVL_VAL_16_17_OFFSET;
parameter CSR_REG_BLOCK_LVL_VAL_16_17_END     = CSR_REG_BLOCK_LVL_VAL_16_17_START + CSR_REG_BLOCK_LVL_VAL_16_17_SIZE - 'd1;

parameter CSR_REG_BLOCK_LVL_VAL_18_19_SIZE    = 4;
parameter CSR_REG_BLOCK_LVL_VAL_18_19_OFFSET  = 'h0000_0030;
parameter CSR_REG_BLOCK_LVL_VAL_18_19_START   = CSR_REG_BLOCK_OFFSET + CSR_REG_BLOCK_LVL_VAL_18_19_OFFSET;
parameter CSR_REG_BLOCK_LVL_VAL_18_19_END     = CSR_REG_BLOCK_LVL_VAL_18_19_START + CSR_REG_BLOCK_LVL_VAL_18_19_SIZE - 'd1;

parameter CSR_REG_BLOCK_LVL_VAL_20_21_SIZE    = 4;
parameter CSR_REG_BLOCK_LVL_VAL_20_21_OFFSET  = 'h0000_0034;
parameter CSR_REG_BLOCK_LVL_VAL_20_21_START   = CSR_REG_BLOCK_OFFSET + CSR_REG_BLOCK_LVL_VAL_20_21_OFFSET;
parameter CSR_REG_BLOCK_LVL_VAL_20_21_END     = CSR_REG_BLOCK_LVL_VAL_20_21_START + CSR_REG_BLOCK_LVL_VAL_20_21_SIZE - 'd1;

parameter CSR_REG_BLOCK_LVL_VAL_22_23_SIZE    = 4;
parameter CSR_REG_BLOCK_LVL_VAL_22_23_OFFSET  = 'h0000_0038;
parameter CSR_REG_BLOCK_LVL_VAL_22_23_START   = CSR_REG_BLOCK_OFFSET + CSR_REG_BLOCK_LVL_VAL_22_23_OFFSET;
parameter CSR_REG_BLOCK_LVL_VAL_22_23_END     = CSR_REG_BLOCK_LVL_VAL_22_23_START + CSR_REG_BLOCK_LVL_VAL_22_23_SIZE - 'd1;

parameter CSR_REG_BLOCK_LVL_VAL_24_25_SIZE    = 4;
parameter CSR_REG_BLOCK_LVL_VAL_24_25_OFFSET  = 'h0000_003C;
parameter CSR_REG_BLOCK_LVL_VAL_24_25_START   = CSR_REG_BLOCK_OFFSET + CSR_REG_BLOCK_LVL_VAL_24_25_OFFSET;
parameter CSR_REG_BLOCK_LVL_VAL_24_25_END     = CSR_REG_BLOCK_LVL_VAL_24_25_START + CSR_REG_BLOCK_LVL_VAL_24_25_SIZE - 'd1;

parameter CSR_REG_BLOCK_LVL_VAL_26_27_SIZE    = 4;
parameter CSR_REG_BLOCK_LVL_VAL_26_27_OFFSET  = 'h0000_0040;
parameter CSR_REG_BLOCK_LVL_VAL_26_27_START   = CSR_REG_BLOCK_OFFSET + CSR_REG_BLOCK_LVL_VAL_26_27_OFFSET;
parameter CSR_REG_BLOCK_LVL_VAL_26_27_END     = CSR_REG_BLOCK_LVL_VAL_26_27_START + CSR_REG_BLOCK_LVL_VAL_26_27_SIZE - 'd1;

parameter CSR_REG_BLOCK_LVL_VAL_28_29_SIZE    = 4;
parameter CSR_REG_BLOCK_LVL_VAL_28_29_OFFSET  = 'h0000_0044;
parameter CSR_REG_BLOCK_LVL_VAL_28_29_START   = CSR_REG_BLOCK_OFFSET + CSR_REG_BLOCK_LVL_VAL_28_29_OFFSET;
parameter CSR_REG_BLOCK_LVL_VAL_28_29_END     = CSR_REG_BLOCK_LVL_VAL_28_29_START + CSR_REG_BLOCK_LVL_VAL_28_29_SIZE - 'd1;

parameter CSR_REG_BLOCK_LVL_VAL_30_31_SIZE    = 4;
parameter CSR_REG_BLOCK_LVL_VAL_30_31_OFFSET  = 'h0000_0048;
parameter CSR_REG_BLOCK_LVL_VAL_30_31_START   = CSR_REG_BLOCK_OFFSET + CSR_REG_BLOCK_LVL_VAL_30_31_OFFSET;
parameter CSR_REG_BLOCK_LVL_VAL_30_31_END     = CSR_REG_BLOCK_LVL_VAL_30_31_START + CSR_REG_BLOCK_LVL_VAL_30_31_SIZE - 'd1;

endpackage
