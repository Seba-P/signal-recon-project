#include <sys/mman.h>
#include <signal.h>
#include <getopt.h>
#include <string.h>
#include <arpa/inet.h>

#include "fifo/fifo.h"
#include "sgdma/sgdma_drv.h"
#include "sgdma/sgdma_utils.h"
#include "pocs_engine/pocs_engine_drv.h"
#include "pocs_engine/pocs_engine_utils.h"

#include "main.h"
#include "common.h"

int main(int argc, char** argv, char** envp)
{
  pocs_engine_config_t pocs_engine_config;

  parse_cmdline(argc, argv);
  init_files();
  init_sysbase();
  init_address_spaces();

  // Configure LEDs
  log_printf("\n\nSet the LEDs on ...");
  *(uint32_t*)(g_h2f_lw.led_pio) = 0xAA;
  log_printf(" DONE!\n");

  // Initialize FPGA subsystem devices
  sgdma_init_device(&g_mm2st, g_h2f_lw.mm2st_csr, g_f2h.mm2st_ram + DESC_RAM_OFST, g_f2h.mm2st_ram + DATA_RAM_OFST);
  sgdma_init_device(&g_st2mm, g_h2f_lw.st2mm_csr, g_f2h.st2mm_ram + DESC_RAM_OFST, g_f2h.st2mm_ram + DATA_RAM_OFST);

  g_fifo_in.csr   = (alt_sc_fifo_csr_t*)g_h2f_lw.fifoin_csr;
  g_fifo_out.csr  = (alt_sc_fifo_csr_t*)g_h2f_lw.fifoout_csr;

  pocs_engine_init_device(&g_pocs_engine, (pocs_engine_csr_t*)g_h2f_lw.pocs_engine_csr, &pocs_engine_config);

  // Prepare on-chip memory
  int input_data_size   = 0;
  int output_data_size  = 0;
  int sample_no = 0;
  int timestamp = 0;
  int cross_dir = 0;
  sample_t sample;

  log_printf("Initialize data RAM ");
  if (g_input_file)
  {
    while (1)
    {
      fread(&sample, 2, 1, g_input_file);

      if (feof(g_input_file))
        break;

      sample    = htons(sample);
      timestamp = SAMPLE_DURATION(sample);
      cross_dir = SAMPLE_CROSSDIR(sample);

      log_printf("\n#%d-> %s:%d;   ", sample_no, cross_dir ? "UP" : "DOWN", timestamp);

      sample_no++;
      output_data_size += 2*SAMPLE_DURATION(sample);
    }

    fseek(g_input_file, 0, SEEK_SET);
    input_data_size = fread(g_mm2st.data_ram, 2, DATA_RAM_SIZE/2, g_input_file);

    log_printf("with input file's content (%d samples, signal duration = %d)... ",
          input_data_size, output_data_size);
  }
  else
  {
    log_printf(" -> ERROR: TEST_VECTOR NOT SUPPORTED!\n");
    goto_exit(6);
  }

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
  // POCS engine config
  uint16_t lvls_values[32] =
  {
    0x8666, 0x9333, 0x9FFF, 0xACCC,
    0xB999, 0xC666, 0xD333, 0xE000,
    0xECCC, 0xF999, 0x0666, 0x1333,
    0x2000, 0x2CCC, 0x3999, 0x4666,
    0x5333, 0x6000, 0x6CCC, 0x7999,
    /* UNUSED BELOW */
    0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF,
    0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF,
    0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
  };

  pocs_engine_config = (pocs_engine_config_t)
  {
    .iter_num     = 3,
    .init_guess   = 1,
    .init_lvl     = 9,
    .lvls_num     = 20,
    .lvls_values  = lvls_values
  };

  pocs_engine_update_config(&g_pocs_engine, 1);

//-----------------------------------------------
  // Scatter Gather DMA controllers

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

  status = sgdma_start_transfer(g_mm2st.csr, &g_mm2st.desc_ram[0], 0);
  log_printf("\nMM2ST transfer %s! (0x%02X)\n",
              status & SGDMA_STATUS_ERROR_MSK ? "FAILED" : "PASSED", status);
  if (status & SGDMA_STATUS_ERROR_MSK)
    goto_exit(1);

  status = sgdma_start_transfer(g_st2mm.csr, &g_st2mm.desc_ram[0], 1);
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
