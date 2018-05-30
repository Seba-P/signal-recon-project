
module fir_subsystem_top
#(
  parameter MAX_SAMPLES_IN_RAM  = 255,
  parameter LVLS_NUM            = 20,
  parameter LVL_RESET_VALUE     = 9,
  parameter ITER_NUM            = 1,
  parameter USE_COMB_LOGIC      = 0
)
(
  /* Common IF */
  input  wire        reset_n,
  input  wire        clock,
  /* MM2ST IF */
  input  wire [15:0] mm2st_data,
  input  wire        mm2st_valid,
  output wire        mm2st_ready,
  /* ST2MM IF */
  output wire [15:0] st2mm_data,
  output wire        st2mm_valid,
  input  wire        st2mm_ready
);

wire         limits_buffer_ctrl_port_a_chipselect;                // limits_buffer_ctrl:ram_limits_chipselect_a -> limits_buffer:port_a_chipselect
wire  [31:0] limits_buffer_ctrl_port_a_readdata;                  // limits_buffer:port_a_readdata -> limits_buffer_ctrl:ram_limits_readdata_a
wire         limits_buffer_ctrl_port_a_waitrequest;               // limits_buffer:port_a_waitrequest -> limits_buffer_ctrl:ram_limits_waitrequest_a
wire   [7:0] limits_buffer_ctrl_port_a_address;                   // limits_buffer_ctrl:ram_limits_address_a -> limits_buffer:port_a_address
wire   [3:0] limits_buffer_ctrl_port_a_byteenable;                // limits_buffer_ctrl:ram_limits_byteenable_a -> limits_buffer:port_a_byteenable
wire         limits_buffer_ctrl_port_a_read;                      // limits_buffer_ctrl:ram_limits_read_a -> limits_buffer:port_a_read
wire         limits_buffer_ctrl_port_a_write;                     // limits_buffer_ctrl:ram_limits_write_a -> limits_buffer:port_a_write
wire  [31:0] limits_buffer_ctrl_port_a_writedata;                 // limits_buffer_ctrl:ram_limits_writedata_a -> limits_buffer:port_a_writedata
wire         signal_buffer_ctrl_port_a_chipselect;                // signal_buffer_ctrl:ram_signal_chipselect_a -> signal_buffer:port_a_chipselect
wire  [15:0] signal_buffer_ctrl_port_a_readdata;                  // signal_buffer:port_a_readdata -> signal_buffer_ctrl:ram_signal_readdata_a
wire         signal_buffer_ctrl_port_a_waitrequest;               // signal_buffer:port_a_waitrequest -> signal_buffer_ctrl:ram_signal_waitrequest_a
wire  [12:0] signal_buffer_ctrl_port_a_address;                   // signal_buffer_ctrl:ram_signal_address_a -> signal_buffer:port_a_address
wire   [1:0] signal_buffer_ctrl_port_a_byteenable;                // signal_buffer_ctrl:ram_signal_byteenable_a -> signal_buffer:port_a_byteenable
wire         signal_buffer_ctrl_port_a_read;                      // signal_buffer_ctrl:ram_signal_read_a -> signal_buffer:port_a_read
wire         signal_buffer_ctrl_port_a_write;                     // signal_buffer_ctrl:ram_signal_write_a -> signal_buffer:port_a_write
wire  [15:0] signal_buffer_ctrl_port_a_writedata;                 // signal_buffer_ctrl:ram_signal_writedata_a -> signal_buffer:port_a_writedata
wire         limits_buffer_ctrl_port_b_chipselect;                // limits_buffer_ctrl:ram_limits_chipselect_b -> limits_buffer:port_b_chipselect
wire  [31:0] limits_buffer_ctrl_port_b_readdata;                  // limits_buffer:port_b_readdata -> limits_buffer_ctrl:ram_limits_readdata_b
wire         limits_buffer_ctrl_port_b_waitrequest;               // limits_buffer:port_b_waitrequest -> limits_buffer_ctrl:ram_limits_waitrequest_b
wire   [7:0] limits_buffer_ctrl_port_b_address;                   // limits_buffer_ctrl:ram_limits_address_b -> limits_buffer:port_b_address
wire   [3:0] limits_buffer_ctrl_port_b_byteenable;                // limits_buffer_ctrl:ram_limits_byteenable_b -> limits_buffer:port_b_byteenable
wire         limits_buffer_ctrl_port_b_read;                      // limits_buffer_ctrl:ram_limits_read_b -> limits_buffer:port_b_read
wire         limits_buffer_ctrl_port_b_write;                     // limits_buffer_ctrl:ram_limits_write_b -> limits_buffer:port_b_write
wire  [31:0] limits_buffer_ctrl_port_b_writedata;                 // limits_buffer_ctrl:ram_limits_writedata_b -> limits_buffer:port_b_writedata
wire         signal_buffer_ctrl_port_b_chipselect;                // signal_buffer_ctrl:ram_signal_chipselect_b -> signal_buffer:port_b_chipselect
wire  [15:0] signal_buffer_ctrl_port_b_readdata;                  // signal_buffer:port_b_readdata -> signal_buffer_ctrl:ram_signal_readdata_b
wire         signal_buffer_ctrl_port_b_waitrequest;               // signal_buffer:port_b_waitrequest -> signal_buffer_ctrl:ram_signal_waitrequest_b
wire  [12:0] signal_buffer_ctrl_port_b_address;                   // signal_buffer_ctrl:ram_signal_address_b -> signal_buffer:port_b_address
wire   [1:0] signal_buffer_ctrl_port_b_byteenable;                // signal_buffer_ctrl:ram_signal_byteenable_b -> signal_buffer:port_b_byteenable
wire         signal_buffer_ctrl_port_b_read;                      // signal_buffer_ctrl:ram_signal_read_b -> signal_buffer:port_b_read
wire         signal_buffer_ctrl_port_b_write;                     // signal_buffer_ctrl:ram_signal_write_b -> signal_buffer:port_b_write
wire  [15:0] signal_buffer_ctrl_port_b_writedata;                 // signal_buffer_ctrl:ram_signal_writedata_b -> signal_buffer:port_b_writedata
wire         fir_filter_avalon_streaming_source_valid;            // fir_filter:ast_source_valid -> hard_limiter:fir_valid
wire  [15:0] fir_filter_avalon_streaming_source_data;             // fir_filter:ast_source_data -> hard_limiter:fir_data
wire         fir_filter_avalon_streaming_source_ready;            // hard_limiter:fir_ready -> fir_filter:ast_source_ready
wire   [1:0] fir_filter_avalon_streaming_source_error;            // fir_filter:ast_source_error -> hard_limiter:fir_error
wire         fir_driver_fir_valid;                                // fir_driver:fir_valid -> fir_filter:ast_sink_valid
wire  [15:0] fir_driver_fir_data;                                 // fir_driver:fir_data -> fir_filter:ast_sink_data
wire         fir_driver_fir_ready;                                // fir_filter:ast_sink_ready -> fir_driver:fir_ready
wire   [1:0] fir_driver_fir_error;                                // fir_driver:fir_error -> fir_filter:ast_sink_error
wire         signal_buffer_ctrl_fir_driver_valid;                 // signal_buffer_ctrl:fir_driver_valid -> fir_driver:sigbuff_valid
wire  [15:0] signal_buffer_ctrl_fir_driver_data;                  // signal_buffer_ctrl:fir_driver_data -> fir_driver:sigbuff_data
wire         limits_buffer_ctrl_limiter_valid;                    // limits_buffer_ctrl:limiter_valid -> hard_limiter:limbuff_valid
wire  [31:0] limits_buffer_ctrl_limiter_data;                     // limits_buffer_ctrl:limiter_data -> hard_limiter:limbuff_data
wire         fir_fifo_out_out_valid;                              // fir_fifo_out:out_valid -> st2mm_data_adapter_0:avalon_st_sink_valid
wire  [15:0] fir_fifo_out_out_data;                               // fir_fifo_out:out_data -> st2mm_data_adapter_0:avalon_st_sink_data
wire         fir_fifo_out_out_ready;                              // st2mm_data_adapter_0:avalon_st_sink_ready -> fir_fifo_out:out_ready
wire         fir_fifo_in_out_valid;                               // fir_fifo_in:out_valid -> sample2lvl_converter_0:in_valid
wire  [15:0] fir_fifo_in_out_data;                                // fir_fifo_in:out_data -> sample2lvl_converter_0:in_data
wire         fir_fifo_in_out_ready;                               // sample2lvl_converter_0:in_ready -> fir_fifo_in:out_ready
wire         hard_limiter_out_valid;                              // hard_limiter:out_valid -> hard_limiter_out_splitter:in0_valid
wire  [15:0] hard_limiter_out_data;                               // hard_limiter:out_data -> hard_limiter_out_splitter:in0_data
wire         hard_limiter_out_ready;                              // hard_limiter_out_splitter:in0_ready -> hard_limiter:out_ready
wire         hard_limiter_out_splitter_out0_valid;                // hard_limiter_out_splitter:out0_valid -> signal_buffer_ctrl:limiter_valid
wire  [15:0] hard_limiter_out_splitter_out0_data;                 // hard_limiter_out_splitter:out0_data -> signal_buffer_ctrl:limiter_data
wire         hard_limiter_out_splitter_out0_ready;                // signal_buffer_ctrl:limiter_ready -> hard_limiter_out_splitter:out0_ready
wire         lvl_generator_out_splitter_out0_valid;               // lvl_generator_out_splitter:out0_valid -> signal_buffer_ctrl:lvl_gen_valid
wire  [15:0] lvl_generator_out_splitter_out0_data;                // lvl_generator_out_splitter:out0_data -> signal_buffer_ctrl:lvl_gen_data
wire         hard_limiter_out_splitter_out1_valid;                // hard_limiter_out_splitter:out1_valid -> output_ctrl:limiter_valid
wire  [15:0] hard_limiter_out_splitter_out1_data;                 // hard_limiter_out_splitter:out1_data -> output_ctrl:limiter_data
wire         hard_limiter_out_splitter_out1_ready;                // output_ctrl:limiter_ready -> hard_limiter_out_splitter:out1_ready
wire         lvl_generator_out_splitter_out1_valid;               // lvl_generator_out_splitter:out1_valid -> fir_driver:lvl_gen_valid
wire  [15:0] lvl_generator_out_splitter_out1_data;                // lvl_generator_out_splitter:out1_data -> fir_driver:lvl_gen_data
wire         sample2lvl_converter_0_out_limits_valid;             // sample2lvl_converter_0:out_limits_valid -> limits_buffer_ctrl:lvl_gen_valid
wire  [31:0] sample2lvl_converter_0_out_limits_data;              // sample2lvl_converter_0:out_limits_data -> limits_buffer_ctrl:lvl_gen_data
wire         sample2lvl_converter_0_out_lvl_valid;                // sample2lvl_converter_0:out_lvl_valid -> lvl_generator_out_splitter:in0_valid
wire  [15:0] sample2lvl_converter_0_out_lvl_data;                 // sample2lvl_converter_0:out_lvl_data -> lvl_generator_out_splitter:in0_data
wire         iteration_ctrl_fir_driver_new_signal_1;              // iteration_ctrl:fir_input_enable -> fir_driver:iter_input_enable
wire         iteration_ctrl_fir_driver_new_signal;                // iteration_ctrl:fir_input_mux -> fir_driver:iter_input_mux
wire         iteration_ctrl_limbuff_new_signal_1;                 // iteration_ctrl:limbuff_output_enable -> limits_buffer_ctrl:iter_output_enable
wire         iteration_ctrl_limbuff_new_signal;                   // iteration_ctrl:limbuff_input_enable -> limits_buffer_ctrl:iter_input_enable
wire         iteration_ctrl_lvl_gen_new_signal_1;                 // iteration_ctrl:lvl_gen_ready -> sample2lvl_converter_0:iter_ready
wire         sample2lvl_converter_0_iter_new_signal;              // sample2lvl_converter_0:iter_valid -> iteration_ctrl:lvl_gen_valid
wire         iteration_ctrl_sigbuff_new_signal_1;                 // iteration_ctrl:sigbuff_input_mux -> signal_buffer_ctrl:iter_input_mux
wire         iteration_ctrl_sigbuff_new_signal_2;                 // iteration_ctrl:sigbuff_input_enable -> signal_buffer_ctrl:iter_input_enable
wire         iteration_ctrl_sigbuff_new_signal_3;                 // iteration_ctrl:sigbuff_output_enable -> signal_buffer_ctrl:iter_output_enable
wire   [4:0] iteration_ctrl_sigbuff_new_signal;                   // iteration_ctrl:sigbuff_iter_num -> signal_buffer_ctrl:iter_iter_num
wire         iteration_ctrl_limiter_new_signal;                   // iteration_ctrl:limiter_input_enable -> hard_limiter:iter_input_enable
wire         iteration_ctrl_out_ctrl_new_signal;                  // iteration_ctrl:out_ctrl_output_enable -> output_ctrl:iter_output_enable
wire         rst_controller_reset_out_reset;                      // rst_controller:reset_out -> [button_pio:reset_n, dipsw_pio:reset_n, fir_driver:reset, fir_fifo_in:reset, fir_fifo_out:reset, fir_filter:reset_n, hard_limiter:reset, hard_limiter_out_splitter:reset, iteration_ctrl:reset, led_pio:reset_n, limits_buffer:reset, limits_buffer_ctrl:reset, lvl_generator_out_splitter:reset, mm2st_data_adapter_0:avalon_st_reset, mm_interconnect_0:sgdma_mm2st_reset_reset_bridge_in_reset_reset, mm_interconnect_1:sysid_qsys_reset_reset_bridge_in_reset_reset, onchip_RAM:reset, output_ctrl:reset, rst_translator:in_reset, sample2lvl_converter_0:reset, sgdma_mm2st:system_reset_n, sgdma_st2mm:system_reset_n, signal_buffer:reset, signal_buffer_ctrl:reset, st2mm_data_adapter_0:avalon_st_reset, sysid_qsys:reset_n]
wire         rst_controller_reset_out_reset_req;                  // rst_controller:reset_req -> [onchip_RAM:reset_req, rst_translator:reset_req_in]

