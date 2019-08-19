#ifndef _POCS_ENGINE_REGS_H_
#define _POCS_ENGINE_REGS_H_

#include <stdint.h>

#ifndef _PACKED_
  #define _PACKED_ __attribute__ ((packed,aligned(1)))
#endif

/********************
*      STATUS       *
********************/
// typedef struct
// {
//   uint8_t   busy        : 1;
//   uint8_t   ready       : 1;
//   uint8_t   error       : 1;
//   uint16_t  _reserved1  : 13;
//   uint8_t   fifo_err    : 1;
//   uint16_t  _reserved2  : 15;
// } _PACKED_ status_reg_t;

#define POCS_ENGINE_STATUS_BUSY_MASK        (0x00000001)
#define POCS_ENGINE_STATUS_BUSY_OFFSET      (0)

#define POCS_ENGINE_STATUS_READY_MASK       (0x00000002)
#define POCS_ENGINE_STATUS_READY_OFFSET     (1)

#define POCS_ENGINE_STATUS_ERROR_MASK       (0x00000004)
#define POCS_ENGINE_STATUS_ERROR_OFFSET     (2)

#define POCS_ENGINE_STATUS_FIFO_ERR_MASK    (0x00010000)
#define POCS_ENGINE_STATUS_FIFO_ERR_OFFSET  (16)

/********************
*      CONTROL      *
********************/
// typedef struct
// {
//   uint8_t  run        : 1;
//   uint8_t  halt       : 1;
//   uint8_t  flush      : 1;
//   uint8_t  init       : 1;
//   uint32_t _reserved1 : 28;
// } _PACKED_ control_reg_t;

#define POCS_ENGINE_CONTROL_RUN_MASK        (0x00000001)
#define POCS_ENGINE_CONTROL_RUN_OFFSET      (0)

#define POCS_ENGINE_CONTROL_HALT_MASK       (0x00000002)
#define POCS_ENGINE_CONTROL_HALT_OFFSET     (1)

#define POCS_ENGINE_CONTROL_FLUSH_MASK      (0x00000004)
#define POCS_ENGINE_CONTROL_FLUSH_OFFSET    (2)

#define POCS_ENGINE_CONTROL_INIT_MASK       (0x00000008)
#define POCS_ENGINE_CONTROL_INIT_OFFSET     (3)

/********************
*      PARAMS       *
********************/
// typedef struct
// {
//   uint8_t lvls_num    : 5;
//   uint8_t _reserved1  : 3;
//   uint8_t init_lvl    : 5;
//   uint8_t _reserved2  : 3;
//   uint8_t iter_num    : 4;
//   uint8_t _reserved3  : 4;
//   uint8_t init_guess  : 2;
//   uint8_t _reserved4  : 6;
// } _PACKED_ params_reg_t;

#define POCS_ENGINE_PARAMS_LVLS_NUM_MASK      (0x00000001F)
#define POCS_ENGINE_PARAMS_LVLS_NUM_OFFSET    (0)

#define POCS_ENGINE_PARAMS_INIT_LVL_MASK      (0x00001F00)
#define POCS_ENGINE_PARAMS_INIT_LVL_OFFSET    (8)

#define POCS_ENGINE_PARAMS_ITER_NUM_MASK      (0x000F0000)
#define POCS_ENGINE_PARAMS_ITER_NUM_OFFSET    (16)

#define POCS_ENGINE_PARAMS_INIT_GUESS_MASK    (0x03000000)
#define POCS_ENGINE_PARAMS_INIT_GUESS_OFFSET  (24)

/********************
*   LVL_VAL_XX_YY   *
********************/
// typedef struct
// {
//   uint16_t lvl_val_xx : 16;
//   uint16_t lvl_val_yy : 16;
// } _PACKED_ lvl_val_xx_yy_reg_t;

#define POCS_ENGINE_LVL_VAL_XX_MASK     (0x0000FFFF)
#define POCS_ENGINE_LVL_VAL_XX_OFFSET   (0)

#define POCS_ENGINE_LVL_VAL_YY_MASK     (0xFFFF0000)
#define POCS_ENGINE_LVL_VAL_YY_OFFSET   (16)

/********************
*   REGISTER_FILE   *
********************/
// typedef struct
// {
//   status_reg_t        status;
//   control_reg_t       control;
//   params_reg_t        params;
//   lvl_val_xx_yy_reg_t lvl_val_xx_yy[16];
// } _PACKED_ pocs_engine_csr_t;

#define POCS_ENGINE_STATUS_OFFSET         (0x0000)
#define POCS_ENGINE_CONTROL_OFFSET        (0x0004)
#define POCS_ENGINE_PARAMS_OFFSET         (0x0008)
#define POCS_ENGINE_LVL_VAL_XX_YY_OFFSET  (0x000C)

#define POCS_ENGINE_MAX_LVLS_NUM          (32)

typedef struct
{
  uint32_t status;
  uint32_t control;
  uint32_t params;
  uint32_t lvl_val_xx_yy[POCS_ENGINE_MAX_LVLS_NUM/2];
} _PACKED_ pocs_engine_csr_t;

#endif /* _POCS_ENGINE_REGS_H_ */
