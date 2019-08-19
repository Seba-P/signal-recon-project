#include "common.h"
#include "fifo.h"

void fifo_set_tresholds(alt_sc_fifo_dev_t* fifo, uint32_t almost_full, uint32_t almost_empty, uint32_t cut_through)
{
  fifo->csr->almost_full_treshold   = almost_full;
  fifo->csr->almost_empty_treshold  = almost_empty;
  fifo->csr->cut_through_treshold   = cut_through;
}

void fifo_dump_csr(alt_sc_fifo_dev_t* fifo)
{
  log_printf("\n----- ST FIFO @ %p(%p): -----\n", fifo->csr, get_physical_address(fifo->csr, g_virt_base_ofst));
  log_printf("    Fill level:             %s%5d%s\n", FG_YELLOW, fifo_get_fill_level(fifo), C_RESET);
  log_printf("    Almost full treshold:   %s%5d%s\n", FG_YELLOW, fifo->csr->almost_full_treshold, C_RESET);
  log_printf("    Almost empty treshold:  %s%5d%s\n", FG_YELLOW, fifo->csr->almost_empty_treshold, C_RESET);
  log_printf("    Cut-through treshold:   %s%5d%s\n", FG_YELLOW, fifo->csr->cut_through_treshold, C_RESET);
  log_printf("    Drop on error:          %s\n", fifo->csr->drop_on_error ?
                        FG_GREEN "ENABLED" C_RESET : FG_RED "DISABLED" C_RESET);
}
