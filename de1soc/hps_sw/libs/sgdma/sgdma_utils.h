#ifndef _SGDMA_UTILS_H_
#define _SGDMA_UTILS_H_

#include <stdint.h>
#include "sgdma/sgdma_descriptor.h"
#include "sgdma/sgdma_drv.h"

void sgdma_dump_desc_status(uint8_t status);
void sgdma_dump_desc_control(uint8_t control);
void sgdma_dump_descriptor(alt_sgdma_descriptor_t* desc);

void sgdma_dump_csr_status(uint32_t status);
void sgdma_dump_csr_control(uint32_t control);
void sgdma_dump_csr(alt_sgdma_csr_t* csr);

#endif /* _SGDMA_UTILS_H_ */
