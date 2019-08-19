#include "common.h"
#include "pocs_engine/pocs_engine_drv.h"
#include "pocs_engine/pocs_engine_utils.h"

static uint32_t pocs_engine_write_reg(pocs_engine_dev_t* dev, uint32_t addr, uint32_t data, uint32_t mask, uint8_t update_config)
{
  uint32_t* csr_addr;
  uint32_t  csr_data;
  uint32_t  offset;
  uint32_t  tmp_mask;

  csr_addr  = (uint32_t*)(dev->csr + (uint8_t*)addr);
  
  offset    = 0;
  tmp_mask  = mask;

  if (mask == 0)
    return 0; // don't write anything and quit

  while (tmp_mask & 0x01) // look for position of the first '1' in bitmask
  {
    tmp_mask >>= 1;
    offset++;
  }

  if (mask != UINT32_MAX)
    csr_data = *csr_addr;
  // else
  //   csr_data = 0;

  csr_data &= ~mask;
  csr_data |= (data << offset) & mask;

  *csr_addr = csr_data;

  return 1;
}

static uint32_t pocs_engine_read_reg(pocs_engine_dev_t* dev, uint32_t addr, uint32_t mask)
{
  uint32_t* csr_addr;
  uint32_t  csr_data;
  uint32_t  offset;
  uint32_t  tmp_mask;

  csr_addr  = (uint32_t*)(dev->csr + (uint8_t*)addr);
  
  offset    = 0;
  tmp_mask  = mask;

  if (mask == 0)
    return 0; // don't read anything and quit

  while (tmp_mask & 0x01) // look for position of the first '1' in bitmask
  {
    tmp_mask >>= 1;
    offset++;
  }

  csr_data = *csr_addr;
  csr_data &= mask;
  csr_data >>= offset;

  return csr_data;
}

void pocs_engine_init_device(pocs_engine_dev_t* dev, pocs_engine_csr_t* csr, pocs_engine_config_t* config)
{
  dev->csr    = csr;
  dev->config = config;

  pocs_engine_halt(dev); // halt all current processing
  // pocs_engine_init(dev); // restart the POCS engine
}

void pocs_engine_update_csr_config(pocs_engine_dev_t* dev, uint8_t restart)
{
  pocs_engine_halt(dev); // halt all current processing

  // while ((dev->csr->status & POCS_ENGINE_STATUS_READY_MASK) == 0)
  //   {;}

  pocs_engine_update_params(dev);
  pocs_engine_update_lvls_values(dev);

  if (restart)
    pocs_engine_init(dev); // restart the POCS engine
}

void pocs_engine_update_params(pocs_engine_dev_t* dev)
{
  uint32_t tmp_reg;

  tmp_reg = 0;
  tmp_reg |= ((dev->config->lvls_num << POCS_ENGINE_PARAMS_LVLS_NUM_OFFSET) & POCS_ENGINE_PARAMS_LVLS_NUM_MASK);
  tmp_reg |= ((dev->config->init_lvl << POCS_ENGINE_PARAMS_INIT_LVL_OFFSET) & POCS_ENGINE_PARAMS_INIT_LVL_MASK);
  tmp_reg |= ((dev->config->iter_num << POCS_ENGINE_PARAMS_ITER_NUM_OFFSET) & POCS_ENGINE_PARAMS_ITER_NUM_MASK);
  tmp_reg |= ((dev->config->init_guess << POCS_ENGINE_PARAMS_INIT_GUESS_OFFSET) & POCS_ENGINE_PARAMS_INIT_GUESS_MASK);

  dev->csr->params = tmp_reg;
}