fir_driver #(
  .USE_COMB_LOGIC (USE_COMB_LOGIC)
) fir_driver (
  .clock             (clock),                                  //   clock.clk
  .reset             (rst_controller_reset_out_reset),         //   reset.reset
  .lvl_gen_data      (lvl_generator_out_splitter_out1_data),   // lvl_gen.data
  .lvl_gen_valid     (lvl_generator_out_splitter_out1_valid),  //        .valid
  .sigbuff_data      (signal_buffer_ctrl_fir_driver_data),     // sigbuff.data
  .sigbuff_valid     (signal_buffer_ctrl_fir_driver_valid),    //        .valid
  .fir_data          (fir_driver_fir_data),                    //     fir.data
  .fir_valid         (fir_driver_fir_valid),                   //        .valid
  .fir_ready         (fir_driver_fir_ready),                   //        .ready
  .fir_error         (fir_driver_fir_error),                   //        .error
  .iter_input_mux    (iteration_ctrl_fir_driver_new_signal),   //    iter.new_signal
  .iter_input_enable (iteration_ctrl_fir_driver_new_signal_1)  //        .new_signal_1
);

soc_system_fir_filter fir_filter (
  .clk              (clock),                                    //                     clk.clk
  .reset_n          (~rst_controller_reset_out_reset),          //                     rst.reset_n
  .ast_sink_data    (fir_driver_fir_data),                      //   avalon_streaming_sink.data
  .ast_sink_valid   (fir_driver_fir_valid),                     //                        .valid
  .ast_sink_error   (fir_driver_fir_error),                     //                        .error
  .ast_sink_ready   (fir_driver_fir_ready),                     //                        .ready
  .ast_source_data  (fir_filter_avalon_streaming_source_data),  // avalon_streaming_source.data
  .ast_source_valid (fir_filter_avalon_streaming_source_valid), //                        .valid
  .ast_source_error (fir_filter_avalon_streaming_source_error), //                        .error
  .ast_source_ready (fir_filter_avalon_streaming_source_ready)  //                        .ready
);

