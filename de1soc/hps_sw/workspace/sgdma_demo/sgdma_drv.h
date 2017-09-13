#ifndef _SGDMA_DRV_H_
#define _SGDMA_DRV_H_

#include <stdint.h>
#include "sgdma_regs.h"
#include "sgdma_descriptor.h"
#include "fifo.h"

/*
 * To ensure that a descriptor is created without spaces
 * between the struct members, we call upon GCC's ability
 * to pack to a byte-aligned boundary.
 */
#ifndef alt_avalon_sgdma_packed
    #define alt_avalon_sgdma_packed __attribute__ ((packed,aligned(1)))
#endif

typedef struct
{
	uint32_t status;
	uint32_t version;
	uint32_t version_pad[2];
	uint32_t control;
	uint32_t control_pad[3];
	uint32_t next_desc_pointer;
} alt_avalon_sgdma_packed alt_sgdma_csr_t;

typedef struct
{
	alt_sgdma_csr_t 		*csr;
	alt_sgdma_descriptor_t 	*desc_ram;
	uint8_t 				*data_ram;
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

uint8_t sgdma_start_transfer(alt_sgdma_csr_t *csr, alt_sgdma_descriptor_t *desc, uint8_t sync_transfer, 
											alt_single_clock_fifo_t* fifo);

#endif /* _SGDMA_DRV_H_ */
