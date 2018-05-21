
module st2mm_data_adapter
(
  input  wire        avalon_st_reset,                //      avalon_st_reset.reset
  input  wire        avalon_st_clk_sink,             //   avalon_st_clk_sink.clk
  input  wire [15:0] avalon_st_sink_data,            //       avalon_st_sink.data
  input  wire        avalon_st_sink_valid,           //                     .valid
  output wire        avalon_st_sink_ready,           //                     .ready
  input  wire        avalon_st_clk_source,           // avalon_st_clk_source.clk
  output wire [15:0] avalon_st_source_data,          //     avalon_st_source.data
  output wire        avalon_st_source_valid,         //                     .valid
  output wire        avalon_st_source_empty,         //                     .empty
  output wire        avalon_st_source_startofpacket, //                     .startofpacket
  output wire        avalon_st_source_endofpacket,   //                     .endofpacket
  input  wire        avalon_st_source_ready          //                     .ready
);

assign avalon_st_sink_ready           = avalon_st_source_ready;
assign avalon_st_source_data          = avalon_st_sink_data;
assign avalon_st_source_valid         = avalon_st_sink_valid;
assign avalon_st_source_empty         = '0;
assign avalon_st_source_startofpacket = '0;
assign avalon_st_source_endofpacket   = '0;

endmodule
