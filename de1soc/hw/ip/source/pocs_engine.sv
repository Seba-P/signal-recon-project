
module pocs_engine
#(
  parameter FIR_TAPS_NUM        = 63,
  parameter MAX_SAMPLES_IN_RAM  = 63,
  parameter MAX_LVLS_NUM        = 32,
  parameter MAX_ITER_NUM        = 1
)
(
  /* Common IF */
  input  wire        reset,           //    reset.reset
  input  wire        clock,           //    clock.clk
  /* CSR IF */
  input  wire [ 7:0] csr_address,     //      csr.address
  input  wire [ 3:0] csr_byteenable,  //         .byteenable
  input  wire        csr_read,        //         .read
  output wire [31:0] csr_readdata,    //         .readdata
  output wire [ 1:0] csr_response,    //         .response
  input  wire        csr_write,       //         .write
  input  wire [31:0] csr_writedata,   //         .writedata
  output wire        csr_waitrequest, //         .waitrequest
  /* POCS_IN IF */
  input  wire [15:0] pocs_in_data,    //  pocs_in.data
  input  wire        pocs_in_valid,   //         .valid
  output wire        pocs_in_ready,   //         .ready
  /* POCS_OUT IF */
  output wire [15:0] pocs_out_data,   // pocs_out.data
  output wire        pocs_out_valid,  //         .valid
  input  wire        pocs_out_ready   //         .ready
);

localparam FIR_TAPS_NUM_BITS        = $clog2(FIR_TAPS_NUM);
localparam MAX_SAMPLES_IN_RAM_BITS  = $clog2(MAX_SAMPLES_IN_RAM);
localparam MAX_LVLS_NUM_BITS        = $clog2(MAX_LVLS_NUM);
localparam MAX_ITER_NUM_BITS        = $clog2(MAX_ITER_NUM);

wire                           status_busy;
wire                           status_ready;
wire                           status_error;
wire                           status_fifo_err;
wire                           control_run;
wire                           control_halt;
wire                           control_flush;
wire                           control_init;
// wire [$clog2(MAX_LVLS_NUM)-1:0] params_lvls_num;
wire                    [ 4:0] params_lvls_num;
// wire [$clog2(MAX_LVLS_NUM)-1:0] params_init_lvl;
wire                    [ 4:0] params_init_lvl;
// wire [$clog2(MAX_ITER_NUM)-1:0] params_iter_num;
wire                    [ 3:0] params_iter_num;
wire                    [ 1:0] params_init_guess;
// wire  [0:MAX_LVLS_NUM-1][15:0] lvl_val_lvl_xx;
wire              [0:31][15:0] lvl_val_lvl_xx;
wire                           sample2signal_subcells_signal_valid;
reg                            sample2signal_subcells_signal_valid_d1;
wire                    [15:0] sample2signal_subcells_signal_data;
reg                     [15:0] sample2signal_subcells_signal_data_d1;
wire                           sample2signal_subcells_limits_valid;
reg                            sample2signal_subcells_limits_valid_d1;
wire                    [31:0] sample2signal_subcells_limits_data;
reg                     [31:0] sample2signal_subcells_limits_data_d1;
wire                           sample2signal_iter_init;
wire                           sample2signal_iter_valid;
wire                           sample2signal_iter_ready;
wire  [MAX_ITER_NUM-1:0]       iter_subcells_init;
wire  [MAX_ITER_NUM-1:0]       iter_subcells_new_limits;
wire  [MAX_ITER_NUM-1:0]       iter_subcells_valid_signal;
wire  [MAX_ITER_NUM-1:0]       iter_subcells_input_enable;
wire  [MAX_ITER_NUM-1:0]       iter_subcells_output_enable;
wire  [MAX_ITER_NUM-1:0]       iter_subcells_ready;
wire  [MAX_ITER_NUM-1:0][15:0] subcells_outctrl_data;
wire  [MAX_ITER_NUM-1:0]       subcells_outctrl_valid;
wire  [MAX_ITER_NUM-1:0]       subcells_outctrl_ready;
wire  [MAX_ITER_NUM-0:0][15:0] subcells_subcells_data;
wire  [MAX_ITER_NUM-0:0]       subcells_subcells_valid;
wire  [MAX_ITER_NUM-0:0]       subcells_subcells_ready;
wire  [MAX_ITER_NUM-0:0]       subcells_outsignal_ready;
wire                           iter_outctrl_enable;
wire   [MAX_ITER_NUM_BITS-1:0] iter_outctrl_iter_num;
wire                           iter_outctrl_ready;

