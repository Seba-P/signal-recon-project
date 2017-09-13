#include "common.h"
#include "fifo.h"

void fifo_set_tresholds(alt_single_clock_fifo_t* fifo, uint32_t almost_full, uint32_t almost_empty, uint32_t cut_through)
{
	fifo->almost_full_treshold 	= almost_full;
	fifo->almost_empty_treshold = almost_empty;
	fifo->cut_through_treshold 	= cut_through;
}

void fifo_dump_csr(alt_single_clock_fifo_t* fifo)
{
	log_printf("\n----- ST FIFO @ %p(%p): -----\n", fifo, get_physical_address(fifo, g_virt_base_ofst));
	log_printf("    Fill level:             %s%5d%s\n", FG_YELLOW, fifo_get_fill_level(fifo), C_RESET);
	log_printf("    Almost full treshold:   %s%5d%s\n", FG_YELLOW, fifo->almost_full_treshold, C_RESET);
	log_printf("    Almost empty treshold:  %s%5d%s\n", FG_YELLOW, fifo->almost_empty_treshold, C_RESET);
	log_printf("    Cut-through treshold:   %s%5d%s\n", FG_YELLOW, fifo->cut_through_treshold, C_RESET);
	log_printf("    Drop on error:          %s\n", fifo->drop_on_error ? 
												FG_GREEN "ENABLED" C_RESET : FG_RED "DISABLED" C_RESET);
}
