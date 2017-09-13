#ifndef _MAIN_H_
#define _MAIN_H_

#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>

#include "hwlib.h"
#include "socal/socal.h"
#include "socal/hps.h"
#include "sgdma_drv.h"
#include "fifo.h"
#include "hps_def.h"

// Settings for the LW HPS2FPGA AXI Bridge
#define HW_LW_H2F_OFST		(ALT_LWFPGASLVS_OFST)	// starts at 0xFF200000
#define HW_LW_H2F_SPAN		(0x00200000) 			// 2 MB	address span
#define HW_LW_H2F_MASK		(HW_LW_H2F_SPAN - 1)	// ends at 0xFF3FFFFF

// Settings for the HPS2FPGA AXI Bridge
#define ALT_HWFPGASLVS_OFST (0xC0000000)
#define HW_H2F_OFST			(ALT_HWFPGASLVS_OFST)	// starts at 0xC0000000
#define HW_H2F_SPAN			(0x40000000)			// 1 GB address span 		
#define HW_H2F_MASK			(HW_H2F_SPAN - 1)		// ends at 0xFFFFFFFF

// Settings for the FPGA Slaves address space
#define HW_REGS_BASE		(ALT_HWFPGASLVS_OFST)	// starts at 0xC0000000
#define HW_REGS_SPAN		(HW_H2F_SPAN)			// 1 GB address span - it's quite big portion of address space used, but for now it doesn't matter
#define HW_REGS_MASK		(HW_REGS_SPAN - 1)		// ends at 0xFFFFFFFF

// Settings for SGDMA memory space
#define SGDMA_RAM_SIZE			(0x4000)			// 16 kB
#define SGDMA_MM2ST_RAM_OFST	(0x0000)			// starts at 0x0000 offset from on-chip RAM
#define SGDMA_ST2MM_RAM_OFST	(0x4000)			// starts at 0x4000 offset from on-chip RAM

#define MAX_DESC_COUNT			(8)													// each descriptor uses 32 B of memory 
#define DESC_RAM_SIZE			(MAX_DESC_COUNT * sizeof(alt_sgdma_descriptor_t))	// 256 B (8 * 32 B)
#define DESC_RAM_OFST 			(0x0000)											// starts at 0x0000(mm2st)/0x4000(st2mm) offset from on-chip RAM

#define DATA_RAM_SIZE			(SGDMA_RAM_SIZE - DESC_RAM_SIZE) 				// 16128 B (16 kB - 256 B)
#define DATA_RAM_OFST 			(DESC_RAM_OFST + DESC_RAM_SIZE)					// starts at 0x0100(mm2st)/0x4100(st2mm) offset from on-chip RAM

#define FIR_SDRAM_BASE			(0x32000000)			// starts at 0x32000000
#define FIR_SDRAM_SPAN			(0x8000) 				// 64 kB address span
#define FIR_SDRAM_MASK			(FIR_SDRAM_SPAN - 1)	// ends at 0x32007FFF

/* System components addressess:
	void *h2f_lw_led_addr; 			// LEDs via h2f_lw_axi_master
	void *h2f_lw_button_addr;		// Buttons via h2f_lw_axi_master
	void *h2f_lw_dipsw_addr;		// Dip switches via h2f_lw_axi_master
	void *h2f_lw_sysid_qsys_addr;	// System ID via h2f_lw_axi_master
	void *h2f_lw_onchip_ram_addr;	// Scratch pad (64kB) via h2f_axi_master
	void *h2f_lw_mm2st_csr_addr;	// SGDMA RAM for FIR output via f2sdram_axi_master
	void *f2sdram_mm2st_ram_addr;	// SGDMA MM2ST CSR via h2f_lw_axi_master
	void *h2f_lw_st2mm_csr_addr;	// SGDMA ST2MM CSR via h2f_lw_axi_master
	void *f2sdram_st2mm_ram_addr;	// SGDMA RAM fo FIR input via f2sdram_axi_master
	void *h2f_lw_fifoin_csr_addr;	// FIR input FIFO CSR via h2f_lw_axi_master
	void *h2f_lw_fifoout_csr_addr;	// FIR output FIFO CSR via h2f_lw_axi_master
*/

typedef struct
{
	void * /*const*/ led_pio;
	void * /*const*/ button_pio;
	void * /*const*/ dipsw_pio;
	void * /*const*/ sysid_qsys;
	void * /*const*/ onchip_ram;
	void * /*const*/ mm2st_csr;
	void * /*const*/ st2mm_csr;
	void * /*const*/ fifoin_csr;
	void * /*const*/ fifoout_csr;
} h2f_lw_addr_t;

typedef struct
{
	void * /*const*/ mm2st_ram;
	void * /*const*/ st2mm_ram;
} f2sdram_addr_t;

// Pointers to the different address spaces
void 			*g_virtual_base;
void 			*g_fir_sdram_base;
h2f_lw_addr_t 	g_h2f_lw;
f2sdram_addr_t 	g_f2sdram;

int g_virt_base_ofst;
int g_fir_sdram_base_ofst;
int g_devmem_fd;

// SGDMA controllers
alt_sgdma_dev_t g_mm2st;
alt_sgdma_dev_t g_st2mm;

// FIR FIFOs
alt_single_clock_fifo_t *g_fifo_in;
alt_single_clock_fifo_t *g_fifo_out;

// User files
FILE* g_input_file;
FILE* g_output_file;
FILE* g_log_file;

#define MAX_FILENAME_CHARS 	32
char g_input_file_name[MAX_FILENAME_CHARS] 	= "input.txt";
char g_output_file_name[MAX_FILENAME_CHARS] = "output.txt";
char g_log_file_name[MAX_FILENAME_CHARS] 	= "log.txt";

int g_log_flag		= 0;
int g_debug_flag	= 0;

void parse_cmdline(int argc, char** argv);
void init_files (void);
void init_sysbase(void);
void init_address_spaces(void);

void* get_physical_address(void *virt_addr, int virt_ofst);
void sig_handler(int signal);
void goto_exit(int exit_code);

#endif /* _MAIN_H_ */
