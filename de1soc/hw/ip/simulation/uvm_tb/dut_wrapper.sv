
interface dut_if(input reset, clock);
  /* CSR IF */
  wire [ 7:0] csr_address;
  wire [ 3:0] csr_byteenable;
  wire        csr_read;
  wire [31:0] csr_readdata;
  wire [ 1:0] csr_response;
  wire        csr_write;
  wire [31:0] csr_writedata;
  wire        csr_waitrequest;
  /* POCS_IN IF */
  wire [15:0] pocs_in_data;
  wire        pocs_in_valid;
  wire        pocs_in_ready;
  /* POCS_OUT IF */
  wire [15:0] pocs_out_data;
  wire        pocs_out_valid;
  wire        pocs_out_ready;
endinterface : dut_if

module dut_wrapper
#(
  parameter FIR_TAPS_NUM        = 63,
  parameter MAX_SAMPLES_IN_RAM  = 63,
  parameter MAX_LVLS_NUM        = 32,
  parameter MAX_ITER_NUM        = 1
)
(
  dut_if m_dut_if
);

pocs_engine
#(
  .FIR_TAPS_NUM       (FIR_TAPS_NUM),
  .MAX_SAMPLES_IN_RAM (MAX_SAMPLES_IN_RAM),
  .MAX_LVLS_NUM       (MAX_LVLS_NUM),
  .MAX_ITER_NUM       (MAX_ITER_NUM)
)
DUT
(
  /* Common IF */
  .reset            (m_dut_if.reset),
  .clock            (m_dut_if.clock),
  /* CSR IF */
  .csr_address      (m_dut_if.csr_address),
  .csr_byteenable   (m_dut_if.csr_byteenable),
  .csr_read         (m_dut_if.csr_read),
  .csr_readdata     (m_dut_if.csr_readdata),
  .csr_response     (m_dut_if.csr_response),
  .csr_write        (m_dut_if.csr_write),
  .csr_writedata    (m_dut_if.csr_writedata),
  .csr_waitrequest  (m_dut_if.csr_waitrequest),
  /* POCS_IN IF */
  .pocs_in_data     (m_dut_if.pocs_in_data),
  .pocs_in_valid    (m_dut_if.pocs_in_valid),
  .pocs_in_ready    (m_dut_if.pocs_in_ready),
  /* POCS_OUT IF */
  .pocs_out_data    (m_dut_if.pocs_out_data),
  .pocs_out_valid   (m_dut_if.pocs_out_valid),
  .pocs_out_ready   (m_dut_if.pocs_out_ready)
);

endmodule : dut_wrapper
