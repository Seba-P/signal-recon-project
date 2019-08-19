#ifndef _SGDMA_DRV_H_
#define _SGDMA_DRV_H_

#include <stdint.h>
#include "sgdma/sgdma_regs.h"
#include "sgdma/sgdma_descriptor.h"
#include "fifo/fifo.h"

typedef struct
{
  alt_sgdma_csr_t*        csr;
  alt_sgdma_descriptor_t* desc_ram;
  uint8_t*                data_ram;
} alt_sgdma_dev_t;

void sgdma_init_device(alt_sgdma_dev_t *dev, alt_sgdma_csr_t *csr,
                        alt_sgdma_descriptor_t *desc_ram, uint8_t *data_ram);

void sgdma_init_descriptor(alt_sgdma_descriptor_t *desc, alt_sgdma_descriptor_t *next,
                            uint32_t *read_addr, uint32_t *write_addr, uint16_t length);

static inline void sgdma_init_st2mm_descriptor(alt_sgdma_descriptor_t *desc, alt_sgdma_descriptor_t *next,
                                                uint32_t *write_addr, uint16_t length)
{
  sgdma_init_descriptor(desc, next, 0, write_addr, length);
}

static inline void sgdma_init_mm2st_descriptor(alt_sgdma_descriptor_t *desc, alt_sgdma_descriptor_t *next,
                                                uint32_t *read_addr, uint16_t length)
{
  sgdma_init_descriptor(desc, next, read_addr, 0, length);
}

uint8_t sgdma_start_transfer(alt_sgdma_csr_t *csr, alt_sgdma_descriptor_t *desc, uint8_t sync_transfer);

#endif /* _SGDMA_DRV_H_ */