register_file
#(
  .MAX_LVLS_NUM (MAX_LVLS_NUM),
  .MAX_ITER_NUM (MAX_ITER_NUM)
)
register_file
(
  .reset              (reset),              //   reset.reset
  .clock              (clock),              //   clock.clk
  .csr_address        (csr_address),        //     csr.address
  .csr_byteenable     (csr_byteenable),     //        .byteenable
  .csr_read           (csr_read),           //        .read
  .csr_readdata       (csr_readdata),       //        .readdata
  .csr_response       (csr_response),       //        .response
  .csr_write          (csr_write),          //        .write
  .csr_writedata      (csr_writedata),      //        .writedata
  .csr_waitrequest    (csr_waitrequest),    //        .waitrequest
  .status_busy        (status_busy),        //  status.busy
  .status_ready       (status_ready),       //        .ready
  .status_error       (status_error),       //        .error
  .status_fifo_err    (status_fifo_err),    //        .fifo_err
  .control_run        (control_run),        // control.run
  .control_halt       (control_halt),       //        .halt
  .control_flush      (control_flush),      //        .flush
  .control_init       (control_init),       //        .init
  .params_lvls_num    (params_lvls_num),    //  params.lvls_num
  .params_init_lvl    (params_init_lvl),    //        .init_lvl
  .params_iter_num    (params_iter_num),    //        .iter_num
  .params_init_guess  (params_init_guess),  //        .init_guess
  .lvl_val_lvl_xx     (lvl_val_lvl_xx)      // lvl_val.lvl_xx
);

sample2signal_converter
#(
  .MAX_LVLS_NUM (MAX_LVLS_NUM)
)
sample2signal_converter
(
  .reset                (reset),                                //      reset.reset
  .clock                (clock),                                //      clock.clk
  .params_lvls_num      (params_lvls_num),                      //     params.lvls_num
  .params_init_lvl      (params_init_lvl),                      //           .init_lvl
  .params_init_guess    (params_init_guess),                    //           .init_guess
  .params_lvls_values   (lvl_val_lvl_xx),                       //           .lvls_values
  .in_data              (pocs_in_data),                         //         in.data
  .in_valid             (pocs_in_valid),                        //           .valid
  .in_ready             (pocs_in_ready),                        //           .ready
  .out_signal_data      (sample2signal_subcells_signal_data),   // out_signal.data
  .out_signal_valid     (sample2signal_subcells_signal_valid),  //           .valid
  .out_limits_data      (sample2signal_subcells_limits_data),   // out_limits.data
  .out_limits_valid     (sample2signal_subcells_limits_valid),  //           .valid
  .iter_init            (sample2signal_iter_init),              //       iter.new_signal
  .iter_valid           (sample2signal_iter_valid),             //           .new_signal_1
  .iter_ready           (sample2signal_iter_ready)              //           .new_signal_2
);

iteration_ctrl
#(
  .FIR_TAPS_NUM       (FIR_TAPS_NUM),
  .MAX_SAMPLES_IN_RAM (MAX_SAMPLES_IN_RAM),
  .MAX_ITER_NUM       (MAX_ITER_NUM)
)
iteration_ctrl
(
  .reset                  (reset),                        //         reset.reset
  .clock                  (clock),                        //         clock.clk
  .regfile_busy           (status_busy),                  //       regfile.busy
  .regfile_ready          (status_ready),                 //              .ready
  .regfile_error          (status_error),                 //              .error
  .regfile_fifo_err       (status_fifo_err),              //              .fifo_err
  .regfile_run            (control_run),                  //              .run
  .regfile_halt           (control_halt),                 //              .halt
  .regfile_flush          (control_flush),                //              .flush
  .regfile_init           (control_init),                 //              .init
  .regfile_iter_num       (params_iter_num),              //              .iter_num
  .sample2signal_init     (sample2signal_iter_init),      // sample2signal.new_signal
  .sample2signal_valid    (sample2signal_iter_valid),     //              .new_signal_1
  .sample2signal_ready    (sample2signal_iter_ready),     //              .new_signal_2
  .subcells_init          (iter_subcells_init),           //      subcells.new_signal
  .subcells_new_limits    (iter_subcells_new_limits),     //              .new_signal_1
  .subcells_valid_signal  (iter_subcells_valid_signal),   //              .new_signal_2
  .subcells_input_enable  (iter_subcells_input_enable),   //              .new_signal_3
  .subcells_output_enable (iter_subcells_output_enable),  //              .new_signal_4
  .subcells_ready         (iter_subcells_ready),          //              .new_signal_5
  .outctrl_enable         (iter_outctrl_enable),          //       outctrl.new_signal
  .outctrl_iter_num       (iter_outctrl_iter_num),        //              .new_signal_1
  .outctrl_ready          (iter_outctrl_ready)            //              .new_signal_2
);

