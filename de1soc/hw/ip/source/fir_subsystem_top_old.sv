
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
  input  wire        reset,
  input  wire        clock,
  /* MM2ST IF */
  input  wire [15:0] mm2st_data,
  output wire        mm2st_ready,
  input  wire        mm2st_valid,
  /* ST2MM IF */
  output wire [15:0] st2mm_data,
  input  wire        st2mm_ready,
  output wire        st2mm_valid
);

/* Lvl generator output IF */
wire        lvl_gen_iter_valid;
wire        lvl_gen_iter_ready;
wire [15:0] lvl_gen_lvl_data;
wire        lvl_gen_lvl_valid;
wire [31:0] lvl_gen_limits_data;
wire        lvl_gen_limits_valid;
/* Iteration controler output IF */
wire [ 4:0] sigbuff_iter_num;
wire        sigbuff_input_mux;
wire        sigbuff_input_enable;
wire        sigbuff_output_enable;
wire        limbuff_input_enable;
wire        limbuff_output_enable;
wire [ 1:0] fir_input_mux;
wire        fir_input_enable;
/* FIR driver output IF */
wire [15:0] fir_data;
wire        fir_valid;
wire        fir_ready;
/* FIR filter output IF */
wire [15:0] fir_out_data;
wire        fir_out_valid;
wire        fir_out_ready;
/* Limits buffer controler output IF */
wire [31:0] limiter_data;
wire        limiter_valid;
/* Limits buffer IF */
wire [ 9:0] ram_limits_address_a;
wire [ 9:0] ram_limits_address_b;
wire        ram_limits_chipselect_a;
wire        ram_limits_chipselect_b;
wire        ram_limits_read_a;
wire        ram_limits_read_b;
wire        ram_limits_write_a;
wire        ram_limits_write_b;
wire [31:0] ram_limits_readdata_a;
wire [31:0] ram_limits_readdata_b;
wire [31:0] ram_limits_writedata_a;
wire [31:0] ram_limits_writedata_b;
wire [ 3:0] ram_limits_byteenable_a;
wire [ 3:0] ram_limits_byteenable_b;
wire        ram_limits_waitrequest_a;
wire        ram_limits_waitrequest_b;
/* Signal buffer controler output IF */
wire [15:0] fir_ram_data;
wire        fir_ram_valid;
/* Signal buffer IF */
wire [13:0] ram_signal_address_a;
wire [13:0] ram_signal_address_b;
wire        ram_signal_chipselect_a;
wire        ram_signal_chipselect_b;
wire        ram_signal_read_a;
wire        ram_signal_read_b;
wire        ram_signal_write_a;
wire        ram_signal_write_b;
wire [15:0] ram_signal_readdata_a;
wire [15:0] ram_signal_readdata_b;
wire [15:0] ram_signal_writedata_a;
wire [15:0] ram_signal_writedata_b;
wire [ 1:0] ram_signal_byteenable_a;
wire [ 1:0] ram_signal_byteenable_b;
wire        ram_signal_waitrequest_a;
wire        ram_signal_waitrequest_b;

sample2lvl_converter
#(
  .LVLS_NUM         (LVLS_NUM),
  .LVL_RESET_VALUE  (LVL_RESET_VALUE)
)
sample2lvl_converter_inst
(
  /* Common IF */
  .reset            (reset),
  .clock            (clock),
  /* SGDMA IF */
  .in_data          (mm2st_data),
  .in_valid         (mm2st_valid),
  .in_ready         (mm2st_ready),
  /* Iteration controller IF */
  .iter_valid       (lvl_gen_iter_valid),
  .iter_ready       (lvl_gen_iter_ready),
  /* Output lvl IF */
  .out_lvl_data     (lvl_gen_lvl_data),
  .out_lvl_valid    (lvl_gen_lvl_valid),
  /* Output limits IF */
  .out_limits_data  (lvl_gen_limits_data),
  .out_limits_valid (lvl_gen_limits_valid)
);

assign ram_signal_waitrequest_a = 'd0;
assign ram_signal_waitrequest_b = 'd0;

signal_buffer_ctrl
#(
  .MAX_SAMPLES_IN_RAM (MAX_SAMPLES_IN_RAM),
  .ITER_NUM           (ITER_NUM)
)
signal_buffer_ctrl_inst
(
  /* Common IF */
  .reset                    (reset),
  .clock                    (clock),
  /* Input data IF */
  .in_lvl_gen_value         (lvl_gen_lvl_data),
  .in_lvl_gen_valid         (lvl_gen_lvl_valid),
  .in_fir_out_value         (),
  .in_fir_out_valid         (),
  .in_fir_out_ready         (),
  /* Iteration controler IF */
  .iter_iter_num            (sigbuff_iter_num),
  .iter_input_mux           (sigbuff_input_mux),
  .iter_input_enable        (sigbuff_input_enable),
  .iter_output_enable       (sigbuff_output_enable),
  /* FIR driver IF */
  .fir_ram_data             (),
  .fir_ram_valid            (),
  /* Signal buffer IF */
  /* PORT A */
  .ram_signal_address_a     (ram_signal_address_a),
  .ram_signal_chipselect_a  (ram_signal_chipselect_a),
  .ram_signal_read_a        (ram_signal_read_a),
  .ram_signal_write_a       (ram_signal_write_a),
  .ram_signal_readdata_a    (ram_signal_readdata_a),
  .ram_signal_writedata_a   (ram_signal_writedata_a),
  .ram_signal_byteenable_a  (ram_signal_byteenable_a),
  .ram_signal_waitrequest_a (ram_signal_waitrequest_a),
  /* PORT B */
  .ram_signal_address_b     (ram_signal_address_b),
  .ram_signal_chipselect_b  (ram_signal_chipselect_b),
  .ram_signal_read_b        (ram_signal_read_b),
  .ram_signal_write_b       (ram_signal_write_b),
  .ram_signal_readdata_b    (ram_signal_readdata_b),
  .ram_signal_writedata_b   (ram_signal_writedata_b),
  .ram_signal_byteenable_b  (ram_signal_byteenable_b),
  .ram_signal_waitrequest_b (ram_signal_waitrequest_b)
);

