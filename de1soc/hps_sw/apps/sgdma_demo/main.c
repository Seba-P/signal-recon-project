#include <sys/mman.h>
#include <signal.h>
#include <getopt.h>
#include <string.h>

#include "common.h"
#include "main.h"
#include "test_vector.h"
#include "sgdma_utils.h"

int main(int argc, char** argv, char** envp)
{
	parse_cmdline(argc, argv);
	init_files();
	init_sysbase();
	init_address_spaces();

	// Configure LEDs
	log_printf("\n\nSet the LEDs on ...");
	*(uint32_t*)(g_h2f_lw.led_pio) = 0xAA;
	log_printf(" DONE!\n");

	// Initialize SGDMA controllers
	sgdma_init_device(&g_mm2st, g_h2f_lw.mm2st_csr, g_f2h.mm2st_ram + DESC_RAM_OFST, g_f2h.mm2st_ram + DATA_RAM_OFST);
	sgdma_init_device(&g_st2mm, g_h2f_lw.st2mm_csr, g_f2h.st2mm_ram + DESC_RAM_OFST, g_f2h.st2mm_ram + DATA_RAM_OFST);

	g_fifo_in 	= (alt_single_clock_fifo_t*)g_h2f_lw.fifoin_csr;
	g_fifo_out 	= (alt_single_clock_fifo_t*)g_h2f_lw.fifoout_csr;

	// Prepare on-chip memory
	int input_data_size;
	int output_data_size;

	log_printf("Initialize data RAM ");
	if(g_input_file)
	{
		input_data_size = fread(g_mm2st.data_ram, 1, DATA_RAM_SIZE, g_input_file);
		log_printf("with input file's content (%d bytes)... ", input_data_size);
	}
	else
	{
		memcpy(g_mm2st.data_ram, test_vector, TEST_VECTOR_SIZE * sizeof(uint16_t));
		input_data_size = TEST_VECTOR_SIZE;
		log_printf("with test_vector's content (%d bytes)... ", input_data_size);
	}
	output_data_size = input_data_size + FIR_COEFFS_NR - 1;
	memset(g_st2mm.data_ram, 0, DATA_RAM_SIZE);
	log_printf(" DONE!\n");

	// Check if data was initialized
	debug_printf("\nData buffers (MM2ST/ST2MM):\n");
	for (int i = 0; i < input_data_size/4; i++)
	{
		debug_printf("0x%08X/0x%08X, ", ((uint32_t*)g_mm2st.data_ram)[i], ((uint32_t*)g_st2mm.data_ram)[i]);
	}
	debug_printf("\b\b \n"); //delete last comma and start a new line

//-----------------------------------------------
	//Scatter Gather DMA controller

	// Initialize descriptors
	sgdma_init_mm2st_descriptor(&g_mm2st.desc_ram[0], &g_mm2st.desc_ram[1], (uint32_t*)g_mm2st.data_ram, output_data_size);
	sgdma_init_st2mm_descriptor(&g_st2mm.desc_ram[0], &g_st2mm.desc_ram[1], (uint32_t*)g_st2mm.data_ram, output_data_size);

	// Print descriptors fields
	if(g_debug_flag)
	{
		log_printf("\n\n##### MM2ST descriptors: #####");
		sgdma_dump_descriptor(&g_mm2st.desc_ram[0]);

		log_printf("\n\n##### ST2MM descriptors: #####");
		sgdma_dump_descriptor(&g_st2mm.desc_ram[0]);
		sleep(1);

		log_printf("\n##### MM2ST CSR: #####\n");
		sgdma_dump_csr(g_mm2st.csr);
		fifo_dump_csr(g_fifo_in);
		sleep(1);

		log_printf("\n##### ST2MM CSR: #####\n");
		sgdma_dump_csr(g_st2mm.csr);
		fifo_dump_csr(g_fifo_out);
		sleep(1);
	}

	g_mm2st.csr->control &= ~SGDMA_CONTROL_RUN_MSK;
	g_mm2st.csr->status = 0xFF;
	g_st2mm.csr->control &= ~SGDMA_CONTROL_RUN_MSK;
	g_st2mm.csr->status = 0xFF;
	
	// Run transfer chain
	uint8_t status;
	status = sgdma_start_transfer(g_mm2st.csr, &g_mm2st.desc_ram[0], 0, g_fifo_in);
	log_printf("\nMM2ST transfer %s! (0x%02X)\n", 
			status & SGDMA_STATUS_ERROR_MSK ? "FAILED" : "PASSED", status);
	if(status & SGDMA_STATUS_ERROR_MSK)
		goto_exit(1);

	status = sgdma_start_transfer(g_st2mm.csr, &g_st2mm.desc_ram[0], 1, g_fifo_out);
	log_printf("\nST2MM transfer %s! (0x%02X)\n", 
			status & SGDMA_STATUS_ERROR_MSK ? "FAILED" : "PASSED", status);
	if(status & SGDMA_STATUS_ERROR_MSK)
		goto_exit(1);

	if(g_debug_flag)
	{
		log_printf("\nUltimate MM2ST status:\n");
		sgdma_dump_csr(g_mm2st.csr);
		sgdma_dump_descriptor(&g_mm2st.desc_ram[0]);
		fifo_dump_csr(g_fifo_in);
		
		log_printf("\nUltimate ST2MM status:\n");
		sgdma_dump_csr(g_st2mm.csr);
		sgdma_dump_descriptor(&g_st2mm.desc_ram[0]);
		fifo_dump_csr(g_fifo_out);
	}

	// Validate buffers consistency
	if(g_debug_flag)
	{
		log_printf("\nData buffers (MM2ST/ST2MM):\n");
		for (int i = 0; i < output_data_size/4; i++)
		{
			log_printf("0x%08X/0x%08X, ", ((uint32_t*)g_mm2st.data_ram)[i], ((uint32_t*)g_st2mm.data_ram)[i]);
		}
		log_printf("\b\b\n"); //delete last comma and start a new line
	}

	// Save output to a file
	// fflush(g_log_file);
	// uint8_t buffer[DATA_RAM_SIZE];
	// memcpy(buffer, g_st2mm.data_ram, output_data_size);
	if(g_output_file)
		// fwrite(buffer, 1, output_data_size, g_output_file);
		fwrite(g_st2mm.data_ram, 1, output_data_size, g_output_file);

	goto_exit(0);
}