delay
#(
  .DELAY     (1),
  .WIDTH     ($bits({ sample2signal_subcells_signal_valid, sample2signal_subcells_signal_data,
                      sample2signal_subcells_limits_valid, sample2signal_subcells_limits_data })),
  .RESET     (1),
  .RESET_VAL ('0),
  .RAMSTYLE  ("logic")
)
delay_sample2signal
(
  .clock    (clock),
  .reset    (reset),
  .in_data  ({  sample2signal_subcells_signal_valid, sample2signal_subcells_signal_data,
                sample2signal_subcells_limits_valid, sample2signal_subcells_limits_data }),
  .out_data ({  sample2signal_subcells_signal_valid_d1, sample2signal_subcells_signal_data_d1,
                sample2signal_subcells_limits_valid_d1, sample2signal_subcells_limits_data_d1 })
);

genvar ITER;
generate
  assign subcells_subcells_ready[MAX_ITER_NUM] = '1;

  for (ITER = 0; ITER < MAX_ITER_NUM; ITER++)
  begin : _FOR_ITER
    if (ITER == 0)
    begin
      assign subcells_subcells_data[ITER]   = sample2signal_subcells_signal_data_d1;
      assign subcells_subcells_valid[ITER]  = sample2signal_subcells_signal_valid_d1;
      assign subcells_outsignal_ready[ITER] = subcells_outctrl_ready[ITER] & subcells_subcells_ready[ITER+1];
    end
    else
    begin
      assign subcells_subcells_data[ITER]   = subcells_outctrl_data[ITER-1];
      assign subcells_subcells_valid[ITER]  = subcells_outctrl_valid[ITER-1];
      assign subcells_outsignal_ready[ITER] = subcells_outctrl_ready[ITER] & subcells_subcells_ready[ITER+1];
    end

    pocs_subcell
    #(
      .FIR_TAPS_NUM (FIR_TAPS_NUM),
      .SUBCELL_NUM  (ITER)
    )
    pocs_subcell
    (
      .reset              (reset),                                  //      reset.reset
      .clock              (clock),                                  //      clock.clk
      .iter_init          (iter_subcells_init[ITER]),               //       iter.new_signal
      .iter_new_limits    (iter_subcells_new_limits[ITER]),         //           .new_signal_1
      .iter_valid_signal  (iter_subcells_valid_signal[ITER]),       //           .new_signal_2
      .iter_input_enable  (iter_subcells_input_enable[ITER]),       //           .new_signal_3
      .iter_output_enable (iter_subcells_output_enable[ITER]),      //           .new_signal_4
      .iter_ready         (iter_subcells_ready[ITER]),              //           .new_signal_5
      .in_limits_data     (sample2signal_subcells_limits_data_d1),  //  in_limits.data
      .in_limits_valid    (sample2signal_subcells_limits_valid_d1), //           .valid
      .in_signal_data     (subcells_subcells_data[ITER]),           //  in_signal.data
      .in_signal_valid    (subcells_subcells_valid[ITER]),          //           .valid
      .in_signal_ready    (subcells_subcells_ready[ITER]),          //           .ready
      .out_signal_data    (subcells_outctrl_data[ITER]),            // out_signal.data
      .out_signal_valid   (subcells_outctrl_valid[ITER]),           //           .valid
      .out_signal_ready   (subcells_outsignal_ready[ITER])          //           .ready
    );
  end
endgenerate

output_ctrl
#(
  .MAX_ITER_NUM (MAX_ITER_NUM)
)
output_ctrl
(
  .reset          (reset),                  // reset.reset
  .clock          (clock),                  // clock.clk
  .iter_enable    (iter_outctrl_enable),    //  iter.new_signal
  .iter_iter_num  (iter_outctrl_iter_num),  //      .new_signal_1
  .iter_ready     (iter_outctrl_ready),     //      .new_signal_2
  .in_data        (subcells_outctrl_data),  //    in.data
  .in_valid       (subcells_outctrl_valid), //      .valid
  .in_ready       (subcells_outctrl_ready), //      .ready
  .out_data       (pocs_out_data),          //   out.data
  .out_valid      (pocs_out_valid),         //      .valid
  .out_ready      (pocs_out_ready)          //      .ready
);

endmodule
