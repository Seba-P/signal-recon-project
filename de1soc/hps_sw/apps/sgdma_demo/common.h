#ifndef _COMMON_H_
#define _COMMON_H_

#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>

#include "sgdma_drv.h"
#include "fifo.h"
#include "colors.h"

// Logging macros
#define log_printf(format, ...) 	if(g_log_flag) \
										fprintf(g_log_file, format, ##__VA_ARGS__); \
									printf(format, ##__VA_ARGS__);
#define debug_printf(format, ...) 	if(g_debug_flag) \
									{ \
										fprintf(g_log_file, format, ##__VA_ARGS__); \
										printf(format, ##__VA_ARGS__); \
									}

// Pointers to the different address spaces
extern void *g_virtual_base;
extern void *g_fir_sdram_base;

extern int g_virt_base_ofst;
extern int g_fir_sdram_base_ofst;

// FIR FIFOs
extern alt_single_clock_fifo_t *g_fifo_in;
extern alt_single_clock_fifo_t *g_fifo_out;

// User files
extern FILE* g_log_file;

extern int g_log_flag;
extern int g_debug_flag;

void* get_physical_address(void *virt_addr, int virt_ofst);
void goto_exit(int exit_code);

#endif /* _COMMON_H_ */
