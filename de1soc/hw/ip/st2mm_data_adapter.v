
module st2mm_data_adapter
(
	output wire        avalon_st_sink_ready,           //       avalon_st_sink.ready
	input  wire [15:0] avalon_st_sink_data,            //                     .data
	input  wire        avalon_st_sink_valid,           //                     .valid
	output wire [15:0] avalon_st_source_data,          //     avalon_st_source.data
	output wire        avalon_st_source_endofpacket,   //                     .endofpacket
	input  wire        avalon_st_source_ready,         //                     .ready
	output wire        avalon_st_source_startofpacket, //                     .startofpacket
	output wire        avalon_st_source_valid,         //                     .valid
	input  wire        avalon_st_clk_sink,             //   avalon_st_clk_sink.clk
	input  wire        avalon_st_clk_source,           // avalon_st_clk_source.clk
	input  wire        avalon_st_reset                 //      avalon_st_reset.reset
);

assign avalon_st_sink_ready 			= avalon_st_source_ready;
assign avalon_st_source_valid 			= avalon_st_sink_valid;
assign avalon_st_source_data 			= avalon_st_sink_data;
assign avalon_st_source_startofpacket 	= 1'b0;
assign avalon_st_source_endofpacket 	= 1'b0;

endmodule