hard_limiter #(
  .USE_COMB_LOGIC (USE_COMB_LOGIC)
) hard_limiter (
  .clock             (clock),                                    //   clock.clk
  .reset             (rst_controller_reset_out_reset),           //   reset.reset
  .limbuff_data      (limits_buffer_ctrl_limiter_data),          // limbuff.data
  .limbuff_valid     (limits_buffer_ctrl_limiter_valid),         //        .valid
  .iter_input_enable (iteration_ctrl_limiter_new_signal),        //    iter.new_signal
  .fir_data          (fir_filter_avalon_streaming_source_data),  //     fir.data
  .fir_ready         (fir_filter_avalon_streaming_source_ready), //        .ready
  .fir_valid         (fir_filter_avalon_streaming_source_valid), //        .valid
  .fir_error         (fir_filter_avalon_streaming_source_error), //        .error
  .out_data          (hard_limiter_out_data),                    //     out.data
  .out_valid         (hard_limiter_out_valid),                   //        .valid
  .out_ready         (hard_limiter_out_ready)                    //        .ready
);

altera_avalon_st_splitter #(
  .NUMBER_OF_OUTPUTS (2),
  .QUALIFY_VALID_OUT (1),
  .USE_PACKETS       (0),
  .DATA_WIDTH        (16),
  .CHANNEL_WIDTH     (1),
  .ERROR_WIDTH       (1),
  .BITS_PER_SYMBOL   (16),
  .EMPTY_WIDTH       (1)
) hard_limiter_out_splitter (
  .clk                 (clock),                                //   clk.clk
  .reset               (rst_controller_reset_out_reset),       // reset.reset
  .in0_ready           (hard_limiter_out_ready),               //    in.ready
  .in0_valid           (hard_limiter_out_valid),               //      .valid
  .in0_data            (hard_limiter_out_data),                //      .data
  .out0_ready          (hard_limiter_out_splitter_out0_ready), //  out0.ready
  .out0_valid          (hard_limiter_out_splitter_out0_valid), //      .valid
  .out0_data           (hard_limiter_out_splitter_out0_data),  //      .data
  .out1_ready          (hard_limiter_out_splitter_out1_ready), //  out1.ready
  .out1_valid          (hard_limiter_out_splitter_out1_valid), //      .valid
  .out1_data           (hard_limiter_out_splitter_out1_data),  //      .data
  .in0_startofpacket   (1'b0),                                 // (terminated)
  .in0_endofpacket     (1'b0),                                 // (terminated)
  .in0_empty           (1'b0),                                 // (terminated)
  .in0_channel         (1'b0),                                 // (terminated)
  .in0_error           (1'b0),                                 // (terminated)
  .out0_startofpacket  (),                                     // (terminated)
  .out0_endofpacket    (),                                     // (terminated)
  .out0_empty          (),                                     // (terminated)
  .out0_channel        (),                                     // (terminated)
  .out0_error          (),                                     // (terminated)
  .out1_startofpacket  (),                                     // (terminated)
  .out1_endofpacket    (),                                     // (terminated)
  .out1_empty          (),                                     // (terminated)
  .out1_channel        (),                                     // (terminated)
  .out1_error          (),                                     // (terminated)
  .out2_ready          (1'b1),                                 // (terminated)
  .out2_valid          (),                                     // (terminated)
  .out2_startofpacket  (),                                     // (terminated)
  .out2_endofpacket    (),                                     // (terminated)
  .out2_empty          (),                                     // (terminated)
  .out2_channel        (),                                     // (terminated)
  .out2_error          (),                                     // (terminated)
  .out2_data           (),                                     // (terminated)
  .out3_ready          (1'b1),                                 // (terminated)
  .out3_valid          (),                                     // (terminated)
  .out3_startofpacket  (),                                     // (terminated)
  .out3_endofpacket    (),                                     // (terminated)
  .out3_empty          (),                                     // (terminated)
  .out3_channel        (),                                     // (terminated)
  .out3_error          (),                                     // (terminated)
  .out3_data           (),                                     // (terminated)
  .out4_ready          (1'b1),                                 // (terminated)
  .out4_valid          (),                                     // (terminated)
  .out4_startofpacket  (),                                     // (terminated)
  .out4_endofpacket    (),                                     // (terminated)
  .out4_empty          (),                                     // (terminated)
  .out4_channel        (),                                     // (terminated)
  .out4_error          (),                                     // (terminated)
  .out4_data           (),                                     // (terminated)
  .out5_ready          (1'b1),                                 // (terminated)
  .out5_valid          (),                                     // (terminated)
  .out5_startofpacket  (),                                     // (terminated)
  .out5_endofpacket    (),                                     // (terminated)
  .out5_empty          (),                                     // (terminated)
  .out5_channel        (),                                     // (terminated)
  .out5_error          (),                                     // (terminated)
  .out5_data           (),                                     // (terminated)
  .out6_ready          (1'b1),                                 // (terminated)
  .out6_valid          (),                                     // (terminated)
  .out6_startofpacket  (),                                     // (terminated)
  .out6_endofpacket    (),                                     // (terminated)
  .out6_empty          (),                                     // (terminated)
  .out6_channel        (),                                     // (terminated)
  .out6_error          (),                                     // (terminated)
  .out6_data           (),                                     // (terminated)
  .out7_ready          (1'b1),                                 // (terminated)
  .out7_valid          (),                                     // (terminated)
  .out7_startofpacket  (),                                     // (terminated)
  .out7_endofpacket    (),                                     // (terminated)
  .out7_empty          (),                                     // (terminated)
  .out7_channel        (),                                     // (terminated)
  .out7_error          (),                                     // (terminated)
  .out7_data           (),                                     // (terminated)
  .out8_ready          (1'b1),                                 // (terminated)
  .out8_valid          (),                                     // (terminated)
  .out8_startofpacket  (),                                     // (terminated)
  .out8_endofpacket    (),                                     // (terminated)
  .out8_empty          (),                                     // (terminated)
  .out8_channel        (),                                     // (terminated)
  .out8_error          (),                                     // (terminated)
  .out8_data           (),                                     // (terminated)
  .out9_ready          (1'b1),                                 // (terminated)
  .out9_valid          (),                                     // (terminated)
  .out9_startofpacket  (),                                     // (terminated)
  .out9_endofpacket    (),                                     // (terminated)
  .out9_empty          (),                                     // (terminated)
  .out9_channel        (),                                     // (terminated)
  .out9_error          (),                                     // (terminated)
  .out9_data           (),                                     // (terminated)
  .out10_ready         (1'b1),                                 // (terminated)
  .out10_valid         (),                                     // (terminated)
  .out10_startofpacket (),                                     // (terminated)
  .out10_endofpacket   (),                                     // (terminated)
  .out10_empty         (),                                     // (terminated)
  .out10_channel       (),                                     // (terminated)
  .out10_error         (),                                     // (terminated)
  .out10_data          (),                                     // (terminated)
  .out11_ready         (1'b1),                                 // (terminated)
  .out11_valid         (),                                     // (terminated)
  .out11_startofpacket (),                                     // (terminated)
  .out11_endofpacket   (),                                     // (terminated)
  .out11_empty         (),                                     // (terminated)
  .out11_channel       (),                                     // (terminated)
  .out11_error         (),                                     // (terminated)
  .out11_data          (),                                     // (terminated)
  .out12_ready         (1'b1),                                 // (terminated)
  .out12_valid         (),                                     // (terminated)
  .out12_startofpacket (),                                     // (terminated)
  .out12_endofpacket   (),                                     // (terminated)
  .out12_empty         (),                                     // (terminated)
  .out12_channel       (),                                     // (terminated)
  .out12_error         (),                                     // (terminated)
  .out12_data          (),                                     // (terminated)
  .out13_ready         (1'b1),                                 // (terminated)
  .out13_valid         (),                                     // (terminated)
  .out13_startofpacket (),                                     // (terminated)
  .out13_endofpacket   (),                                     // (terminated)
  .out13_empty         (),                                     // (terminated)
  .out13_channel       (),                                     // (terminated)
  .out13_error         (),                                     // (terminated)
  .out13_data          (),                                     // (terminated)
  .out14_ready         (1'b1),                                 // (terminated)
  .out14_valid         (),                                     // (terminated)
  .out14_startofpacket (),                                     // (terminated)
  .out14_endofpacket   (),                                     // (terminated)
  .out14_empty         (),                                     // (terminated)
  .out14_channel       (),                                     // (terminated)
  .out14_error         (),                                     // (terminated)
  .out14_data          (),                                     // (terminated)
  .out15_ready         (1'b1),                                 // (terminated)
  .out15_valid         (),                                     // (terminated)
  .out15_startofpacket (),                                     // (terminated)
  .out15_endofpacket   (),                                     // (terminated)
  .out15_empty         (),                                     // (terminated)
  .out15_channel       (),                                     // (terminated)
  .out15_error         (),                                     // (terminated)
  .out15_data          ()                                      // (terminated)
);

iteration_ctrl #(
  .MAX_SAMPLES_IN_RAM (MAX_SAMPLES_IN_RAM),
  .ITER_NUM           (ITER_NUM)
) iteration_ctrl (
  .clock                  (clock),                                  //      clock.clk
  .reset                  (rst_controller_reset_out_reset),         //      reset.reset
  .sigbuff_iter_num       (iteration_ctrl_sigbuff_new_signal),      //    sigbuff.new_signal
  .sigbuff_input_mux      (iteration_ctrl_sigbuff_new_signal_1),    //           .new_signal_1
  .sigbuff_input_enable   (iteration_ctrl_sigbuff_new_signal_2),    //           .new_signal_2
  .sigbuff_output_enable  (iteration_ctrl_sigbuff_new_signal_3),    //           .new_signal_3
  .limbuff_input_enable   (iteration_ctrl_limbuff_new_signal),      //    limbuff.new_signal
  .limbuff_output_enable  (iteration_ctrl_limbuff_new_signal_1),    //           .new_signal_1
  .lvl_gen_valid          (sample2lvl_converter_0_iter_new_signal), //    lvl_gen.new_signal
  .lvl_gen_ready          (iteration_ctrl_lvl_gen_new_signal_1),    //           .new_signal_1
  .fir_input_mux          (iteration_ctrl_fir_driver_new_signal),   // fir_driver.new_signal
  .fir_input_enable       (iteration_ctrl_fir_driver_new_signal_1), //           .new_signal_1
  .limiter_input_enable   (iteration_ctrl_limiter_new_signal),      //    limiter.new_signal
  .out_ctrl_output_enable (iteration_ctrl_out_ctrl_new_signal)      //   out_ctrl.new_signal
);

limits_buffer limits_buffer (
  .clock              (clock),                                 //  clock.clk
  .reset              (rst_controller_reset_out_reset),        //  reset.reset
  .port_a_address     (limits_buffer_ctrl_port_a_address),     // port_a.address
  .port_a_chipselect  (limits_buffer_ctrl_port_a_chipselect),  //       .chipselect
  .port_a_read        (limits_buffer_ctrl_port_a_read),        //       .read
  .port_a_readdata    (limits_buffer_ctrl_port_a_readdata),    //       .readdata
  .port_a_write       (limits_buffer_ctrl_port_a_write),       //       .write
  .port_a_writedata   (limits_buffer_ctrl_port_a_writedata),   //       .writedata
  .port_a_byteenable  (limits_buffer_ctrl_port_a_byteenable),  //       .byteenable
  .port_a_waitrequest (limits_buffer_ctrl_port_a_waitrequest), //       .waitrequest
  .port_b_address     (limits_buffer_ctrl_port_b_address),     // port_b.address
  .port_b_chipselect  (limits_buffer_ctrl_port_b_chipselect),  //       .chipselect
  .port_b_read        (limits_buffer_ctrl_port_b_read),        //       .read
  .port_b_readdata    (limits_buffer_ctrl_port_b_readdata),    //       .readdata
  .port_b_write       (limits_buffer_ctrl_port_b_write),       //       .write
  .port_b_writedata   (limits_buffer_ctrl_port_b_writedata),   //       .writedata
  .port_b_byteenable  (limits_buffer_ctrl_port_b_byteenable),  //       .byteenable
  .port_b_waitrequest (limits_buffer_ctrl_port_b_waitrequest)  //       .waitrequest
);

limits_buffer_ctrl #(
  .MAX_SAMPLES_IN_RAM (MAX_SAMPLES_IN_RAM)
) limits_buffer_ctrl (
  .clock                    (clock),                                   //   clock.clk
  .reset                    (rst_controller_reset_out_reset),          //   reset.reset
  .lvl_gen_valid            (sample2lvl_converter_0_out_limits_valid), // lvl_gen.valid
  .lvl_gen_data             (sample2lvl_converter_0_out_limits_data),  //        .data
  .iter_input_enable        (iteration_ctrl_limbuff_new_signal),       //    iter.new_signal
  .iter_output_enable       (iteration_ctrl_limbuff_new_signal_1),     //        .new_signal_1
  .limiter_data             (limits_buffer_ctrl_limiter_data),         // limiter.data
  .limiter_valid            (limits_buffer_ctrl_limiter_valid),        //        .valid
  .ram_limits_address_a     (limits_buffer_ctrl_port_a_address),       //  port_a.address
  .ram_limits_chipselect_a  (limits_buffer_ctrl_port_a_chipselect),    //        .chipselect
  .ram_limits_write_a       (limits_buffer_ctrl_port_a_write),         //        .write
  .ram_limits_readdata_a    (limits_buffer_ctrl_port_a_readdata),      //        .readdata
  .ram_limits_writedata_a   (limits_buffer_ctrl_port_a_writedata),     //        .writedata
  .ram_limits_byteenable_a  (limits_buffer_ctrl_port_a_byteenable),    //        .byteenable
  .ram_limits_waitrequest_a (limits_buffer_ctrl_port_a_waitrequest),   //        .waitrequest
  .ram_limits_read_a        (limits_buffer_ctrl_port_a_read),          //        .read
  .ram_limits_address_b     (limits_buffer_ctrl_port_b_address),       //  port_b.address
  .ram_limits_byteenable_b  (limits_buffer_ctrl_port_b_byteenable),    //        .byteenable
  .ram_limits_chipselect_b  (limits_buffer_ctrl_port_b_chipselect),    //        .chipselect
  .ram_limits_readdata_b    (limits_buffer_ctrl_port_b_readdata),      //        .readdata
  .ram_limits_write_b       (limits_buffer_ctrl_port_b_write),         //        .write
  .ram_limits_writedata_b   (limits_buffer_ctrl_port_b_writedata),     //        .writedata
  .ram_limits_waitrequest_b (limits_buffer_ctrl_port_b_waitrequest),   //        .waitrequest
  .ram_limits_read_b        (limits_buffer_ctrl_port_b_read)           //        .read
);

altera_avalon_st_splitter #(
  .NUMBER_OF_OUTPUTS (2),
  .QUALIFY_VALID_OUT (1),
  .USE_PACKETS       (0),
  .DATA_WIDTH        (16),
  .CHANNEL_WIDTH     (1),
  .ERROR_WIDTH       (1),
  .BITS_PER_SYMBOL   (16),
  .EMPTY_WIDTH       (1)
) lvl_generator_out_splitter (
  .clk                 (clock),                                 //   clk.clk
  .reset               (rst_controller_reset_out_reset),        // reset.reset
  .in0_valid           (sample2lvl_converter_0_out_lvl_valid),  //    in.valid
  .in0_data            (sample2lvl_converter_0_out_lvl_data),   //      .data
  .out0_valid          (lvl_generator_out_splitter_out0_valid), //  out0.valid
  .out0_data           (lvl_generator_out_splitter_out0_data),  //      .data
  .out1_valid          (lvl_generator_out_splitter_out1_valid), //  out1.valid
  .out1_data           (lvl_generator_out_splitter_out1_data),  //      .data
  .in0_ready           (),                                      // (terminated)
  .in0_startofpacket   (1'b0),                                  // (terminated)
  .in0_endofpacket     (1'b0),                                  // (terminated)
  .in0_empty           (1'b0),                                  // (terminated)
  .in0_channel         (1'b0),                                  // (terminated)
  .in0_error           (1'b0),                                  // (terminated)
  .out0_ready          (1'b1),                                  // (terminated)
  .out0_startofpacket  (),                                      // (terminated)
  .out0_endofpacket    (),                                      // (terminated)
  .out0_empty          (),                                      // (terminated)
  .out0_channel        (),                                      // (terminated)
  .out0_error          (),                                      // (terminated)
  .out1_ready          (1'b1),                                  // (terminated)
  .out1_startofpacket  (),                                      // (terminated)
  .out1_endofpacket    (),                                      // (terminated)
  .out1_empty          (),                                      // (terminated)
  .out1_channel        (),                                      // (terminated)
  .out1_error          (),                                      // (terminated)
  .out2_ready          (1'b1),                                  // (terminated)
  .out2_valid          (),                                      // (terminated)
  .out2_startofpacket  (),                                      // (terminated)
  .out2_endofpacket    (),                                      // (terminated)
  .out2_empty          (),                                      // (terminated)
  .out2_channel        (),                                      // (terminated)
  .out2_error          (),                                      // (terminated)
  .out2_data           (),                                      // (terminated)
  .out3_ready          (1'b1),                                  // (terminated)
  .out3_valid          (),                                      // (terminated)
  .out3_startofpacket  (),                                      // (terminated)
  .out3_endofpacket    (),                                      // (terminated)
  .out3_empty          (),                                      // (terminated)
  .out3_channel        (),                                      // (terminated)
  .out3_error          (),                                      // (terminated)
  .out3_data           (),                                      // (terminated)
  .out4_ready          (1'b1),                                  // (terminated)
  .out4_valid          (),                                      // (terminated)
  .out4_startofpacket  (),                                      // (terminated)
  .out4_endofpacket    (),                                      // (terminated)
  .out4_empty          (),                                      // (terminated)
  .out4_channel        (),                                      // (terminated)
  .out4_error          (),                                      // (terminated)
  .out4_data           (),                                      // (terminated)
  .out5_ready          (1'b1),                                  // (terminated)
  .out5_valid          (),                                      // (terminated)
  .out5_startofpacket  (),                                      // (terminated)
  .out5_endofpacket    (),                                      // (terminated)
  .out5_empty          (),                                      // (terminated)
  .out5_channel        (),                                      // (terminated)
  .out5_error          (),                                      // (terminated)
  .out5_data           (),                                      // (terminated)
  .out6_ready          (1'b1),                                  // (terminated)
  .out6_valid          (),                                      // (terminated)
  .out6_startofpacket  (),                                      // (terminated)
  .out6_endofpacket    (),                                      // (terminated)
  .out6_empty          (),                                      // (terminated)
  .out6_channel        (),                                      // (terminated)
  .out6_error          (),                                      // (terminated)
  .out6_data           (),                                      // (terminated)
  .out7_ready          (1'b1),                                  // (terminated)
  .out7_valid          (),                                      // (terminated)
  .out7_startofpacket  (),                                      // (terminated)
  .out7_endofpacket    (),                                      // (terminated)
  .out7_empty          (),                                      // (terminated)
  .out7_channel        (),                                      // (terminated)
  .out7_error          (),                                      // (terminated)
  .out7_data           (),                                      // (terminated)
  .out8_ready          (1'b1),                                  // (terminated)
  .out8_valid          (),                                      // (terminated)
  .out8_startofpacket  (),                                      // (terminated)
  .out8_endofpacket    (),                                      // (terminated)
  .out8_empty          (),                                      // (terminated)
  .out8_channel        (),                                      // (terminated)
  .out8_error          (),                                      // (terminated)
  .out8_data           (),                                      // (terminated)
  .out9_ready          (1'b1),                                  // (terminated)
  .out9_valid          (),                                      // (terminated)
  .out9_startofpacket  (),                                      // (terminated)
  .out9_endofpacket    (),                                      // (terminated)
  .out9_empty          (),                                      // (terminated)
  .out9_channel        (),                                      // (terminated)
  .out9_error          (),                                      // (terminated)
  .out9_data           (),                                      // (terminated)
  .out10_ready         (1'b1),                                  // (terminated)
  .out10_valid         (),                                      // (terminated)
  .out10_startofpacket (),                                      // (terminated)
  .out10_endofpacket   (),                                      // (terminated)
  .out10_empty         (),                                      // (terminated)
  .out10_channel       (),                                      // (terminated)
  .out10_error         (),                                      // (terminated)
  .out10_data          (),                                      // (terminated)
  .out11_ready         (1'b1),                                  // (terminated)
  .out11_valid         (),                                      // (terminated)
  .out11_startofpacket (),                                      // (terminated)
  .out11_endofpacket   (),                                      // (terminated)
  .out11_empty         (),                                      // (terminated)
  .out11_channel       (),                                      // (terminated)
  .out11_error         (),                                      // (terminated)
  .out11_data          (),                                      // (terminated)
  .out12_ready         (1'b1),                                  // (terminated)
  .out12_valid         (),                                      // (terminated)
  .out12_startofpacket (),                                      // (terminated)
  .out12_endofpacket   (),                                      // (terminated)
  .out12_empty         (),                                      // (terminated)
  .out12_channel       (),                                      // (terminated)
  .out12_error         (),                                      // (terminated)
  .out12_data          (),                                      // (terminated)
  .out13_ready         (1'b1),                                  // (terminated)
  .out13_valid         (),                                      // (terminated)
  .out13_startofpacket (),                                      // (terminated)
  .out13_endofpacket   (),                                      // (terminated)
  .out13_empty         (),                                      // (terminated)
  .out13_channel       (),                                      // (terminated)
  .out13_error         (),                                      // (terminated)
  .out13_data          (),                                      // (terminated)
  .out14_ready         (1'b1),                                  // (terminated)
  .out14_valid         (),                                      // (terminated)
  .out14_startofpacket (),                                      // (terminated)
  .out14_endofpacket   (),                                      // (terminated)
  .out14_empty         (),                                      // (terminated)
  .out14_channel       (),                                      // (terminated)
  .out14_error         (),                                      // (terminated)
  .out14_data          (),                                      // (terminated)
  .out15_ready         (1'b1),                                  // (terminated)
  .out15_valid         (),                                      // (terminated)
  .out15_startofpacket (),                                      // (terminated)
  .out15_endofpacket   (),                                      // (terminated)
  .out15_empty         (),                                      // (terminated)
  .out15_channel       (),                                      // (terminated)
  .out15_error         (),                                      // (terminated)
  .out15_data          ()                                       // (terminated)
);

output_ctrl #(
  .USE_COMB_LOGIC (USE_COMB_LOGIC)
) output_ctrl (
  .clock              (clock),                                //   clock.clk
  .reset              (rst_controller_reset_out_reset),       //   reset.reset
  .limiter_data       (hard_limiter_out_splitter_out1_data),  // limiter.data
  .limiter_ready      (hard_limiter_out_splitter_out1_ready), //        .ready
  .limiter_valid      (hard_limiter_out_splitter_out1_valid), //        .valid
  .out_data           (st2mm_data),                           //     out.data
  .out_ready          (st2mm_ready),                          //        .ready
  .out_valid          (st2mm_valid),                          //        .valid
  .iter_output_enable (iteration_ctrl_out_ctrl_new_signal)    //    iter.new_signal
);

sample2lvl_converter #(
  .LVLS_NUM        (LVLS_NUM),
  .LVL_RESET_VALUE (LVL_RESET_VALUE)
) sample2lvl_converter (
  .in_data          (mm2st_data),                              //         in.data
  .in_valid         (mm2st_valid),                             //           .valid
  .in_ready         (mm2st_ready),                             //           .ready
  .clock            (clock),                                   //      clock.clk
  .reset            (rst_controller_reset_out_reset),          //      reset.reset
  .out_lvl_data     (sample2lvl_converter_0_out_lvl_data),     //    out_lvl.data
  .out_lvl_valid    (sample2lvl_converter_0_out_lvl_valid),    //           .valid
  .out_limits_data  (sample2lvl_converter_0_out_limits_data),  // out_limits.data
  .out_limits_valid (sample2lvl_converter_0_out_limits_valid), //           .valid
  .iter_valid       (sample2lvl_converter_0_iter_new_signal),  //       iter.new_signal
  .iter_ready       (iteration_ctrl_lvl_gen_new_signal_1)      //           .new_signal_1
);

signal_buffer signal_buffer (
  .clock              (clock),                                 //  clock.clk
  .reset              (rst_controller_reset_out_reset),        //  reset.reset
  .port_a_address     (signal_buffer_ctrl_port_a_address),     // port_a.address
  .port_a_chipselect  (signal_buffer_ctrl_port_a_chipselect),  //       .chipselect
  .port_a_read        (signal_buffer_ctrl_port_a_read),        //       .read
  .port_a_readdata    (signal_buffer_ctrl_port_a_readdata),    //       .readdata
  .port_a_write       (signal_buffer_ctrl_port_a_write),       //       .write
  .port_a_writedata   (signal_buffer_ctrl_port_a_writedata),   //       .writedata
  .port_a_byteenable  (signal_buffer_ctrl_port_a_byteenable),  //       .byteenable
  .port_a_waitrequest (signal_buffer_ctrl_port_a_waitrequest), //       .waitrequest
  .port_b_address     (signal_buffer_ctrl_port_b_address),     // port_b.address
  .port_b_chipselect  (signal_buffer_ctrl_port_b_chipselect),  //       .chipselect
  .port_b_read        (signal_buffer_ctrl_port_b_read),        //       .read
  .port_b_readdata    (signal_buffer_ctrl_port_b_readdata),    //       .readdata
  .port_b_write       (signal_buffer_ctrl_port_b_write),       //       .write
  .port_b_writedata   (signal_buffer_ctrl_port_b_writedata),   //       .writedata
  .port_b_byteenable  (signal_buffer_ctrl_port_b_byteenable),  //       .byteenable
  .port_b_waitrequest (signal_buffer_ctrl_port_b_waitrequest)  //       .waitrequest
);

signal_buffer_ctrl #(
  .MAX_SAMPLES_IN_RAM (MAX_SAMPLES_IN_RAM),
  .ITER_NUM           (ITER_NUM)
) signal_buffer_ctrl (
  .clock                    (clock),                                 //      clock.clk
  .reset                    (rst_controller_reset_out_reset),        //      reset.reset
  .lvl_gen_data             (lvl_generator_out_splitter_out0_data),  //    lvl_gen.data
  .lvl_gen_valid            (lvl_generator_out_splitter_out0_valid), //           .valid
  .limiter_data             (hard_limiter_out_splitter_out0_data),   //    limiter.data
  .limiter_valid            (hard_limiter_out_splitter_out0_valid),  //           .valid
  .limiter_ready            (hard_limiter_out_splitter_out0_ready),  //           .ready
  .iter_iter_num            (iteration_ctrl_sigbuff_new_signal),     //       iter.new_signal
  .iter_input_mux           (iteration_ctrl_sigbuff_new_signal_1),   //           .new_signal_1
  .iter_input_enable        (iteration_ctrl_sigbuff_new_signal_2),   //           .new_signal_2
  .iter_output_enable       (iteration_ctrl_sigbuff_new_signal_3),   //           .new_signal_3
  .ram_signal_address_a     (signal_buffer_ctrl_port_a_address),     //     port_a.address
  .ram_signal_byteenable_a  (signal_buffer_ctrl_port_a_byteenable),  //           .byteenable
  .ram_signal_chipselect_a  (signal_buffer_ctrl_port_a_chipselect),  //           .chipselect
  .ram_signal_readdata_a    (signal_buffer_ctrl_port_a_readdata),    //           .readdata
  .ram_signal_write_a       (signal_buffer_ctrl_port_a_write),       //           .write
  .ram_signal_writedata_a   (signal_buffer_ctrl_port_a_writedata),   //           .writedata
  .ram_signal_waitrequest_a (signal_buffer_ctrl_port_a_waitrequest), //           .waitrequest
  .ram_signal_read_a        (signal_buffer_ctrl_port_a_read),        //           .read
  .ram_signal_address_b     (signal_buffer_ctrl_port_b_address),     //     port_b.address
  .ram_signal_byteenable_b  (signal_buffer_ctrl_port_b_byteenable),  //           .byteenable
  .ram_signal_chipselect_b  (signal_buffer_ctrl_port_b_chipselect),  //           .chipselect
  .ram_signal_readdata_b    (signal_buffer_ctrl_port_b_readdata),    //           .readdata
  .ram_signal_write_b       (signal_buffer_ctrl_port_b_write),       //           .write
  .ram_signal_writedata_b   (signal_buffer_ctrl_port_b_writedata),   //           .writedata
  .ram_signal_waitrequest_b (signal_buffer_ctrl_port_b_waitrequest), //           .waitrequest
  .ram_signal_read_b        (signal_buffer_ctrl_port_b_read),        //           .read
  .fir_driver_data          (signal_buffer_ctrl_fir_driver_data),    // fir_driver.data
  .fir_driver_valid         (signal_buffer_ctrl_fir_driver_valid)    //           .valid
);

altera_reset_controller #(
  .NUM_RESET_INPUTS          (1),
  .OUTPUT_RESET_SYNC_EDGES   ("deassert"),
  .SYNC_DEPTH                (2),
  .RESET_REQUEST_PRESENT     (1),
  .RESET_REQ_WAIT_TIME       (1),
  .MIN_RST_ASSERTION_TIME    (3),
  .RESET_REQ_EARLY_DSRT_TIME (1),
  .USE_RESET_REQUEST_IN0     (0),
  .USE_RESET_REQUEST_IN1     (0),
  .USE_RESET_REQUEST_IN2     (0),
  .USE_RESET_REQUEST_IN3     (0),
  .USE_RESET_REQUEST_IN4     (0),
  .USE_RESET_REQUEST_IN5     (0),
  .USE_RESET_REQUEST_IN6     (0),
  .USE_RESET_REQUEST_IN7     (0),
  .USE_RESET_REQUEST_IN8     (0),
  .USE_RESET_REQUEST_IN9     (0),
  .USE_RESET_REQUEST_IN10    (0),
  .USE_RESET_REQUEST_IN11    (0),
  .USE_RESET_REQUEST_IN12    (0),
  .USE_RESET_REQUEST_IN13    (0),
  .USE_RESET_REQUEST_IN14    (0),
  .USE_RESET_REQUEST_IN15    (0),
  .ADAPT_RESET_REQUEST       (0)
) rst_controller (
  .reset_in0      (~reset_n),                           // reset_in0.reset
  .clk            (clock),                              //       clk.clk
  .reset_out      (rst_controller_reset_out_reset),     // reset_out.reset
  .reset_req      (rst_controller_reset_out_reset_req), //          .reset_req
  .reset_req_in0  (1'b0),                               // (terminated)
  .reset_in1      (1'b0),                               // (terminated)
  .reset_req_in1  (1'b0),                               // (terminated)
  .reset_in2      (1'b0),                               // (terminated)
  .reset_req_in2  (1'b0),                               // (terminated)
  .reset_in3      (1'b0),                               // (terminated)
  .reset_req_in3  (1'b0),                               // (terminated)
  .reset_in4      (1'b0),                               // (terminated)
  .reset_req_in4  (1'b0),                               // (terminated)
  .reset_in5      (1'b0),                               // (terminated)
  .reset_req_in5  (1'b0),                               // (terminated)
  .reset_in6      (1'b0),                               // (terminated)
  .reset_req_in6  (1'b0),                               // (terminated)
  .reset_in7      (1'b0),                               // (terminated)
  .reset_req_in7  (1'b0),                               // (terminated)
  .reset_in8      (1'b0),                               // (terminated)
  .reset_req_in8  (1'b0),                               // (terminated)
  .reset_in9      (1'b0),                               // (terminated)
  .reset_req_in9  (1'b0),                               // (terminated)
  .reset_in10     (1'b0),                               // (terminated)
  .reset_req_in10 (1'b0),                               // (terminated)
  .reset_in11     (1'b0),                               // (terminated)
  .reset_req_in11 (1'b0),                               // (terminated)
  .reset_in12     (1'b0),                               // (terminated)
  .reset_req_in12 (1'b0),                               // (terminated)
  .reset_in13     (1'b0),                               // (terminated)
  .reset_req_in13 (1'b0),                               // (terminated)
  .reset_in14     (1'b0),                               // (terminated)
  .reset_req_in14 (1'b0),                               // (terminated)
  .reset_in15     (1'b0),                               // (terminated)
  .reset_req_in15 (1'b0)                                // (terminated)
);

endmodule