soc_system_signal_buffer signal_buffer_inst
(
  /* PORT A */
  .address      (ram_signal_address_a),
  .byteenable   (ram_signal_byteenable_a),
  .chipselect   (ram_signal_chipselect_a),
  .clk          (clock),
  .clken        ('1), // ???
  .freeze       ('0),
  .reset        (reset),
  .reset_req    ('0), // ???
  .write        (ram_signal_write_a),
  .writedata    (ram_signal_writedata_a),
  .readdata     (ram_signal_readdata_a),
  /* PORT B */
  .address2     (ram_signal_address_b),
  .byteenable2  (ram_signal_byteenable_b),
  .chipselect2  (ram_signal_chipselect_b),
  .clk2         (clock),
  .clken2       ('1), // ???
  .reset2       (reset),
  .reset_req2   ('0), // ???
  .write2       (ram_signal_write_b),
  .writedata2   (ram_signal_writedata_b),
  .readdata2    (ram_signal_readdata_b)
);

assign ram_limits_waitrequest_a = 'd0;
assign ram_limits_waitrequest_b = 'd0;

limits_buffer_ctrl
#(
  .MAX_SAMPLES_IN_RAM (MAX_SAMPLES_IN_RAM)
)
limits_buffer_ctrl_inst
(
  /* Common IF */
  .reset                    (reset),
  .clock                    (clock),
  /* Input data IF */
  .lvl_gen_limits           (lvl_gen_limits),
  .lvl_gen_valid            (lvl_gen_valid),
  /* Iteration controler IF */
  .iter_input_enable        (limbuff_input_enable),
  .iter_output_enable       (limbuff_output_enable),
  /* Hardlimiter IF */
  .limiter_data             (limiter_data),
  .limiter_valid            (limiter_valid),
  /* Limits buffer IF */
  /* PORT A */
  .ram_limits_address_a     (ram_limits_address_a),
  .ram_limits_chipselect_a  (ram_limits_chipselect_a),
  .ram_limits_read_a        (ram_limits_read_a),
  .ram_limits_write_a       (ram_limits_write_a),
  .ram_limits_readdata_a    (ram_limits_readdata_a),
  .ram_limits_writedata_a   (ram_limits_writedata_a),
  .ram_limits_byteenable_a  (ram_limits_byteenable_a),
  .ram_limits_waitrequest_a (ram_limits_waitrequest_a),
  /* PORT B */
  .ram_limits_address_b     (ram_limits_address_b),
  .ram_limits_chipselect_b  (ram_limits_chipselect_b),
  .ram_limits_read_b        (ram_limits_read_b),
  .ram_limits_write_b       (ram_limits_write_b),
  .ram_limits_readdata_b    (ram_limits_readdata_b),
  .ram_limits_writedata_b   (ram_limits_writedata_b),
  .ram_limits_byteenable_b  (ram_limits_byteenable_b),
  .ram_limits_waitrequest_b (ram_limits_waitrequest_b)
);

soc_system_limits_buffer limits_buffer_inst
(
  /* PORT A */
  .address      (ram_limits_address_a),
  .byteenable   (ram_limits_byteenable_a),
  .chipselect   (ram_limits_chipselect_a),
  .clk          (clock),
  .clken        ('1), // ???
  .freeze       ('0),
  .reset        (reset),
  .reset_req    ('0), // ???
  .write        (ram_limits_write_a),
  .writedata    (ram_limits_writedata_a),
  .readdata     (ram_limits_readdata_a),
  /* PORT B */
  .address2     (ram_limits_address_b),
  .byteenable2  (ram_limits_byteenable_b),
  .chipselect2  (ram_limits_chipselect_b),
  .clk2         (clock),
  .clken2       ('1), // ???
  .reset2       (reset),
  .reset_req2   ('0), // ???
  .write2       (ram_limits_write_b),
  .writedata2   (ram_limits_writedata_b),
  .readdata2    (ram_limits_readdata_b)
);

iteration_ctrl
#(
  .MAX_SAMPLES_IN_RAM (MAX_SAMPLES_IN_RAM),
  .ITER_NUM           (ITER_NUM)
)
iteration_ctrl_inst
(

);

// TODO:
fir_driver
#(

)
fir_driver_inst
(

);

soc_system_fir_filter fir_filter
(
  .clk              (clock),
  .reset_n          (~reset),
  .ast_sink_data    (),
  .ast_sink_valid   (),
  .ast_sink_error   (),
  .ast_sink_ready   (),
  .ast_source_data  (),
  .ast_source_valid (),
  .ast_source_error (),
  .ast_source_ready ()
);

endmodule
