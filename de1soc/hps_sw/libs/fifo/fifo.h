#ifndef _FIFO_H_
#define _FIFO_H_

#include <stdint.h>

#define FIFO_FILL_LEVEL_MSK   (0xFFFF)
#define FIFO_FILL_LEVEL_OFST  (0)

typedef struct
{
  uint32_t fill_level;
  uint32_t fill_level_pad;
  uint32_t almost_full_treshold;
  uint32_t almost_empty_treshold;
  uint32_t cut_through_treshold;
  uint32_t drop_on_error;
} alt_single_clock_fifo_t;

static inline uint32_t fifo_get_fill_level(alt_single_clock_fifo_t* fifo)
{
  return fifo->fill_level & FIFO_FILL_LEVEL_MSK;
}

void fifo_set_tresholds(alt_single_clock_fifo_t* fifo, uint32_t almost_full, uint32_t almost_empty,
                        uint32_t cut_through);
void fifo_dump_csr(alt_single_clock_fifo_t* fifo);

#endif /* _FIFO_H_ */
