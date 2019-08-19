#include "common.h"
#include "pocs_engine/pocs_engine_regs.h"
#include "pocs_engine/pocs_engine_drv.h"
#include "pocs_engine/pocs_engine_utils.h"

static const char* init_guess[] = { FG_YELLOW "ZERO-CONSTANT" C_RESET, FG_YELLOW "PIECEWISE-CONSTANT" C_RESET,
                                    FG_YELLOW "PIECEWISE-LINEAR" C_RESET, FG_RED "RESERVED" C_RESET };

void pocs_engine_dump_csr_status(uint32_t params)
{
  log_printf("\n  @ STATUS: (0x%08X)\n", status);
  log_printf("    BUSY      = %s\n", (status & POCS_ENGINE_STATUS_BUSY_MASK) ? FG_YELLOW "1" C_RESET : FG_YELLOW "0" C_RESET);
  log_printf("    READY     = %s\n", (status & POCS_ENGINE_STATUS_READY_MASK) ? FG_YELLOW "1" C_RESET : FG_YELLOW "0" C_RESET);
  log_printf("    ERROR     = %s\n", (status & POCS_ENGINE_STATUS_ERROR_MASK) ? FG_RED "1" C_RESET : FG_GREEN "0" C_RESET);
  log_printf("    FIFO_ERR  = %s\n", (status & POCS_ENGINE_STATUS_FIFO_ERR_MASK) ? FG_RED "1" C_RESET : FG_GREEN "0" C_RESET);
}

void pocs_engine_dump_csr_params(uint32_t params)
{
  log_printf("\n  @ CONTROL: (0x%08X)\n", params);
  log_printf("    LVLS_NUM:   %s%2d%s\n", FG_YELLOW,
              (params & POCS_ENGINE_PARAMS_LVLS_NUM_MASK) >> POCS_ENGINE_PARAMS_LVLS_NUM_OFFSET, C_RESET);
  log_printf("    INIT_LVL:   %s%2d%s\n", FG_YELLOW,
              (params & POCS_ENGINE_PARAMS_INIT_LVL_MASK) >> POCS_ENGINE_PARAMS_INIT_LVL_OFFSET, C_RESET);
  log_printf("    ITER_NUM:   %s%2d%s\n", FG_YELLOW,
              (params & POCS_ENGINE_PARAMS_ITER_NUM_MASK) >> POCS_ENGINE_PARAMS_ITER_NUM_OFFSET, C_RESET);
  log_printf("    INIT_GUESS: %s %s(%1d)%s\n", init_guess[(params&POCS_ENGINE_PARAMS_INIT_GUESS_MASK)>>POCS_ENGINE_PARAMS_INIT_GUESS_OFFSET],
              FG_YELLOW, (params & POCS_ENGINE_PARAMS_INIT_GUESS_MASK) >> POCS_ENGINE_PARAMS_INIT_GUESS_OFFSET, C_RESET);
}

void pocs_engine_dump_csr_lvls_values(uint32_t* lvls_values, uint32_t lvls_num)
{
  uint32_t reg_idx;
  uint32_t lvl_xx;
  uint32_t lvl_yy;

  for (reg_idx = 0; reg_idx < (lvls_num+1)/2; reg_idx++)
  {
    lvl_xx = 2 * reg_idx;
    lvl_yy = 2 * reg_idx + 1;

    log_printf("\n  @ LVL_VAL_%02d_%02d: (0x%08X)\n", lvl_xx, lvl_yy, lvls_values[reg_idx]);
    log_printf("    LVL_VAL_%02d:   0x%s%04X%s\n", lvl_xx, FG_YELLOW,
              (lvls_values[reg_idx] & POCS_ENGINE_LVL_VAL_XX_MASK) >> POCS_ENGINE_LVL_VAL_XX_OFFSET, C_RESET);
    if (!(lvls_num % 2))
      log_printf("    LVL_VAL_%02d:   0x%s%04X%s\n", lvl_yy, FG_YELLOW,
                (lvls_values[reg_idx] & POCS_ENGINE_LVL_VAL_YY_MASK) >> POCS_ENGINE_LVL_VAL_YY_OFFSET, C_RESET);
  }
}

void pocs_engine_dump_csr(pocs_engine_dev_t *dev)
{
  log_printf("\n----- POCS_ENGINE CSR @ %p (%p): -----\n", dev->csr, get_physical_address(dev->csr, g_virt_base_ofst));
  
  pocs_engine_dump_csr_status(dev->csr->status);
  pocs_engine_dump_csr_params(dev->csr->params);
  pocs_engine_dump_csr_lvls_values(dev->csr->lvl_val_xx_yy, POCS_ENGINE_MAX_LVLS_NUM);
}