void pocs_engine_update_lvls_values(pocs_engine_dev_t* dev)
{
  uint32_t tmp_reg;

  for (int i = 0; i < dev->config->lvls_num/2; i++)
  {
    tmp_reg = 0;
    tmp_reg |= ((dev->config->lvls_values[2*i] << POCS_ENGINE_LVL_VAL_XX_OFFSET) & POCS_ENGINE_LVL_VAL_XX_MASK);
    tmp_reg |= ((dev->config->lvls_values[2*i+1] << POCS_ENGINE_LVL_VAL_YY_OFFSET) & POCS_ENGINE_LVL_VAL_YY_MASK);

    dev->csr->lvl_val_xx_yy[i] = tmp_reg;
  }

  if (dev->config->lvls_num % 2)
  {
    tmp_reg = dev->csr->lvl_val_xx_yy[dev->config->lvls_num/2+1];
    tmp_reg &= ~POCS_ENGINE_LVL_VAL_XX_MASK;
    tmp_reg |= ((dev->config->lvls_values[dev->config->lvls_num] << POCS_ENGINE_LVL_VAL_XX_OFFSET) & POCS_ENGINE_LVL_VAL_XX_MASK);

    dev->csr->lvl_val_xx_yy[dev->config->lvls_num/2+1] = tmp_reg;
  }
}

/////////////////////
// STATUS register //
/////////////////////

uint32_t pocs_engine_get_status(pocs_engine_dev_t* dev)
{
  return pocs_engine_read_reg(dev, POCS_ENGINE_STATUS_OFFSET, UINT32_MAX);
}

uint32_t pocs_engine_get_status_busy(pocs_engine_dev_t* dev)
{
  return pocs_engine_read_reg(dev, POCS_ENGINE_STATUS_OFFSET, POCS_ENGINE_STATUS_BUSY_MASK);
}

uint32_t pocs_engine_get_status_ready(pocs_engine_dev_t* dev)
{
  return pocs_engine_read_reg(dev, POCS_ENGINE_STATUS_OFFSET, POCS_ENGINE_STATUS_READY_MASK);
}

uint32_t pocs_engine_get_status_error(pocs_engine_dev_t* dev)
{
  return pocs_engine_read_reg(dev, POCS_ENGINE_STATUS_OFFSET, POCS_ENGINE_STATUS_ERROR_MASK);
}

uint32_t pocs_engine_get_status_fifo_err(pocs_engine_dev_t* dev)
{
  return pocs_engine_read_reg(dev, POCS_ENGINE_STATUS_OFFSET, POCS_ENGINE_STATUS_FIFO_ERR_MASK);
}

/////////////////////
// PARAMS register //
/////////////////////

uint32_t pocs_engine_get_params(pocs_engine_dev_t* dev)
{
  return pocs_engine_read_reg(dev, POCS_ENGINE_PARAMS_OFFSET, UINT32_MAX);
}

uint32_t pocs_engine_set_params(pocs_engine_dev_t* dev, uint32_t value, uint8_t update_config)
{
  uint32_t ret_val;

  ret_val = pocs_engine_write_reg(dev, POCS_ENGINE_PARAMS_OFFSET, value, UINT32_MAX);

  if (ret_val && update_config)
  {
    dev->config->lvls_num   = ((value & POCS_ENGINE_PARAMS_LVLS_NUM_MASK) >> POCS_ENGINE_PARAMS_LVLS_NUM_OFFSET);
    dev->config->init_lvl   = ((value & POCS_ENGINE_PARAMS_INIT_LVL_MASK) >> POCS_ENGINE_PARAMS_INIT_LVL_OFFSET);
    dev->config->iter_num   = ((value & POCS_ENGINE_PARAMS_ITER_NUM_MASK) >> POCS_ENGINE_PARAMS_ITER_NUM_OFFSET);
    dev->config->init_guess = ((value & POCS_ENGINE_PARAMS_INIT_GUESS_MASK) >> POCS_ENGINE_PARAMS_INIT_GUESS_OFFSET);
  }

  return ret_val;
}

uint32_t pocs_engine_get_params_lvls_num(pocs_engine_dev_t* dev)
{
  return pocs_engine_read_reg(dev, POCS_ENGINE_PARAMS_OFFSET, POCS_ENGINE_PARAMS_LVLS_NUM_MASK);
}

