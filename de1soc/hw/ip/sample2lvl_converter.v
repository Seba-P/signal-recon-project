
module sample2lvl_converter
(
	input  wire        reset,           //    reset.reset
	input  wire [15:0] in_data,         //       in.data
	output wire        in_ready,        //         .ready
	input  wire        in_valid,        //         .valid
	input  wire        csr_address,     //      csr.address
	input  wire        csr_read,        //         .read
	output wire [31:0] csr_readdata,    //         .readdata
	output wire        csr_waitrequest, //         .waitrequest
	input  wire        csr_write,       //         .write
	input  wire [31:0] csr_writedata,   //         .writedata
	input  wire [3:0]  csr_byteenable,  //         .byteenable
	input  wire        csr_chipselect,  //         .chipselect
	input  wire        clk,             //    clock.clk
	output wire [15:0] fir_data,        // fir_data.data
	input  wire        fir_ready,       //         .ready
	output wire        fir_valid,       //         .valid
	output wire [9:0]  ram_address,     // ram_data.address
	output wire        ram_chipselect,  //         .chipselect
	output wire        ram_read,        //         .read
	output wire        ram_write,       //         .write
	input  wire [15:0] ram_readdata,    //         .readdata
	output wire [15:0] ram_writedata,   //         .writedata
	output wire [1:0]  ram_byteenable,  //         .byteenable
	input  wire        ram_waitrequest  //         .waitrequest
);

	assign in_ready 		= fir_ready;
	assign csr_readdata 	= 32'hDEAD_BEEF;
	assign csr_waitrequest 	= 1'b0;
	assign fir_data 		= in_data;
	assign fir_valid 		= in_valid;
	assign ram_address 		= 10'h2AA;
	assign ram_chipselect 	= 1'b0;
	assign ram_read 		= 1'b0;
	assign ram_write 		= 1'b0;
	assign ram_writedata 	= in_data;
	assign ram_byteenable 	= 2'b11;

endmodule
