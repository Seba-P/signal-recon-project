
module mm2st_data_adapter
(
	input  wire        avalon_st_clk_source,         // avalon_st_clk_source.clk
	input  wire        avalon_st_sink_startofpacket, //       avalon_st_sink.startofpacket
	input  wire        avalon_st_sink_endofpacket,   //                     .endofpacket
	input  wire [15:0] avalon_st_sink_data,          //                     .data
	output wire        avalon_st_sink_ready,         //                     .ready
	input  wire        avalon_st_sink_valid,         //                     .valid
	output wire [15:0] avalon_st_source_data,        //     avalon_st_source.data
	output wire        avalon_st_source_valid,       //                     .valid
	input  wire        avalon_st_source_ready,       //                     .ready
	input  wire        avalon_st_clk_sink,           //   avalon_st_clk_sink.clk
	input  wire        avalon_st_reset               //      avalon_st_reset.reset
);

assign avalon_st_sink_ready 	= avalon_st_source_ready;
assign avalon_st_source_valid 	= avalon_st_sink_valid;
assign avalon_st_source_data 	= avalon_st_sink_data;

endmodule
