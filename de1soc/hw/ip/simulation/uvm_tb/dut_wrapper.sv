
interface dut_if(input reset, clock);
    /* MM2ST IF */
  wire [15:0] mm2st_data;
  wire        mm2st_valid;
  wire        mm2st_ready;
    /* ST2MM IF */
  wire [15:0] st2mm_data;
  wire        st2mm_valid;
  wire        st2mm_ready;
endinterface

module dut_wrapper
#(
  parameter FIR_TAPS_NUM        = 63,
  parameter MAX_SAMPLES_IN_RAM  = 63,
  parameter LVLS_NUM            = 20,
  parameter LVL_RESET_VALUE     = 9,
  parameter ITER_NUM            = 1,
  parameter USE_COMB_LOGIC      = 0
)
(
  dut_if m_dut_if
);

fir_subsystem_top
#(
  .FIR_TAPS_NUM       (FIR_TAPS_NUM),
  .MAX_SAMPLES_IN_RAM (MAX_SAMPLES_IN_RAM),
  .LVLS_NUM           (LVLS_NUM),
  .LVL_RESET_VALUE    (LVL_RESET_VALUE),
  .ITER_NUM           (ITER_NUM),
  .USE_COMB_LOGIC     (USE_COMB_LOGIC)
)
DUT
(
  /* Common IF */
  .reset        (m_dut_if.reset),
  .clock        (m_dut_if.clock),
  /* MM2ST IF */
  .mm2st_data   (m_dut_if.mm2st_data),
  .mm2st_valid  (m_dut_if.mm2st_valid),
  .mm2st_ready  (m_dut_if.mm2st_ready),
  /* ST2MM IF */
  .st2mm_data   (m_dut_if.st2mm_data),
  .st2mm_valid  (m_dut_if.st2mm_valid),
  .st2mm_ready  (m_dut_if.st2mm_ready)
);

endmodule
