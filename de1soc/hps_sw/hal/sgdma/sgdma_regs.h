#ifndef _SGDMA_REGS_H_
#define _SGDMA_REGS_H_

#define SGDMA_STATUS_ERROR_MSK                    (0x1)
#define SGDMA_STATUS_ERROR_OFST                   (0)
#define SGDMA_STATUS_EOP_ENCOUNTERED_MSK          (0x2)
#define SGDMA_STATUS_EOP_ENCOUNTERED_OFST         (1)
#define SGDMA_STATUS_DESC_COMPLETED_MSK           (0x4)
#define SGDMA_STATUS_DESC_COMPLETED_OFST          (2)
#define SGDMA_STATUS_CHAIN_COMPLETED_MSK          (0x8)
#define SGDMA_STATUS_CHAIN_COMPLETED_OFST         (3)
#define SGDMA_STATUS_BUSY_MSK                     (0x10)
#define SGDMA_STATUS_BUSY_OFST                    (4)

#define SGDMA_VERSION_VERSION_MSK                 (0xFFFF)
#define SGDMA_VERSION_VERSION_OFST                (0)

#define SGDMA_CONTROL_IE_ERROR_MSK                (0x1)
#define SGDMA_CONTROL_IE_ERROR_OFST               (0)
#define SGDMA_CONTROL_IE_EOP_ENCOUNTERED_MSK      (0x2)
#define SGDMA_CONTROL_IE_EOP_ENCOUNTERED_OFST     (1)
#define SGDMA_CONTROL_IE_DESC_COMPLETED_MSK       (0x4)
#define SGDMA_CONTROL_IE_DESC_COMPLETED_OFST      (2)
#define SGDMA_CONTROL_IE_CHAIN_COMPLETED_MSK      (0x8)
#define SGDMA_CONTROL_IE_CHAIN_COMPLETED_OFST     (3)
#define SGDMA_CONTROL_IE_GLOBAL_MSK               (0x10)
#define SGDMA_CONTROL_IE_GLOBAL_OFST              (4)
#define SGDMA_CONTROL_RUN_MSK                     (0x20)
#define SGDMA_CONTROL_RUN_OFST                    (5)
#define SGDMA_CONTROL_STOP_DMA_ER_MSK             (0x40)
#define SGDMA_CONTROL_STOP_DMA_ER_OFST            (6)
#define SGDMA_CONTROL_IE_MAX_DESC_PROCESSED_MSK   (0x80)
#define SGDMA_CONTROL_IE_MAX_DESC_PROCESSED_OFST  (7)
#define SGDMA_CONTROL_MAX_DESC_PROCESSED_MSK      (0xFF00)
#define SGDMA_CONTROL_MAX_DESC_PROCESSED_OFST     (8)
#define SGDMA_CONTROL_SOFTWARERESET_MSK           (0X10000)
#define SGDMA_CONTROL_SOFTWARERESET_OFST          (16)
#define SGDMA_CONTROL_PARK_MSK                    (0X20000)
#define SGDMA_CONTROL_PARK_OFST                   (17)
#define SGDMA_CONTROL_DESC_POLL_EN_MSK            (0X40000)
#define SGDMA_CONTROL_DESC_POLL_EN_OFST           (18)
#define SGDMA_CONTROL_DESC_POLL_FREQ_MSK          (0x7FF00000)
#define SGDMA_CONTROL_DESC_POLL_FREQ_OFST         (20)
#define SGDMA_CONTROL_CLEAR_INTERRUPT_MSK         (0X80000000)
#define SGDMA_CONTROL_CLEAR_INTERRUPT_OFST        (31)

#ifndef _PACKED_
  #define _PACKED_ __attribute__ ((packed,aligned(1)))
#endif

typedef struct
{
  uint32_t status;
  uint32_t version;
  uint32_t version_pad[2];
  uint32_t control;
  uint32_t control_pad[3];
  uint32_t next_desc_pointer;
} _PACKED_ alt_sgdma_csr_t;

#endif /* _SGDMA_REGS_H_ */
