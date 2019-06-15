#include <sys/mman.h>
#include <signal.h>
#include <getopt.h>
#include <string.h>

#include "common.h"

// User files
FILE* g_input_file;
FILE* g_output_file;
FILE* g_log_file;

char g_input_file_name[MAX_FILENAME_CHARS]  = "input.bin";
char g_output_file_name[MAX_FILENAME_CHARS] = "output.bin";
char g_log_file_name[MAX_FILENAME_CHARS]    = "log.txt";

// User flags
int g_log_flag    = 0;
int g_debug_flag  = 0;

// Pointers to the different address spaces
void*         g_virtual_base;
void*         g_fir_sdram_base;
h2f_lw_addr_t g_h2f_lw;
f2h_addr_t    g_f2h;
 
int g_virt_base_ofst;
int g_fir_sdram_base_ofst;
int g_devmem_fd;
 
// SGDMA controllers
alt_sgdma_dev_t g_mm2st;
alt_sgdma_dev_t g_st2mm;

// FIR FIFOs
alt_single_clock_fifo_t* g_fifo_in;
alt_single_clock_fifo_t* g_fifo_out;

void parse_cmdline(int argc, char* argv[])
{
  int c;
  int opt_idx = 0;

  while (1)
  {
    static struct option long_options[] =
    {
      {"debug",     no_argument,       0, 'd'},
      {"log_file",    required_argument, 0, 'l'},
      {"input_file",  required_argument, 0, 'i'},
      {"output_file", required_argument, 0, 'o'},
      {0, 0, 0, 0}
    };

    c = getopt_long(argc, argv, "dl:i:o:", long_options, &opt_idx);

    if (c == -1)
      break;

    switch (c)
    {
      case 'd':
        g_debug_flag   = 1;
        g_log_flag     = 1;
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
  if (g_log_file == NULL)
  {
    printf("ERROR: can't open log file: \"%s\"\n", g_log_file_name);
    g_log_flag = 0;
    g_debug_flag = 0;
  }

  g_input_file = fopen(g_input_file_name, "rb");
  if (g_input_file == NULL)
  {
    printf("ERROR: can't open FIR input file: \"%s\"\n", g_input_file_name);
  }

  g_output_file = fopen(g_output_file_name, "wb");
  if (g_output_file == NULL)
  {
    printf("ERROR: can't open FIR output file: \"%s\"\n", g_output_file_name);
  }
}

void init_sysbase(void)
{
  if (signal(SIGINT, sig_handler) == SIG_ERR)
  {
    log_printf("ERROR: cannot handle SIGINT\n");
    exit(-1);
  }

  if ((g_devmem_fd = open("/dev/mem", (O_RDWR | O_SYNC))) == -1)
  {
    log_printf("ERROR: could not open \"/dev/mem\"...\n");
    exit(-1);
  }

  // Map entire FPGA Slaves address space 
  g_virtual_base = mmap(NULL, HW_REGS_SPAN, (PROT_READ | PROT_WRITE), MAP_SHARED, g_devmem_fd, HW_REGS_BASE);
  if (g_virtual_base == MAP_FAILED)
  {
    log_printf("ERROR: g_virtual_base mmap() failed...\n");
    close(g_devmem_fd);
    exit(-1);
  }

  // Map FIR SDRAM address space 
  g_fir_sdram_base = mmap(NULL, FIR_SDRAM_SPAN, (PROT_READ | PROT_WRITE), MAP_SHARED, g_devmem_fd, FIR_SDRAM_BASE);
  if (g_fir_sdram_base == MAP_FAILED)
  {
    log_printf("ERROR: g_fir_sdram_base mmap() failed...\n");
    if (munmap(g_virtual_base, HW_REGS_SPAN) != 0)
    {
      log_printf("ERROR: g_virtual_base munmap() failed...\n");
    }

    close(g_devmem_fd);
    exit(-1);
  }

  // Calculate virtual base offset
  g_virt_base_ofst      = HW_REGS_BASE - (uint32_t)g_virtual_base;
  g_fir_sdram_base_ofst = FIR_SDRAM_BASE - (uint32_t)g_fir_sdram_base;

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
    .led_pio      = g_virtual_base + ((uint32_t)(ALT_LWFPGASLVS_OFST + LED_PIO_BASE) & (uint32_t)HW_REGS_MASK),
    .button_pio   = g_virtual_base + ((uint32_t)(ALT_LWFPGASLVS_OFST + BUTTON_PIO_BASE) & (uint32_t)HW_REGS_MASK),
    .dipsw_pio    = g_virtual_base + ((uint32_t)(ALT_LWFPGASLVS_OFST + DIPSW_PIO_BASE) & (uint32_t)HW_REGS_MASK),
    .sysid_qsys   = g_virtual_base + ((uint32_t)(ALT_LWFPGASLVS_OFST + SYSID_QSYS_BASE) & (uint32_t)HW_REGS_MASK),
    .onchip_ram   = g_virtual_base + ((uint32_t)(ALT_LWFPGASLVS_OFST + ONCHIP_RAM_BASE) & (uint32_t)HW_REGS_MASK),
    .mm2st_csr    = g_virtual_base + ((uint32_t)(ALT_LWFPGASLVS_OFST + MM2ST_SGDMA_BASE) & (uint32_t)HW_REGS_MASK),
    .st2mm_csr    = g_virtual_base + ((uint32_t)(ALT_LWFPGASLVS_OFST + ST2MM_SGDMA_BASE) & (uint32_t)HW_REGS_MASK),
    .fifoin_csr   = g_virtual_base + ((uint32_t)(ALT_LWFPGASLVS_OFST + FIFO_IN_BASE) & (uint32_t)HW_REGS_MASK),
    .fifoout_csr  = g_virtual_base + ((uint32_t)(ALT_LWFPGASLVS_OFST + FIFO_OUT_BASE) & (uint32_t)HW_REGS_MASK)
  };

  g_f2h = (f2h_addr_t)
  {
    .mm2st_ram   = g_fir_sdram_base + MM2ST_SGDMA_RAM_OFST,
    .st2mm_ram   = g_fir_sdram_base + ST2MM_SGDMA_RAM_OFST
  };  
}

void* get_physical_address(void *virt_addr, int virt_ofst)
{
  return (void*)((uint32_t)virt_addr + virt_ofst);
}

void sig_handler(int signal)
{
  switch (signal)
  {
    case SIGINT:
      log_printf("\nReceived SIGINT: terminating...\n\n");
      goto_exit(1);
      break;

    case SIGTERM:
      log_printf("\nReceived SIGTERM: terminating...\n\n");
      goto_exit(1);
      break;
  }
}

void goto_exit(int exit_code)
{
  // Release memory mapping and exit
  if (munmap(g_virtual_base, HW_REGS_SPAN) != 0)
  {
    log_printf("ERROR: g_virtual_base munmap() failed...\n");
  }

  if (munmap(g_fir_sdram_base, FIR_SDRAM_SPAN) != 0)
  {
    log_printf("ERROR: g_fir_sdram_base munmap() failed...\n");
  }

  if (g_input_file)
    fclose(g_input_file);
  if (g_output_file)
    fclose(g_output_file);
  if (g_log_file)
    fclose(g_log_file);

  close(g_devmem_fd);
  exit(exit_code);
}