void parse_cmdline(int argc, char* argv[])
{
	int c;
	int opt_idx = 0;

	while(1)
	{
		static struct option long_options[] =
		{
			{"debug", 		no_argument,       0, 'd'},
			{"log_file",    required_argument, 0, 'l'},
			{"input_file",  required_argument, 0, 'i'},
			{"output_file", required_argument, 0, 'o'},
			{0, 0, 0, 0}
		};

		c = getopt_long(argc, argv, "dl:i:o:", long_options, &opt_idx);

		if(c == -1)
			break;

		switch(c)
		{
			case 'd':
				g_debug_flag 	= 1;
				g_log_flag 		= 1;
				break;

			case 'l':
				g_log_flag = 1;
				strncpy(g_log_file_name, optarg, MAX_FILENAME_CHARS);
				break;

			case 'i':
				strncpy(g_input_file_name, optarg, MAX_FILENAME_CHARS);
				break;

			case 'o':
				strncpy(g_output_file_name, optarg, MAX_FILENAME_CHARS);
				break;

			case '?':
				break;

			default:
				break;
		}
	}
}

void init_files(void)
{
	g_log_file = fopen(g_log_file_name, "w");
	if(g_log_file == NULL)
	{
		printf("ERROR: can't open log file: \"%s\"\n", g_log_file_name);
		g_log_flag = 0;
		g_debug_flag = 0;
	}

	g_input_file = fopen(g_input_file_name, "rb");
	if(g_input_file == NULL)
	{
		printf("ERROR: can't open FIR input file: \"%s\"\n", g_input_file_name);
	}

	g_output_file = fopen(g_output_file_name, "wb");
	if(g_output_file == NULL)
	{
		printf("ERROR: can't open FIR output file: \"%s\"\n", g_output_file_name);
	}
}

void init_sysbase(void)
{
	if(signal(SIGINT, sig_handler) == SIG_ERR)
	{
		log_printf("ERROR: cannot handle SIGINT\n");
		exit(-1);
	}

	if((g_devmem_fd = open("/dev/mem", (O_RDWR | O_SYNC))) == -1)
	{
		log_printf("ERROR: could not open \"/dev/mem\"...\n");
		exit(-1);
	}

	// Map entire FPGA Slaves address space 
	g_virtual_base = mmap(NULL, HW_REGS_SPAN, (PROT_READ | PROT_WRITE), MAP_SHARED, g_devmem_fd, HW_REGS_BASE);
	if(g_virtual_base == MAP_FAILED)
	{
		log_printf("ERROR: g_virtual_base mmap() failed...\n");
		close(g_devmem_fd);
		exit(-1);
	}

	// Map FIR SDRAM address space 
	g_fir_sdram_base = mmap(NULL, FIR_SDRAM_SPAN, (PROT_READ | PROT_WRITE), MAP_SHARED, g_devmem_fd, FIR_SDRAM_BASE);
	if(g_fir_sdram_base == MAP_FAILED)
	{
		log_printf("ERROR: g_fir_sdram_base mmap() failed...\n");
		if(munmap(g_virtual_base, HW_REGS_SPAN) != 0)
		{
			log_printf("ERROR: g_virtual_base munmap() failed...\n");
		}

		close(g_devmem_fd);
		exit(-1);
	}

	// Calculate virtual base offset
	g_virt_base_ofst 		= HW_REGS_BASE - (uint32_t)g_virtual_base;
	g_fir_sdram_base_ofst 	= FIR_SDRAM_BASE - (uint32_t)g_fir_sdram_base;

	debug_printf("\n----- Address space mapping: -----\n");
	debug_printf("    HW_REGS_BASE            = %p\n", (void*)HW_REGS_BASE);
	debug_printf("    g_virtual_base          = %p\n", g_virtual_base);
	debug_printf("    g_virt_base_ofst        = %p\n\n", (void*)g_virt_base_ofst);
	debug_printf("    FIR_SDRAM_BASE          = %p\n", (void*)FIR_SDRAM_BASE);
	debug_printf("    g_fir_sdram_base        = %p\n", g_fir_sdram_base);
	debug_printf("    g_fir_sdram_base_ofst   = %p\n", (void*)g_fir_sdram_base_ofst);
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

	g_f2h = (f2h_addr_t)
	{
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
			log_printf("\nReceived SIGINT: terminating...\n\n");
			goto_exit(1);
			break;
	}
}

void goto_exit(int exit_code)
{
	// Release memory mapping and exit
	if(munmap(g_virtual_base, HW_REGS_SPAN) != 0)
	{
		log_printf("ERROR: g_virtual_base munmap() failed...\n");
	}

	if(munmap(g_fir_sdram_base, FIR_SDRAM_SPAN) != 0)
	{
		log_printf("ERROR: g_fir_sdram_base munmap() failed...\n");
	}

	if(g_input_file)
		fclose(g_input_file);
	if(g_output_file)
		fclose(g_output_file);
	if(g_log_file)
		fclose(g_log_file);

	close(g_devmem_fd);

	exit(exit_code);
}
