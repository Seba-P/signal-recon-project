
module sample2lvl_converter
#(
	parameter LVLS_NUM 			= 20,
	parameter LVL_RESET_VALUE 	= 9
)
(
	/* Common IF */
	input  wire        reset,
	input  wire        clock,
	/* SGDMA IF */
	input  wire [15:0] in_data,
	output wire        in_ready,
	input  wire        in_valid,
	/* Output data IF */
	output wire [15:0] out_value,
	output wire [31:0] out_limits, 	// [31:16] -> upper limit, [15:0] -> lower limit
	output wire 	   out_valid,
	input  wire 	   out_ready
);

wire lvl_gen_cross_dir;
wire lvl_gen_new_sample;
wire lvl_gen_valid;

sample_dispatcher
#(

)
sample_dispatcher_inst
(
	/* Common IF */
	.reset				(reset),
	.clock				(clock),
	/* SGDMA IF */
	.in_data			(in_data),
	.in_ready			(in_ready),
	.in_valid			(in_valid),
	/* Lvl generator IF */
	.lvl_gen_cross_dir	(lvl_gen_cross_dir),
	.lvl_gen_new_sample	(lvl_gen_new_sample),
	.lvl_gen_valid		(lvl_gen_valid),
	/* Iteration controler IF */
	.iter_ready 		(out_ready)
);

lvl_generator
#(
	.LVLS_NUM 		(LVLS_NUM),
	.LVL_RESET_VALUE(LVL_RESET_VALUE)
)
lvl_generator_inst
(
	/* Common IF */
	.reset 				(reset),
	.clock 				(clock),
	/* Sample dispatcher IF */
	.disp_cross_dir 	(lvl_gen_cross_dir),
	.disp_new_sample 	(lvl_gen_new_sample),
	.disp_valid 		(lvl_gen_valid),
	/* Buffer controlers IF */
	.buff_value 		(out_value),
	.buff_limits 		(out_limits),
	/* Iteration controler IF */
	.iter_valid 		(out_valid)
);

endmodule