uint32_t pocs_engine_set_params_lvls_num(pocs_engine_dev_t* dev, uint32_t value, uint8_t update_config)
{
  uint32_t ret_val;

  ret_val = pocs_engine_write_reg(dev, POCS_ENGINE_PARAMS_OFFSET, value, POCS_ENGINE_PARAMS_LVLS_NUM_MASK);
  
  if (ret_val && update_config)
    dev->config->lvls_num = value;

  return ret_val;
}

uint32_t pocs_engine_get_params_init_lvl(pocs_engine_dev_t* dev)
{
  return pocs_engine_read_reg(dev, POCS_ENGINE_PARAMS_OFFSET, POCS_ENGINE_PARAMS_INIT_LVL_MASK);
}

uint32_t pocs_engine_set_params_init_lvl(pocs_engine_dev_t* dev, uint32_t value, uint8_t update_config)
{
  uint32_t ret_val;

  ret_val = pocs_engine_write_reg(dev, POCS_ENGINE_PARAMS_OFFSET, value, POCS_ENGINE_PARAMS_INIT_LVL_MASK);
  
  if (ret_val && update_config)
    dev->config->init_lvl = value;

  return ret_val;
}

uint32_t pocs_engine_get_params_iter_num(pocs_engine_dev_t* dev)
{
  return pocs_engine_read_reg(dev, POCS_ENGINE_PARAMS_OFFSET, POCS_ENGINE_PARAMS_ITER_NUM_MASK);
}

uint32_t pocs_engine_set_params_iter_num(pocs_engine_dev_t* dev, uint32_t value, uint8_t update_config)
{
  uint32_t ret_val;

  ret_val = pocs_engine_write_reg(dev, POCS_ENGINE_PARAMS_OFFSET, value, POCS_ENGINE_PARAMS_ITER_NUM_MASK);
  
  if (ret_val && update_config)
    dev->config->iter_num = value;

  return ret_val;
}

uint32_t pocs_engine_get_params_init_guess(pocs_engine_dev_t* dev)
{
  return pocs_engine_read_reg(dev, POCS_ENGINE_PARAMS_OFFSET, POCS_ENGINE_PARAMS_INIT_GUESS_MASK);
}

uint32_t pocs_engine_set_params_init_guess(pocs_engine_dev_t* dev, uint32_t value, uint8_t update_config)
{
  uint32_t ret_val;

  ret_val = pocs_engine_write_reg(dev, POCS_ENGINE_PARAMS_OFFSET, value, POCS_ENGINE_PARAMS_INIT_GUESS_MASK);
  
  if (ret_val && update_config)
    dev->config->init_guess = value;

  return ret_val;
}

/////////////////////////////
// LVL_VAL_XX_YY registers //
/////////////////////////////

uint32_t pocs_engine_get_lvl_value(pocs_engine_dev_t* dev, uint32_t lvl_idx)
{
  uint32_t addr;
  uint32_t mask;

  addr = POCS_ENGINE_LVL_VAL_XX_YY_OFFSET + (0x04 * (lvl_idx/2));
  mask = (lvl_idx % 2) ? POCS_ENGINE_LVL_VAL_YY_MASK : POCS_ENGINE_LVL_VAL_XX_MASK;

  return pocs_engine_read_reg(dev, addr, mask);
}

uint32_t pocs_engine_set_lvl_value(pocs_engine_dev_t* dev, uint32_t lvl_idx, uint32_t value, uint8_t update_config)
{
  uint32_t addr;
  uint32_t mask;
  uint32_t ret_val;

  addr = POCS_ENGINE_LVL_VAL_XX_YY_OFFSET + (0x04 * (lvl_idx/2));
  mask = (lvl_idx % 2) ? POCS_ENGINE_LVL_VAL_YY_MASK : POCS_ENGINE_LVL_VAL_XX_MASK;

  ret_val = pocs_engine_write_reg(dev, addr, value, mask);
  
  if (ret_val && update_config)
    dev->config->lvls_values[lvl_idx] = value;

  return ret_val;
}
