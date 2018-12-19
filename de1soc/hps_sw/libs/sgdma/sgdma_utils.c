#include "common.h"
#include "sgdma/sgdma_utils.h"
#include "sgdma/sgdma_regs.h"

static const char* bit_status[] = {FG_RED "DISABLED" C_RESET, FG_GREEN "ENABLED" C_RESET};

static const char* get_bit_status(uint32_t reg, uint32_t bit)
{
  return bit_status[(reg & bit) != 0];
}

void sgdma_dump_desc_status(uint8_t status)
{
  log_printf("\n  @ DESC_STATUS: %s (0x%02X)\n", status ? FG_RED "ERROR" C_RESET : FG_GREEN "OK" C_RESET, status);
}

void sgdma_dump_desc_control(uint8_t control)
{
  log_printf("\n  @ DESC_CONTROL: (0x%02X)\n", control);
  log_printf("    GENERATE_EOP:           %s\n", get_bit_status(control, SGDMA_DESCRIPTOR_CONTROL_GENERATE_EOP_MSK));
                    
  log_printf("    READ_FIXED_ADDRESS:     %s\n", get_bit_status(control, SGDMA_DESCRIPTOR_CONTROL_READ_FIXED_ADDRESS_MSK));
                    
  log_printf("    WRITE_FIXED_ADDRESS:    %s\n", get_bit_status(control, SGDMA_DESCRIPTOR_CONTROL_WRITE_FIXED_ADDRESS_MSK));
                      
  log_printf("    ATLANTIC_CHANNEL:       %s%5d%s\n", FG_YELLOW,
                      (control >> SGDMA_DESCRIPTOR_CONTROL_ATLANTIC_CHANNEL_OFST) & 0xF, C_RESET);
  log_printf("    OWNED_BY_HW:            %s\n", get_bit_status(control, SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_MSK));
                    
}

void sgdma_dump_descriptor(alt_sgdma_descriptor_t *desc)
{
  log_printf("\n----- SGDMA descriptor @ %p(%p): -----\n", desc, get_physical_address(desc, g_fir_sdram_base_ofst));
  log_printf("    Source address:             %p\n", desc->source);
  log_printf("    Destination address:        %p\n", desc->destination);
  log_printf("    Next descriptor pointer:    %p\n\n", desc->next_desc_ptr);
  log_printf("    Bytes to transfer:          %i\n", desc->bytes_to_transfer);
  log_printf("    Bytes transferred:          %i\n", desc->actual_bytes_transferred);

  sgdma_dump_desc_status(desc->desc_status);
  sgdma_dump_desc_control(desc->desc_control);
}

void sgdma_dump_csr_status(uint32_t status)
{
  log_printf("\n  @ CSR_STATUS: (0x%08X)\n", status);
  log_printf("    ERROR               = %s\n", (status & SGDMA_STATUS_ERROR_MSK) ?
                    FG_RED "1" C_RESET : FG_GREEN "0" C_RESET);
  log_printf("    EOP_ENCOUNTERED     = %s\n", (status & SGDMA_STATUS_EOP_ENCOUNTERED_MSK) ?
                    FG_RED "1" C_RESET : FG_GREEN "0" C_RESET);
  log_printf("    DESC_COMPLETED      = %s\n", (status & SGDMA_STATUS_DESC_COMPLETED_MSK) ?
                    FG_GREEN "1" C_RESET : FG_YELLOW "0" C_RESET);
  log_printf("    CHAIN_COMPLETED     = %s\n", (status & SGDMA_STATUS_CHAIN_COMPLETED_MSK) ?
                    FG_GREEN "1" C_RESET : FG_YELLOW "0" C_RESET);
  log_printf("    BUSY                = %s\n", (status & SGDMA_STATUS_BUSY_MSK) ?
                    FG_YELLOW "1" C_RESET : FG_YELLOW "0" C_RESET);
}

void sgdma_dump_csr_control(uint32_t control)
{
  log_printf("\n  @ CSR_CONTROL: (0x%08X)\n", control);
  log_printf("    IE_ERROR:               %s\n", get_bit_status(control, SGDMA_CONTROL_IE_ERROR_MSK));
  log_printf("    IE_EOP_ENCOUNTERED:     %s\n", get_bit_status(control, SGDMA_CONTROL_IE_EOP_ENCOUNTERED_MSK));
  log_printf("    IE_DESC_COMPLETED:      %s\n", get_bit_status(control, SGDMA_CONTROL_IE_DESC_COMPLETED_MSK));
  log_printf("    IE_CHAIN_COMPLETED:     %s\n", get_bit_status(control, SGDMA_CONTROL_IE_CHAIN_COMPLETED_MSK));
  log_printf("    IE_GLOBAL:              %s\n", get_bit_status(control, SGDMA_CONTROL_IE_GLOBAL_MSK));
  log_printf("    RUN:                    %s\n", get_bit_status(control, SGDMA_CONTROL_RUN_MSK));
  log_printf("    STOP_DMA_ER:            %s\n", get_bit_status(control, SGDMA_CONTROL_STOP_DMA_ER_MSK));
  log_printf("    IE_MAX_DESC_PROCESSED:  %s\n", get_bit_status(control, SGDMA_CONTROL_IE_MAX_DESC_PROCESSED_MSK));
  log_printf("    MAX_DESC_PROCESSED:     %s%5d%s\n", FG_YELLOW,
                      (control >> SGDMA_CONTROL_MAX_DESC_PROCESSED_OFST) & 0xFF, C_RESET);
  log_printf("    SOFTWARERESET:          %s\n", get_bit_status(control, SGDMA_CONTROL_SOFTWARERESET_MSK));
  log_printf("    PARK:                   %s\n", get_bit_status(control, SGDMA_CONTROL_PARK_MSK));
  log_printf("    DESC_POLL_EN:           %s\n", get_bit_status(control, SGDMA_CONTROL_DESC_POLL_EN_MSK));
  log_printf("    DESC_POLL_FREQ:         %s%5d%s\n", FG_YELLOW,
                      (control >> SGDMA_CONTROL_DESC_POLL_FREQ_OFST) & 0x7FF, C_RESET);
  log_printf("    CLEAR_INTERRUPT:        %s%5d%s\n", FG_YELLOW,
                      (control >> SGDMA_CONTROL_CLEAR_INTERRUPT_OFST) & 0x01, C_RESET);
}

void sgdma_dump_csr(alt_sgdma_csr_t *csr)
{
  log_printf("\n----- SGDMA CSR @ %p (%p): -----\n", csr, get_physical_address(csr, g_virt_base_ofst));
  
  sgdma_dump_csr_status(csr->status);
  sgdma_dump_csr_control(csr->control);
}
