#ifndef _COMMON_SOC_H_
#define _COMMON_SOC_H_

#include "hwlib.h"
#include "socal/socal.h"
#include "socal/hps.h"

#include "fifo/fifo.h"
#include "sgdma/sgdma_drv.h"
#include "pocs_engine/pocs_engine_drv.h"
#include "hps_def.h"

// Settings for the LW HPS2FPGA AXI Bridge
#ifndef HW_LW_H2F_OFST
  #define HW_LW_H2F_OFST  (ALT_LWFPGASLVS_OFST) // starts at 0xFF200000
#endif

#ifndef HW_LW_H2F_SPAN
  #define HW_LW_H2F_SPAN  (0x00200000)          // 2 MB  address span
#endif

#ifndef HW_LW_H2F_MASK
  #define HW_LW_H2F_MASK  (HW_LW_H2F_SPAN - 1)  // ends at 0xFF3FFFFF
#endif


// Settings for the HPS2FPGA AXI Bridge
#ifndef ALT_HWFPGASLVS_OFST
  #define ALT_HWFPGASLVS_OFST (0xC0000000)
#endif

#ifndef HW_H2F_OFST
  #define HW_H2F_OFST         (ALT_HWFPGASLVS_OFST) // starts at 0xC0000000
#endif

#ifndef HW_H2F_SPAN
  #define HW_H2F_SPAN         (0x40000000)          // 1 GB address span
#endif

#ifndef HW_H2F_MASK
  #define HW_H2F_MASK         (HW_H2F_SPAN - 1)     // ends at 0xFFFFFFFF
#endif


// Settings for the FPGA Slaves address space
#ifndef HW_REGS_BASE
  #define HW_REGS_BASE  (ALT_HWFPGASLVS_OFST) // starts at 0xC0000000
#endif

#ifndef HW_REGS_SPAN
  #define HW_REGS_SPAN  (HW_H2F_SPAN)         // 1 GB address span - it's quite big portion of address space used, but for now it doesn't matter
#endif

#ifndef HW_REGS_MASK
  #define HW_REGS_MASK  (HW_REGS_SPAN - 1)    // ends at 0xFFFFFFFF
#endif


// Settings for SGDMA memory space
#ifndef SGDMA_RAM_SIZE
  #define SGDMA_RAM_SIZE        (0x4000)  // 16 kB
#endif

#ifndef MM2ST_SGDMA_RAM_OFST
  #define MM2ST_SGDMA_RAM_OFST  (0x0000)  // starts at 0x0000 offset from on-chip RAM
#endif

#ifndef ST2MM_SGDMA_RAM_OFST
  #define ST2MM_SGDMA_RAM_OFST  (0x4000)  // starts at 0x4000 offset from on-chip RAM
#endif


#ifndef MAX_DESC_COUNT
  #define MAX_DESC_COUNT  (8)             // each descriptor uses 32 B of memory 
#endif

#ifndef DESC_RAM_SIZE
  #define DESC_RAM_SIZE   (MAX_DESC_COUNT * sizeof(alt_sgdma_descriptor_t))  // 256 B (8 * 32 B)
#endif

#ifndef DESC_RAM_OFST
  #define DESC_RAM_OFST   (0x0000)        // starts at 0x0000(mm2st)/0x4000(st2mm) offset from on-chip RAM
#endif


#ifndef DATA_RAM_SIZE
  #define DATA_RAM_SIZE   (SGDMA_RAM_SIZE - DESC_RAM_SIZE)  // 16128 B (16 kB - 256 B)
#endif

#ifndef DATA_RAM_OFST
  #define DATA_RAM_OFST   (DESC_RAM_OFST + DESC_RAM_SIZE)   // starts at 0x0100(mm2st)/0x4100(st2mm) offset from on-chip RAM
#endif


#ifndef FIR_SDRAM_BASE
  #define FIR_SDRAM_BASE  (0x32000000)          // starts at 0x32000000
#endif

#ifndef FIR_SDRAM_SPAN
  #define FIR_SDRAM_SPAN  (0x8000)              // 64 kB address span
#endif

#ifndef FIR_SDRAM_MASK
  #define FIR_SDRAM_MASK  (FIR_SDRAM_SPAN - 1)  // ends at 0x32007FFF
#endif


#ifndef FIR_COEFFS_NR
  #define FIR_COEFFS_NR   (63)  // number of FIR coefficients
#endif

typedef struct
{
  void* led_pio;
  void* button_pio;
  void* dipsw_pio;
  void* sysid_qsys;
  void* onchip_ram;
  void* mm2st_csr;
  void* st2mm_csr;
  void* fifoin_csr;
  void* fifoout_csr;
  void* pocs_engine_csr;
} h2f_lw_addr_map_t;

typedef struct
{
  void* mm2st_ram;
  void* st2mm_ram;
} f2h_addr_map_t;

// Pointers to the different address spaces
extern void*              g_virtual_base;
extern void*              g_fir_sdram_base;
extern h2f_lw_addr_map_t  g_h2f_lw;
extern f2h_addr_map_t     g_f2h;
 
extern int  g_virt_base_ofst;
extern int  g_fir_sdram_base_ofst;
extern int  g_devmem_fd;
 
// SGDMA controllers
extern alt_sgdma_dev_t  g_mm2st;
extern alt_sgdma_dev_t  g_st2mm;

// FIR FIFOs
extern alt_sc_fifo_dev_t  g_fifo_in;
extern alt_sc_fifo_dev_t  g_fifo_out;

// POCS ENGINE
extern pocs_engine_dev_t  g_pocs_engine;

#endif /* _COMMON_SOC_H_ */
