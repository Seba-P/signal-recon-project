#ifndef _SGDMA_DESCRIPTOR_H_
#define _SGDMA_DESCRIPTOR_H_

#include <stdint.h>

/* Each Scatter-gather DMA buffer descriptor spans 0x20 of memory */
#define SGDMA_DESCRIPTOR_SIZE (0x20)


/*
 * Descriptor control bit masks & offsets
 *
 * Note: The control byte physically occupies bits [31:24] in memory.
 *       The following bit-offsets are expressed relative to the LSB of
 *       the control register bitfield.
 */
#define SGDMA_DESCRIPTOR_CONTROL_GENERATE_EOP_MSK (0x1)
#define SGDMA_DESCRIPTOR_CONTROL_GENERATE_EOP_OFST (0)
#define SGDMA_DESCRIPTOR_CONTROL_READ_FIXED_ADDRESS_MSK (0x2)
#define SGDMA_DESCRIPTOR_CONTROL_READ_FIXED_ADDRESS_OFST (1)
#define SGDMA_DESCRIPTOR_CONTROL_WRITE_FIXED_ADDRESS_MSK (0x4)
#define SGDMA_DESCRIPTOR_CONTROL_WRITE_FIXED_ADDRESS_OFST (2)
#define SGDMA_DESCRIPTOR_CONTROL_ATLANTIC_CHANNEL_MSK (0x8)
#define SGDMA_DESCRIPTOR_CONTROL_ATLANTIC_CHANNEL_OFST (3)
#define SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_MSK (0x80)
#define SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_OFST (7)

/*
 * Descriptor status bit masks & offsets
 *
 * Note: The status byte physically occupies bits [23:16] in memory.
 *       The following bit-offsets are expressed relative to the LSB of
 *       the status register bitfield.
 */
#define SGDMA_DESCRIPTOR_STATUS_E_CRC_MSK (0x1)
#define SGDMA_DESCRIPTOR_STATUS_E_CRC_OFST (0)
#define SGDMA_DESCRIPTOR_STATUS_E_PARITY_MSK (0x2)
#define SGDMA_DESCRIPTOR_STATUS_E_PARITY_OFST (1)
#define SGDMA_DESCRIPTOR_STATUS_E_OVERFLOW_MSK (0x4)
#define SGDMA_DESCRIPTOR_STATUS_E_OVERFLOW_OFST (2)
#define SGDMA_DESCRIPTOR_STATUS_E_SYNC_MSK (0x8)
#define SGDMA_DESCRIPTOR_STATUS_E_SYNC_OFST (3)
#define SGDMA_DESCRIPTOR_STATUS_E_UEOP_MSK (0x10)
#define SGDMA_DESCRIPTOR_STATUS_E_UEOP_OFST (4)
#define SGDMA_DESCRIPTOR_STATUS_E_MEOP_MSK (0x20)
#define SGDMA_DESCRIPTOR_STATUS_E_MEOP_OFST (5)
#define SGDMA_DESCRIPTOR_STATUS_E_MSOP_MSK (0x40)
#define SGDMA_DESCRIPTOR_STATUS_E_MSOP_OFST (6)
#define SGDMA_DESCRIPTOR_STATUS_TERMINATED_BY_EOP_MSK (0x80)
#define SGDMA_DESCRIPTOR_STATUS_TERMINATED_BY_EOP_OFST (7)

/*
 * To ensure that a descriptor is created without spaces
 * between the struct members, we call upon GCC's ability
 * to pack to a byte-aligned boundary.
 */
#ifndef alt_avalon_sgdma_packed
    #define alt_avalon_sgdma_packed __attribute__ ((packed,aligned(1)))
#endif

/*
 * Buffer Descriptor data structure
 *
 * The SGDMA controller buffer descriptor allocates
 * 64 bits for each address. To support ANSI C, the
 * struct implementing a descriptor places 32-bits
 * of padding directly above each address; each pad must
 * be cleared when initializing a descriptor.
 */
typedef struct
{
    uint32_t    *source;
    uint32_t    source_pad;

    uint32_t    *destination;
    uint32_t    destination_pad;

    uint32_t    *next_desc_ptr;
    uint32_t    next_desc_ptr_pad;
    
    uint16_t    bytes_to_transfer;
    uint16_t    bytes_to_transfer_pad;
    
    uint16_t    actual_bytes_transferred;
    uint8_t     desc_status;
    uint8_t     desc_control;

} alt_avalon_sgdma_packed alt_sgdma_descriptor_t;

#endif /* _SGDMA_DESCRIPTOR_H_ */
