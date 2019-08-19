#include "common_soc.h"

// Pointers to the different address spaces
void*             g_virtual_base;
void*             g_fir_sdram_base;
h2f_lw_addr_map_t g_h2f_lw;
f2h_addr_map_t    g_f2h;
 
int g_virt_base_ofst;
int g_fir_sdram_base_ofst;
int g_devmem_fd;
 
// SGDMA controllers
alt_sgdma_dev_t g_mm2st;
alt_sgdma_dev_t g_st2mm;

// FIR FIFOs
alt_sc_fifo_dev_t g_fifo_in;
alt_sc_fifo_dev_t g_fifo_out;

// POCS ENGINE
pocs_engine_dev_t g_pocs_engine;
