
module signal_buffer_ctrl
#(
	parameter MAX_SAMPLES_IN_RAM = 255
)
(
	/* Common IF */
	input  wire        reset,
	input  wire        clock,
	/* Input data IF */
	input  wire [15:0] in_lvl_gen_value,
	// input  wire 	   in_lvl_gen_valid,
	input  wire [15:0] in_fir_out_value,
	input  wire 	   in_fir_out_valid,
	output wire 	   in_fir_out_ready,
	/* Iteration controler IF */
	input  wire 	   iter_input_mux,  	// 1 -> lvl generator output, 0 -> FIR output
	input  wire 	   iter_input_enable,
	/* Iteration controler IF */
	output wire [15:0] fir_ram_data,
	// output wire  	   fir_ram_valid,
	/* Signal buffer IF */
	output wire [13:0] ram_signal_address,
	output wire        ram_signal_chipselect,
	output wire        ram_signal_read,
	output wire        ram_signal_write,
	input  wire [15:0] ram_signal_readdata,
	output wire [15:0] ram_signal_writedata,
	output wire [ 1:0] ram_signal_byteenable,
	input  wire        ram_signal_waitrequest
);

reg 		in_fir_out_ready_r;
reg  [15:0] fir_ram_data_r;
reg  [13:0] ram_signal_address_r;
reg         ram_signal_chipselect_r;
reg         ram_signal_read_r;
reg         ram_signal_write_r;
reg  [31:0] ram_signal_writedata_r;
reg  [ 3:0] ram_signal_byteenable_r;

reg  [ 7:0] symbol_cnt_r;
wire 		full_buffer;

assign in_fir_out_ready 		= in_fir_out_ready_r;
assign fir_ram_data 			= fir_ram_data_r;
assign ram_sample_address 		= ram_sample_address_r;
assign ram_sample_chipselect 	= ram_sample_chipselect_r;
assign ram_sample_read 			= ram_sample_read_r;
assign ram_sample_write 		= ram_sample_write_r;
assign ram_sample_writedata 	= ram_sample_writedata_r;
assign ram_sample_byteenable 	= ram_sample_byteenable_r;

assign full_buffer 				= (symbol_cnt_r == MAX_SAMPLES_IN_RAM - 'd1);

always_ff @(posedge clock)
begin
	if(reset)
	begin
		in_fir_out_ready_r			<= '0;
		fir_ram_data_r 				<= '0;
		ram_signal_address_r		<= '0;
		ram_signal_chipselect_r		<= '0;
		ram_signal_read_r			<= '0;
		ram_signal_write_r			<= '0;
		ram_signal_writedata_r		<= '0;
		ram_signal_byteenable_r		<= '0;

		symbol_cnt_r 				<= '0;
	end
	else
	begin
		
	end
end

endmodule
