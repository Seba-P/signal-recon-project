#include <errno.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/mman.h>
#include <signal.h>

#include "sgdma_utils.h"
#include "main.h"

int main(int argc, char** argv, char** envp)
{
	init_sysbase();
	init_address_spaces();

	// Configure LEDs
	printf("\n\nSet the LEDs on ...");
	*(uint32_t*)(g_h2f_lw.led_pio) = 0xAA;
	printf(" DONE!\n");

	// Initialize SGDMA controllers
	sgdma_init_device(&g_mm2st, g_h2f_lw.mm2st_csr, g_f2sdram.mm2st_ram + DESC_RAM_OFST,
						g_f2sdram.mm2st_ram + DATA_RAM_OFST);
	sgdma_init_device(&g_st2mm, g_h2f_lw.st2mm_csr, g_f2sdram.st2mm_ram + DESC_RAM_OFST,
						g_f2sdram.st2mm_ram + DATA_RAM_OFST);

	g_fifo_in 	= (alt_single_clock_fifo_t*)g_h2f_lw.fifoin_csr;
	g_fifo_out 	= (alt_single_clock_fifo_t*)g_h2f_lw.fifoout_csr;

	// Prepare on-chip memory
	printf("Initialize data RAM ...");
	for(int i = 0; i < DATA_RAM_SIZE; i++)
	{
		g_mm2st.data_ram[i] = i;
	}
	printf(" DONE!\n");

#if DEBUG
	// Check if data was initialized
	printf("\nData buffers (MM2ST/ST2MM):\n");
	for (int i = 0; i < DATA_RAM_SIZE/4; i++)
	{
		printf("0x%08X/0x%08X, ", ((uint32_t*)g_mm2st.data_ram)[i], ((uint32_t*)g_st2mm.data_ram)[i]);
	}
	printf("\b\b\n"); //delete last comma and start a new line
#endif
//-----------------------------------------------
	//Scatter Gather DMA controller

	// Initialize descriptors (8 desc in chain processing whole mm2st/st2mm data buffers)
	for(int i = 0; i < MAX_DESC_COUNT-1; i++)
	{
		uint16_t transfer_size = DATA_RAM_SIZE / MAX_DESC_COUNT;

		sgdma_init_mm2st_descriptor(&g_mm2st.desc_ram[i], &g_mm2st.desc_ram[(i+1) % MAX_DESC_COUNT],
								(uint32_t*)&g_mm2st.data_ram[i*transfer_size], transfer_size);
		g_mm2st.desc_ram[i].desc_control |= SGDMA_DESCRIPTOR_CONTROL_WRITE_FIXED_ADDRESS_MSK;
		sgdma_init_st2mm_descriptor(&g_st2mm.desc_ram[i], &g_st2mm.desc_ram[(i+1) % MAX_DESC_COUNT],
								(uint32_t*)&g_st2mm.data_ram[i*transfer_size], transfer_size);
		g_st2mm.desc_ram[i].desc_control |= SGDMA_DESCRIPTOR_CONTROL_READ_FIXED_ADDRESS_MSK;
	}
	g_mm2st.desc_ram[0].desc_control |= SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_MSK;
	g_st2mm.desc_ram[0].desc_control |= SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_MSK;

	// Print descriptors fields
#if DEBUG
	printf("\n\n##### MM2ST descriptors: #####");
	for(int i = 0; i < MAX_DESC_COUNT; i++)
	{
		sgdma_dump_descriptor(&g_mm2st.desc_ram[i]);
	}
	printf("\n\n##### ST2MM descriptors: #####");
	for(int i = 0; i < MAX_DESC_COUNT; i++)
	{
		sgdma_dump_descriptor(&g_st2mm.desc_ram[i]);
	}
	sleep(2);

	printf("\n##### MM2ST CSR: #####\n");
	sgdma_dump_csr(g_mm2st.csr);
	fifo_dump_csr(g_fifo_in);
	sleep(1);
	printf("\n##### ST2MM CSR: #####\n");
	sgdma_dump_csr(g_st2mm.csr);
	fifo_dump_csr(g_fifo_out);
	sleep(1);
#endif

	g_mm2st.csr->control &= ~SGDMA_CONTROL_RUN_MSK;
	g_mm2st.csr->status = 0xFF;
	g_st2mm.csr->control &= ~SGDMA_CONTROL_RUN_MSK;
	g_st2mm.csr->status = 0xFF;
	
	// Run transfer chain
	uint8_t status;
	status = sgdma_start_transfer(g_mm2st.csr, g_mm2st.desc_ram, 0, g_fifo_in);
	printf("\nMM2ST transfer %s! (0x%02X)\n", 
			status & SGDMA_STATUS_ERROR_MSK ? "FAILED" : "PASSED", status);
	if(status & SGDMA_STATUS_ERROR_MSK)
		goto_exit(1);

	status = sgdma_start_transfer(g_st2mm.csr, g_st2mm.desc_ram, 1, g_fifo_out);
	printf("\nST2MM transfer %s! (0x%02X)\n", 
			status & SGDMA_STATUS_ERROR_MSK ? "FAILED" : "PASSED", status);
	if(status & SGDMA_STATUS_ERROR_MSK)
		goto_exit(1);

	sleep(3);
	printf("\nUltimate MM2ST status:\n");
	sgdma_dump_csr(g_mm2st.csr);
	sgdma_dump_descriptor(&g_mm2st.desc_ram[MAX_DESC_COUNT-1]);
	fifo_dump_csr(g_fifo_in);
	
	printf("\nUltimate ST2MM status:\n");
	sgdma_dump_csr(g_st2mm.csr);
	sgdma_dump_descriptor(&g_st2mm.desc_ram[MAX_DESC_COUNT-1]);
	fifo_dump_csr(g_fifo_out);
	
#if DEBUG	
	// Validate buffers consistency
	printf("\nData buffers (MM2ST/ST2MM):\n");
	for (int i = 0; i < DATA_RAM_SIZE/4; i++)
	{
		printf("0x%08X/0x%08X, ", ((uint32_t*)g_mm2st.data_ram)[i], ((uint32_t*)g_st2mm.data_ram)[i]);
	}
	printf("\b\b\n"); //delete last comma and start a new line
#endif

	return 0;
}

