
module fir_subsystem_top
#(
  parameter FIR_TAPS_NUM        = 63,
  parameter MAX_SAMPLES_IN_RAM  = 63,
  parameter LVLS_NUM            = 20,
  parameter LVL_RESET_VALUE     = 9,
  parameter ITER_NUM            = 1,
  parameter USE_COMB_LOGIC      = 0
)
(
  /* Common IF */
  input  wire        reset,       // reset.reset
  input  wire        clock,       // clock.clk
  /* MM2ST IF */
  input  wire [15:0] mm2st_data,  // mm2st.data
  input  wire        mm2st_valid, //      .valid
  output wire        mm2st_ready, //      .ready
  /* ST2MM IF */
  output wire [15:0] st2mm_data,  // st2mm.data
  output wire        st2mm_valid, //      .valid
  input  wire        st2mm_ready  //      .ready
);

wire         sample2lvl_subcells_lvl_valid;
wire  [15:0] sample2lvl_subcells_lvl_data;
wire         sample2lvl_subcells_limits_valid;
wire  [31:0] sample2lvl_subcells_limits_data;
wire         sample2lvl_iter_init;
wire         sample2lvl_iter_valid;
wire         sample2lvl_iter_ready;          
wire  [ITER_NUM-1:0]       iter_subcells_init;
wire  [ITER_NUM-1:0]       iter_subcells_new_limits;
wire  [ITER_NUM-1:0]       iter_subcells_valid_signal;
wire  [ITER_NUM-1:0]       iter_subcells_input_enable;
wire  [ITER_NUM-1:0]       iter_subcells_output_enable;
wire  [ITER_NUM-1:0]       iter_subcells_ready;
wire  [ITER_NUM-1:0][15:0] subcells_outctrl_data;
wire  [ITER_NUM-1:0]       subcells_outctrl_valid;
wire  [ITER_NUM-1:0]       subcells_outctrl_ready;
wire  [ITER_NUM-0:0][15:0] subcells_subcells_data;
wire  [ITER_NUM-0:0]       subcells_subcells_valid;
wire  [ITER_NUM-0:0]       subcells_subcells_ready;
wire  [ITER_NUM-0:0]       subcells_outsignal_ready;
wire                       iter_outctrl_enable;
wire [$bits(ITER_NUM)-1:0] iter_outctrl_iter_num;
wire                       iter_outctrl_ready;

sample2lvl_converter
#(
  .LVLS_NUM        (LVLS_NUM),
  .LVL_RESET_VALUE (LVL_RESET_VALUE)
)
sample2lvl_converter
( // TODO:
  .reset            (reset),                            //      reset.reset
  .clock            (clock),                            //      clock.clk
  .in_data          (mm2st_data),                       //         in.data
  .in_valid         (mm2st_valid),                      //           .valid
  .in_ready         (mm2st_ready),                      //           .ready
  .out_lvl_data     (sample2lvl_subcells_lvl_data),     //    out_lvl.data
  .out_lvl_valid    (sample2lvl_subcells_lvl_valid),    //           .valid
  .out_limits_data  (sample2lvl_subcells_limits_data),  // out_limits.data
  .out_limits_valid (sample2lvl_subcells_limits_valid), //           .valid
  .iter_init        (sample2lvl_iter_init),             //       iter.new_signal
  .iter_valid       (sample2lvl_iter_valid),            //           .new_signal_1
  .iter_ready       (sample2lvl_iter_ready)             //           .new_signal_2
);

iteration_ctrl
#(
  .FIR_TAPS_NUM       (FIR_TAPS_NUM),
  .MAX_SAMPLES_IN_RAM (MAX_SAMPLES_IN_RAM),
  .ITER_NUM           (ITER_NUM)
)
iteration_ctrl
( // TODO:
  .reset                  (reset),                        //      reset.reset
  .clock                  (clock),                        //      clock.clk
  .sample2lvl_init        (sample2lvl_iter_init),         // sample2lvl.new_signal
  .sample2lvl_valid       (sample2lvl_iter_valid),        //           .new_signal_1
  .sample2lvl_ready       (sample2lvl_iter_ready),        //           .new_signal_2
  .subcells_init          (iter_subcells_init),           //   subcells.new_signal
  .subcells_new_limits    (iter_subcells_new_limits),     //           .new_signal_1
  .subcells_valid_signal  (iter_subcells_valid_signal),   //           .new_signal_2
  .subcells_input_enable  (iter_subcells_input_enable),   //           .new_signal_3
  .subcells_output_enable (iter_subcells_output_enable),  //           .new_signal_4
  .subcells_ready         (iter_subcells_ready),          //           .new_signal_5
  .outctrl_enable         (iter_outctrl_enable),          //    outctrl.new_signal
  .outctrl_iter_num       (iter_outctrl_iter_num),        //           .new_signal_1
  .outctrl_ready          (iter_outctrl_ready)            //           .new_signal_2
);

