
module limits_buffer_ctrl
#(
	parameter MAX_SAMPLES_IN_RAM = 255
)
(
	/* Common IF */
	input  wire        reset,
	input  wire        clock,
	/* Input data IF */
	input  wire [31:0] lvl_gen_limits, // [31:16] -> upper limit, [15:0] -> lower limit
	// input  wire 	   lvl_gen_valid,
	/* Iteration controler IF */
	input  wire 	   iter_input_enable,
	/* Limits buffer IF */
	output wire [14:0] ram_limits_address,
	output wire        ram_limits_chipselect,
	output wire        ram_limits_read,
	output wire        ram_limits_write,
	input  wire [31:0] ram_limits_readdata,
	output wire [31:0] ram_limits_writedata,
	output wire [ 3:0] ram_limits_byteenable,
	input  wire        ram_limits_waitrequest
);

reg  [14:0] ram_limits_address_r;
reg         ram_limits_chipselect_r;
reg         ram_limits_write_r;
reg  [31:0] ram_limits_writedata_r;
reg  [ 3:0] ram_limits_byteenable_r;

reg  [ 7:0] symbol_cnt_r;
wire 		full_buffer;

assign ram_limits_address 		= ram_limits_address_r;
assign ram_limits_chipselect 	= ram_limits_chipselect_r;
assign ram_limits_write 		= ram_limits_write_r;
assign ram_limits_writedata 	= ram_limits_writedata_r;
assign ram_limits_byteenable 	= ram_limits_byteenable_r;

assign full_buffer 				= (symbol_cnt_r == MAX_SAMPLES_IN_RAM - 'd1);

always_ff @(posedge clock)
begin
	if(reset)
	begin
		ram_limits_address_r		<= '0;
		ram_limits_chipselect_r		<= '0;
		ram_limits_write_r			<= '0;
		ram_limits_writedata_r		<= '0;
		ram_limits_byteenable_r		<= '0;

		symbol_cnt_r 				<= '0;
	end
	else
	begin
		ram_limits_address_r		<= '{ symbol_cnt_r, 2'b00 }; // is address unit in bytes? 
		ram_limits_chipselect_r		<= 'd1;
		ram_limits_write_r			<= '(iter_input_enable);
		ram_limits_writedata_r		<= lvl_gen_limits;
		ram_limits_byteenable_r		<= '1;

		symbol_cnt_r 				<= full_buffer ? 'd0 : symbol_cnt_r + '(iter_input_enable); // ?
	end
end

endmodule
