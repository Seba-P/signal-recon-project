// soc_system_mm_interconnect_5.v

// This file was auto-generated from altera_mm_interconnect_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 17.1 593

`timescale 1 ps / 1 ps
module soc_system_mm_interconnect_5 (
		input  wire        clk_0_clk_clk,                                        //                                      clk_0_clk.clk
		input  wire        signal_buffer_ctrl_reset_reset_bridge_in_reset_reset, // signal_buffer_ctrl_reset_reset_bridge_in_reset.reset
		input  wire [12:0] signal_buffer_ctrl_port_b_address,                    //                      signal_buffer_ctrl_port_b.address
		output wire        signal_buffer_ctrl_port_b_waitrequest,                //                                               .waitrequest
		input  wire [1:0]  signal_buffer_ctrl_port_b_byteenable,                 //                                               .byteenable
		input  wire        signal_buffer_ctrl_port_b_chipselect,                 //                                               .chipselect
		input  wire        signal_buffer_ctrl_port_b_read,                       //                                               .read
		output wire [15:0] signal_buffer_ctrl_port_b_readdata,                   //                                               .readdata
		input  wire        signal_buffer_ctrl_port_b_write,                      //                                               .write
		input  wire [15:0] signal_buffer_ctrl_port_b_writedata,                  //                                               .writedata
		output wire [12:0] signal_buffer_s2_address,                             //                               signal_buffer_s2.address
		output wire        signal_buffer_s2_write,                               //                                               .write
		input  wire [15:0] signal_buffer_s2_readdata,                            //                                               .readdata
		output wire [15:0] signal_buffer_s2_writedata,                           //                                               .writedata
		output wire [1:0]  signal_buffer_s2_byteenable,                          //                                               .byteenable
		output wire        signal_buffer_s2_chipselect,                          //                                               .chipselect
		output wire        signal_buffer_s2_clken                                //                                               .clken
	);

	wire         signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_waitrequest;   // signal_buffer_s2_translator:uav_waitrequest -> signal_buffer_ctrl_port_b_translator:uav_waitrequest
	wire  [15:0] signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_readdata;      // signal_buffer_s2_translator:uav_readdata -> signal_buffer_ctrl_port_b_translator:uav_readdata
	wire         signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_debugaccess;   // signal_buffer_ctrl_port_b_translator:uav_debugaccess -> signal_buffer_s2_translator:uav_debugaccess
	wire  [13:0] signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_address;       // signal_buffer_ctrl_port_b_translator:uav_address -> signal_buffer_s2_translator:uav_address
	wire         signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_read;          // signal_buffer_ctrl_port_b_translator:uav_read -> signal_buffer_s2_translator:uav_read
	wire   [1:0] signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_byteenable;    // signal_buffer_ctrl_port_b_translator:uav_byteenable -> signal_buffer_s2_translator:uav_byteenable
	wire         signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_readdatavalid; // signal_buffer_s2_translator:uav_readdatavalid -> signal_buffer_ctrl_port_b_translator:uav_readdatavalid
	wire         signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_lock;          // signal_buffer_ctrl_port_b_translator:uav_lock -> signal_buffer_s2_translator:uav_lock
	wire         signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_write;         // signal_buffer_ctrl_port_b_translator:uav_write -> signal_buffer_s2_translator:uav_write
	wire  [15:0] signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_writedata;     // signal_buffer_ctrl_port_b_translator:uav_writedata -> signal_buffer_s2_translator:uav_writedata
	wire   [1:0] signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_burstcount;    // signal_buffer_ctrl_port_b_translator:uav_burstcount -> signal_buffer_s2_translator:uav_burstcount

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (13),
		.AV_DATA_W                   (16),
		.AV_BURSTCOUNT_W             (1),
		.AV_BYTEENABLE_W             (2),
		.UAV_ADDRESS_W               (14),
		.UAV_BURSTCOUNT_W            (2),
		.USE_READ                    (1),
		.USE_WRITE                   (1),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (1),
		.USE_BURSTCOUNT              (0),
		.USE_READDATAVALID           (0),
		.USE_WAITREQUEST             (1),
		.USE_READRESPONSE            (0),
		.USE_WRITERESPONSE           (0),
		.AV_SYMBOLS_PER_WORD         (2),
		.AV_ADDRESS_SYMBOLS          (0),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (0),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) signal_buffer_ctrl_port_b_translator (
		.clk                    (clk_0_clk_clk),                                                                //                       clk.clk
		.reset                  (signal_buffer_ctrl_reset_reset_bridge_in_reset_reset),                         //                     reset.reset
		.uav_address            (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount         (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read               (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write              (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest        (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid      (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable         (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata           (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata          (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock               (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess        (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address             (signal_buffer_ctrl_port_b_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest         (signal_buffer_ctrl_port_b_waitrequest),                                        //                          .waitrequest
		.av_byteenable          (signal_buffer_ctrl_port_b_byteenable),                                         //                          .byteenable
		.av_chipselect          (signal_buffer_ctrl_port_b_chipselect),                                         //                          .chipselect
		.av_read                (signal_buffer_ctrl_port_b_read),                                               //                          .read
		.av_readdata            (signal_buffer_ctrl_port_b_readdata),                                           //                          .readdata
		.av_write               (signal_buffer_ctrl_port_b_write),                                              //                          .write
		.av_writedata           (signal_buffer_ctrl_port_b_writedata),                                          //                          .writedata
		.av_burstcount          (1'b1),                                                                         //               (terminated)
		.av_beginbursttransfer  (1'b0),                                                                         //               (terminated)
		.av_begintransfer       (1'b0),                                                                         //               (terminated)
		.av_readdatavalid       (),                                                                             //               (terminated)
		.av_lock                (1'b0),                                                                         //               (terminated)
		.av_debugaccess         (1'b0),                                                                         //               (terminated)
		.uav_clken              (),                                                                             //               (terminated)
		.av_clken               (1'b1),                                                                         //               (terminated)
		.uav_response           (2'b00),                                                                        //               (terminated)
		.av_response            (),                                                                             //               (terminated)
		.uav_writeresponsevalid (1'b0),                                                                         //               (terminated)
		.av_writeresponsevalid  ()                                                                              //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (13),
		.AV_DATA_W                      (16),
		.UAV_DATA_W                     (16),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (2),
		.UAV_BYTEENABLE_W               (2),
		.UAV_ADDRESS_W                  (14),
		.UAV_BURSTCOUNT_W               (2),
		.AV_READLATENCY                 (1),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.USE_READRESPONSE               (0),
		.USE_WRITERESPONSE              (0),
		.AV_SYMBOLS_PER_WORD            (2),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) signal_buffer_s2_translator (
		.clk                    (clk_0_clk_clk),                                                                //                      clk.clk
		.reset                  (signal_buffer_ctrl_reset_reset_bridge_in_reset_reset),                         //                    reset.reset
		.uav_address            (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_address),       // avalon_universal_slave_0.address
		.uav_burstcount         (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_burstcount),    //                         .burstcount
		.uav_read               (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_read),          //                         .read
		.uav_write              (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_write),         //                         .write
		.uav_waitrequest        (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid      (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_readdatavalid), //                         .readdatavalid
		.uav_byteenable         (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_byteenable),    //                         .byteenable
		.uav_readdata           (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_readdata),      //                         .readdata
		.uav_writedata          (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_writedata),     //                         .writedata
		.uav_lock               (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_lock),          //                         .lock
		.uav_debugaccess        (signal_buffer_ctrl_port_b_translator_avalon_universal_master_0_debugaccess),   //                         .debugaccess
		.av_address             (signal_buffer_s2_address),                                                     //      avalon_anti_slave_0.address
		.av_write               (signal_buffer_s2_write),                                                       //                         .write
		.av_readdata            (signal_buffer_s2_readdata),                                                    //                         .readdata
		.av_writedata           (signal_buffer_s2_writedata),                                                   //                         .writedata
		.av_byteenable          (signal_buffer_s2_byteenable),                                                  //                         .byteenable
		.av_chipselect          (signal_buffer_s2_chipselect),                                                  //                         .chipselect
		.av_clken               (signal_buffer_s2_clken),                                                       //                         .clken
		.av_read                (),                                                                             //              (terminated)
		.av_begintransfer       (),                                                                             //              (terminated)
		.av_beginbursttransfer  (),                                                                             //              (terminated)
		.av_burstcount          (),                                                                             //              (terminated)
		.av_readdatavalid       (1'b0),                                                                         //              (terminated)
		.av_waitrequest         (1'b0),                                                                         //              (terminated)
		.av_writebyteenable     (),                                                                             //              (terminated)
		.av_lock                (),                                                                             //              (terminated)
		.uav_clken              (1'b0),                                                                         //              (terminated)
		.av_debugaccess         (),                                                                             //              (terminated)
		.av_outputenable        (),                                                                             //              (terminated)
		.uav_response           (),                                                                             //              (terminated)
		.av_response            (2'b00),                                                                        //              (terminated)
		.uav_writeresponsevalid (),                                                                             //              (terminated)
		.av_writeresponsevalid  (1'b0)                                                                          //              (terminated)
	);

endmodule