genvar ITER;
generate
  assign subcells_subcells_ready[ITER_NUM] = '1;

  for(ITER = 0; ITER < ITER_NUM; ITER++)
  begin : _FOR_ITER
    if(ITER == 0)
    begin
      assign subcells_subcells_data[ITER]   = sample2lvl_subcells_lvl_data;
      assign subcells_subcells_valid[ITER]  = sample2lvl_subcells_lvl_valid;
      assign subcells_outsignal_ready[ITER] = subcells_outctrl_ready[ITER] & subcells_subcells_ready[ITER+1];
    end
    else
    begin
      assign subcells_subcells_data[ITER]   = subcells_outctrl_data[ITER-1];
      assign subcells_subcells_valid[ITER]  = subcells_outctrl_valid[ITER-1];
      assign subcells_outsignal_ready[ITER] = subcells_outctrl_ready[ITER] & subcells_subcells_ready[ITER+1];
    end

    fir_subcell
    #(
      .FIR_TAPS_NUM       (FIR_TAPS_NUM),
      .MAX_SAMPLES_IN_RAM (MAX_SAMPLES_IN_RAM),
      .LVLS_NUM           (LVLS_NUM),
      .LVL_RESET_VALUE    (LVL_RESET_VALUE),
      .ITER_NUM           (ITER_NUM),
      .USE_COMB_LOGIC     (USE_COMB_LOGIC)
    )
    fir_subcell
    (
      .reset              (reset),                              //      reset.reset
      .clock              (clock),                              //      clock.clk
      .iter_init          (iter_subcells_init[ITER]),           //       iter.new_signal
      .iter_new_limits    (iter_subcells_new_limits[ITER]),     //           .new_signal_1
      .iter_valid_signal  (iter_subcells_valid_signal[ITER]),   //           .new_signal_2
      .iter_input_enable  (iter_subcells_input_enable[ITER]),   //           .new_signal_3
      .iter_output_enable (iter_subcells_output_enable[ITER]),  //           .new_signal_4
      .iter_ready         (iter_subcells_ready[ITER]),          //           .new_signal_5
      .in_limits_data     (sample2lvl_subcells_limits_data),    //  in_limits.data
      .in_limits_valid    (sample2lvl_subcells_limits_valid),   //           .valid
      .in_signal_data     (subcells_subcells_data[ITER]),       //  in_signal.data
      .in_signal_valid    (subcells_subcells_valid[ITER]),      //           .valid
      .in_signal_ready    (subcells_subcells_ready[ITER]),      //           .ready
      .out_signal_data    (subcells_outctrl_data[ITER]),        // out_signal.data
      .out_signal_valid   (subcells_outctrl_valid[ITER]),       //           .valid
      .out_signal_ready   (subcells_outsignal_ready[ITER])      //           .ready
    );
  end
endgenerate

output_ctrl
#(
  .ITER_NUM       (ITER_NUM),
  .USE_COMB_LOGIC (USE_COMB_LOGIC)
)
output_ctrl
( // TODO:
  .reset          (reset),                  // reset.reset
  .clock          (clock),                  // clock.clk
  .iter_enable    (iter_outctrl_enable),    //  iter.new_signal
  .iter_iter_num  (iter_outctrl_iter_num),  //      .new_signal_1
  .iter_ready     (iter_outctrl_ready),     //      .new_signal_2
  .in_data        (subcells_outctrl_data),  //    in.data
  .in_valid       (subcells_outctrl_valid), //      .valid
  .in_ready       (subcells_outctrl_ready), //      .ready
  .out_data       (st2mm_data),             //   out.data
  .out_valid      (st2mm_valid),            //      .valid
  .out_ready      (st2mm_ready)             //      .ready
);

endmodule
