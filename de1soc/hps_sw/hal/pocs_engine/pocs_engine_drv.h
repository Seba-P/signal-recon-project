#ifndef _POCS_ENGINE_DRV_H_
#define _POCS_ENGINE_DRV_H_

#include <stdint.h>
#include "pocs_engine/pocs_engine_regs.h"

typedef struct
{
  uint8_t   iter_num;
  uint8_t   init_guess;
  uint8_t   init_lvl;
  uint8_t   lvls_num;
  uint16_t* lvls_values;
} pocs_engine_config_t;

typedef struct
{
  pocs_engine_csr_t*    csr;
  pocs_engine_config_t* config;
} pocs_engine_dev_t;

static inline void pocs_engine_run(pocs_engine_dev_t* dev)
{
  dev->csr->control = POCS_ENGINE_CONTROL_RUN_MASK;
}

static inline void pocs_engine_halt(pocs_engine_dev_t* dev)
{
  dev->csr->control = POCS_ENGINE_CONTROL_HALT_MASK;
}

static inline void pocs_engine_flush(pocs_engine_dev_t* dev)
{
  dev->csr->control = POCS_ENGINE_CONTROL_FLUSH_MASK;
}

static inline void pocs_engine_init(pocs_engine_dev_t* dev)
{
  dev->csr->control = POCS_ENGINE_CONTROL_INIT_MASK;
}

void pocs_engine_init_device(pocs_engine_dev_t* dev, pocs_engine_csr_t* csr, pocs_engine_config_t* config);
void pocs_engine_update_csr_config(pocs_engine_dev_t* dev, uint8_t restart);
void pocs_engine_update_params(pocs_engine_dev_t* dev);
void pocs_engine_update_lvls_values(pocs_engine_dev_t* dev);

/////////////////////
// STATUS register //
/////////////////////

uint32_t pocs_engine_get_status(pocs_engine_dev_t* dev);
uint32_t pocs_engine_get_status_busy(pocs_engine_dev_t* dev);
uint32_t pocs_engine_get_status_ready(pocs_engine_dev_t* dev);
uint32_t pocs_engine_get_status_error(pocs_engine_dev_t* dev);
uint32_t pocs_engine_get_status_fifo_err(pocs_engine_dev_t* dev);

/////////////////////
// PARAMS register //
/////////////////////

uint32_t pocs_engine_get_params(pocs_engine_dev_t* dev);
uint32_t pocs_engine_get_params_lvls_num(pocs_engine_dev_t* dev);
uint32_t pocs_engine_get_params_init_lvl(pocs_engine_dev_t* dev);
uint32_t pocs_engine_get_params_iter_num(pocs_engine_dev_t* dev);
uint32_t pocs_engine_get_params_init_guess(pocs_engine_dev_t* dev);

uint32_t pocs_engine_set_params(pocs_engine_dev_t* dev, uint32_t value, uint8_t update_config);
uint32_t pocs_engine_set_params_lvls_num(pocs_engine_dev_t* dev, uint32_t value, uint8_t update_config);
uint32_t pocs_engine_set_params_init_lvl(pocs_engine_dev_t* dev, uint32_t value, uint8_t update_config);
uint32_t pocs_engine_set_params_iter_num(pocs_engine_dev_t* dev, uint32_t value, uint8_t update_config);
uint32_t pocs_engine_set_params_init_guess(pocs_engine_dev_t* dev, uint32_t value, uint8_t update_config);

/////////////////////////////
// LVL_VAL_XX_YY registers //
/////////////////////////////

uint32_t pocs_engine_get_lvl_value(pocs_engine_dev_t* dev, uint32_t lvl_idx);
uint32_t pocs_engine_set_lvl_value(pocs_engine_dev_t* dev, uint32_t lvl_idx, uint32_t value, uint8_t update_config);

#endif /* _POCS_ENGINE_DRV_H_ */
