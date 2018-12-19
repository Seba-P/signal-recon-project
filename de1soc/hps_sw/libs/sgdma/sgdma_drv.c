#include "common.h"
#include "sgdma/sgdma_drv.h"
#include "sgdma/sgdma_utils.h"

void sgdma_init_device(alt_sgdma_dev_t *dev, alt_sgdma_csr_t *csr,
                        alt_sgdma_descriptor_t *desc_ram, uint8_t *data_ram)
{
  dev->csr      = csr;
  dev->desc_ram = desc_ram;
  dev->data_ram = data_ram;

  dev->csr->control             = 0;
  dev->csr->status              = 0xFF;
  dev->desc_ram[0].desc_control = 0;
  dev->desc_ram[0].desc_status  = 0;
}

void sgdma_init_descriptor(alt_sgdma_descriptor_t *desc, alt_sgdma_descriptor_t *next,
                            uint32_t *read_addr, uint32_t *write_addr, uint16_t length)
{
  if (next)
    next->desc_control &= ~SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_MSK;

  desc->source                    = read_addr ? get_physical_address(read_addr, g_fir_sdram_base_ofst) : NULL;
  desc->source_pad                = 0;
  desc->destination               = write_addr ? get_physical_address(write_addr, g_fir_sdram_base_ofst) : NULL;
  desc->destination_pad           = 0;
  desc->next_desc_ptr             = next ? get_physical_address(next, g_fir_sdram_base_ofst) : NULL;
  desc->next_desc_ptr_pad         = 0;
  desc->bytes_to_transfer         = length;
  desc->bytes_to_transfer_pad     = 0;
  desc->actual_bytes_transferred  = 0;
  desc->desc_status               = 0;
  desc->desc_control              = SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_MSK; // write/read fixed addr ??
}

uint8_t sgdma_start_transfer(alt_sgdma_csr_t *csr, alt_sgdma_descriptor_t *desc, uint8_t sync_transfer, 
                              alt_single_clock_fifo_t* fifo)
{
  while (csr->status & SGDMA_STATUS_BUSY_MSK)
  {
    if (!sync_transfer)
      return -EBUSY;
  }

  csr->control            &= ~SGDMA_CONTROL_RUN_MSK;
  csr->status             = 0xFF;
  csr->next_desc_pointer  = (uint32_t)get_physical_address(desc, g_fir_sdram_base_ofst);

  //TODO: check if callback for async transfer is registered and enable/disable interrupt
  csr->control            |= (SGDMA_CONTROL_RUN_MSK | SGDMA_CONTROL_STOP_DMA_ER_MSK);

  if (!sync_transfer)
    return 0;

  while (csr->status & SGDMA_STATUS_BUSY_MSK)
    {;}

  csr->control    &= ~SGDMA_CONTROL_RUN_MSK;
  uint8_t status  = csr->status;
  csr->status     = 0xFF;

  return status;
}
