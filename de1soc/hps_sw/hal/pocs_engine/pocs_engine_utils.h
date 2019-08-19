#ifndef _POCS_ENGINE_UTILS_H_
#define _POCS_ENGINE_UTILS_H_

#include <stdint.h>
#include "pocs_engine/pocs_engine_regs.h"
#include "pocs_engine/pocs_engine_drv.h"

void pocs_engine_dump_csr(pocs_engine_csr_t* csr);
void pocs_engine_dump_csr_status(uint32_t status);
void pocs_engine_dump_csr_params(uint32_t params);
void pocs_engine_dump_csr_lvls_values(uint32_t* lvls_values, uint32_t lvls_num);

#endif /* _POCS_ENGINE_UTILS_H_ */