void init_sysbase(void)
{
	if(signal(SIGINT, sig_handler) == SIG_ERR)
	{
		printf("ERROR: cannot handle SIGINT\n");
		exit(-1);
	}

	if((g_devmem_fd = open("/dev/mem", (O_RDWR | O_SYNC))) == -1)
	{
		printf("ERROR: could not open \"/dev/mem\"...\n");
		exit(-1);
	}

	// Map entire FPGA Slaves address space 
	g_virtual_base = mmap(NULL, HW_REGS_SPAN, (PROT_READ | PROT_WRITE), MAP_SHARED, g_devmem_fd, HW_REGS_BASE);
	if(g_virtual_base == MAP_FAILED)
	{
		printf("ERROR: g_virtual_base mmap() failed...\n");
		close(g_devmem_fd);
		exit(-1);
	}

	// Map FIR SDRAM address space 
	g_fir_sdram_base = mmap(NULL, FIR_SDRAM_SPAN, (PROT_READ | PROT_WRITE), MAP_SHARED, g_devmem_fd, FIR_SDRAM_BASE);
	if(g_fir_sdram_base == MAP_FAILED)
	{
		printf("ERROR: g_fir_sdram_base mmap() failed...\n");
		if(munmap(g_virtual_base, HW_REGS_SPAN) != 0)
		{
			printf("ERROR: g_virtual_base munmap() failed...\n");
		}

		close(g_devmem_fd);
		exit(-1);
	}

	// Calculate virtual base offset
	g_virt_base_ofst 		= HW_REGS_BASE - (uint32_t)g_virtual_base;
	g_fir_sdram_base_ofst 	= FIR_SDRAM_BASE - (uint32_t)g_fir_sdram_base;

#if DEBUG
	printf("\n----- Address space mapping: -----\n");
	printf("    HW_REGS_BASE            = %p\n", (void*)HW_REGS_BASE);
	printf("    g_virtual_base          = %p\n", g_virtual_base);
	printf("    g_virt_base_ofst        = %p\n\n", (void*)g_virt_base_ofst);
	printf("    FIR_SDRAM_BASE          = %p\n", (void*)FIR_SDRAM_BASE);
	printf("    g_fir_sdram_base        = %p\n", g_fir_sdram_base);
	printf("    g_fir_sdram_base_ofst   = %p\n", (void*)g_fir_sdram_base_ofst);
#endif
}

