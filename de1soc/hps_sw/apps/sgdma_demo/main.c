#include <sys/mman.h>
#include <signal.h>
#include <getopt.h>
#include <string.h>

#include "fifo/fifo.h"
#include "sgdma/sgdma_drv.h"
#include "sgdma/sgdma_utils.h"

#include "common.h"
#include "test_vector.h"

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

  g_fifo_in   = (alt_single_clock_fifo_t*)g_h2f_lw.fifoin_csr;
  g_fifo_out  = (alt_single_clock_fifo_t*)g_h2f_lw.fifoout_csr;

  // Prepare on-chip memory
  int input_data_size;
  int output_data_size;

  log_printf("Initialize data RAM ");
  if (g_input_file)
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
  if (g_debug_flag)
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
  if (status & SGDMA_STATUS_ERROR_MSK)
    goto_exit(1);

  status = sgdma_start_transfer(g_st2mm.csr, &g_st2mm.desc_ram[0], 1, g_fifo_out);
  log_printf("\nST2MM transfer %s! (0x%02X)\n",
              status & SGDMA_STATUS_ERROR_MSK ? "FAILED" : "PASSED", status);
  if (status & SGDMA_STATUS_ERROR_MSK)
    goto_exit(1);

  if (g_debug_flag)
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
  if (g_debug_flag)
  {
    log_printf("\nData buffers (MM2ST/ST2MM):\n");
    for (int i = 0; i < output_data_size/4; i++)
    {
      log_printf("0x%08X/0x%08X, ", ((uint32_t*)g_mm2st.data_ram)[i], ((uint32_t*)g_st2mm.data_ram)[i]);
    }
    log_printf("\b\b\n"); //delete last comma and start a new line
  }

  // Save output to a file
  if (g_output_file)
    fwrite(g_st2mm.data_ram, 1, output_data_size, g_output_file);

  goto_exit(0);
}