void init_address_spaces(void)
{
	// Map system components addresses
	g_h2f_lw = (h2f_lw_addr_t)
	{
		.led_pio 		= g_virtual_base + ((uint32_t)(ALT_LWFPGASLVS_OFST + LED_PIO_BASE) & (uint32_t)HW_REGS_MASK),
		.button_pio 	= g_virtual_base + ((uint32_t)(ALT_LWFPGASLVS_OFST + BUTTON_PIO_BASE) & (uint32_t)HW_REGS_MASK),
		.dipsw_pio 		= g_virtual_base + ((uint32_t)(ALT_LWFPGASLVS_OFST + DIPSW_PIO_BASE) & (uint32_t)HW_REGS_MASK),
		.sysid_qsys 	= g_virtual_base + ((uint32_t)(ALT_LWFPGASLVS_OFST + SYSID_QSYS_BASE) & (uint32_t)HW_REGS_MASK),
		.onchip_ram 	= g_virtual_base + ((uint32_t)(ALT_LWFPGASLVS_OFST + ONCHIP_RAM_BASE) & (uint32_t)HW_REGS_MASK),
		.mm2st_csr 		= g_virtual_base + ((uint32_t)(ALT_LWFPGASLVS_OFST + SGDMA_MM2ST_BASE) & (uint32_t)HW_REGS_MASK),
		.st2mm_csr 		= g_virtual_base + ((uint32_t)(ALT_LWFPGASLVS_OFST + SGDMA_ST2MM_BASE) & (uint32_t)HW_REGS_MASK),
		.fifoin_csr 	= g_virtual_base + ((uint32_t)(ALT_LWFPGASLVS_OFST + FIFO_IN_BASE) & (uint32_t)HW_REGS_MASK),
		.fifoout_csr 	= g_virtual_base + ((uint32_t)(ALT_LWFPGASLVS_OFST + FIFO_OUT_BASE) & (uint32_t)HW_REGS_MASK)
	};

	g_f2sdram = (f2sdram_addr_t)
	{
		// .mm2st_ram 	= g_h2f_lw.onchip_ram + SGDMA_MM2ST_RAM_OFST,
		// .st2mm_ram 	= g_h2f_lw.onchip_ram + SGDMA_ST2MM_RAM_OFST
		.mm2st_ram 	= g_fir_sdram_base + SGDMA_MM2ST_RAM_OFST,
		.st2mm_ram 	= g_fir_sdram_base + SGDMA_ST2MM_RAM_OFST
	};	
}

void* get_physical_address(void *virt_addr, int virt_ofst)
{
	return (void*)((uint32_t)virt_addr + virt_ofst);
}

void sig_handler(int signal)
{
	switch(signal)
	{
		case SIGINT:
			printf("\nReceived SIGINT: terminating...\n\n");
			goto_exit(1);
			break;
	}
}

void goto_exit(int exit_code)
{
	// Release memory mapping and exit
	if(munmap(g_virtual_base, HW_REGS_SPAN) != 0)
	{
		printf("ERROR: g_virtual_base munmap() failed...\n");
	}

	if(munmap(g_fir_sdram_base, FIR_SDRAM_SPAN) != 0)
	{
		printf("ERROR: g_fir_sdram_base munmap() failed...\n");
	}
	close(g_devmem_fd);

	exit(exit_code);
}
