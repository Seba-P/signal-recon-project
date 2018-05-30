// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module limits_buffer
(
  /* Common IF */
  input  wire        reset,               //  reset.reset
  input  wire        clock,               //  clock.clk
  /* PORT A */
  input  wire [ 7:0] port_a_address,      // port_a.address
  input  wire        port_a_chipselect,   //       .chipselect
  input  wire        port_a_read,         //       .read
  output wire [31:0] port_a_readdata,     //       .readdata
  input  wire        port_a_write,        //       .write
  input  wire [31:0] port_a_writedata,    //       .writedata
  input  wire [ 3:0] port_a_byteenable,   //       .byteenable
  output wire        port_a_waitrequest,  //       .waitrequest
  /* PORT B */
  input  wire [ 7:0] port_b_address,      // port_b.address
  input  wire        port_b_chipselect,   //       .chipselect
  input  wire        port_b_read,         //       .read
  output wire [31:0] port_b_readdata,     //       .readdata
  input  wire        port_b_write,        //       .write
  input  wire [31:0] port_b_writedata,    //       .writedata
  input  wire [ 3:0] port_b_byteenable,   //       .byteenable
  output wire        port_b_waitrequest   //       .waitrequest
);

// reg         port_a_waitrequest_r;
wire        port_a_addressstall;
// reg         port_b_waitrequest_r;
wire        port_b_addressstall;
// wire [ 1:0] byte_enable;
wire        byte_enable;
wire        async_clear;

assign port_a_waitrequest   = '0; // wait request feature not used
assign port_a_addressstall  = '0; // address stall feature not used
assign port_b_waitrequest   = '0; // wait request feature not used
assign port_b_addressstall  = '0; // address stall feature not used
assign byte_enable          = '1; // byte enable feature not used
assign async_clear          = '0; // asynchronous clear feature not used

altsyncram  altsyncram_component
(
  /* Common IF */
  .eccstatus      (),
  .clock0         (clock),
  .clock1         (1'b1),
  .clocken0       (1'b1),
  .clocken1       (1'b1),
  .clocken2       (1'b1),
  .clocken3       (1'b1),
  .aclr0          (async_clear),
  .aclr1          (async_clear),
  /* PORT A */
  .address_a      (port_a_address),
  .addressstall_a (port_a_addressstall),
  .byteena_a      (byte_enable),
  .wren_a         (port_a_write),
  .data_a         (port_a_writedata),
  .rden_a         (port_b_read),        // yep, use port_b_read signal
  .q_a            (),                   // don't connect any wire
  /* PORT B */
  .address_b      (port_b_address),
  .addressstall_b (port_b_addressstall),
  .byteena_b      (byte_enable),
  .wren_b         (port_b_write),
  .data_b         (port_b_writedata),
  .rden_b         (port_b_read),
  .q_b            (port_b_readdata)
);

defparam
  altsyncram_component.address_aclr_b                     = "NONE",
  altsyncram_component.address_reg_b                      = "CLOCK0",
  altsyncram_component.clock_enable_input_a               = "BYPASS",
  altsyncram_component.clock_enable_input_b               = "BYPASS",
  altsyncram_component.clock_enable_output_b              = "BYPASS",
  altsyncram_component.intended_device_family             = "Cyclone V",
  altsyncram_component.lpm_type                           = "altsyncram",
  altsyncram_component.numwords_a                         = 256,
  altsyncram_component.numwords_b                         = 256,
  altsyncram_component.operation_mode                     = "DUAL_PORT",
  altsyncram_component.outdata_aclr_b                     = "NONE",
  altsyncram_component.outdata_reg_b                      = "CLOCK0",
  altsyncram_component.power_up_uninitialized             = "TRUE",
  altsyncram_component.read_during_write_mode_mixed_ports = "DONT_CARE",
  altsyncram_component.widthad_a                          = 8,
  altsyncram_component.widthad_b                          = 8,
  altsyncram_component.width_a                            = 32,
  altsyncram_component.width_b                            = 32,
  altsyncram_component.width_byteena_a                    = 1;

/* 
  Default altsyncram parameters:

    altsyncram_component.width_a                            = 1;
    altsyncram_component.widthad_a                          = 1;
    altsyncram_component.numwords_a                         = 0;
    altsyncram_component.outdata_reg_a                      = "UNREGISTERED";
    altsyncram_component.address_aclr_a                     = "NONE";
    altsyncram_component.outdata_aclr_a                     = "NONE";
    altsyncram_component.indata_aclr_a                      = "NONE";
    altsyncram_component.wrcontrol_aclr_a                   = "NONE";
    altsyncram_component.byteena_aclr_a                     = "NONE";
    altsyncram_component.width_byteena_a                    = 1;
    altsyncram_component.width_b                            = 1;
    altsyncram_component.widthad_b                          = 1;
    altsyncram_component.numwords_b                         = 0;
    altsyncram_component.rdcontrol_reg_b                    = "CLOCK1";
    altsyncram_component.address_reg_b                      = "CLOCK1";
    altsyncram_component.outdata_reg_b                      = "UNREGISTERED";
    altsyncram_component.outdata_aclr_b                     = "NONE";
    altsyncram_component.rdcontrol_aclr_b                   = "NONE";
    altsyncram_component.indata_reg_b                       = "CLOCK1";
    altsyncram_component.wrcontrol_wraddress_reg_b          = "CLOCK1";
    altsyncram_component.byteena_reg_b                      = "CLOCK1";
    altsyncram_component.indata_aclr_b                      = "NONE";
    altsyncram_component.wrcontrol_aclr_b                   = "NONE";
    altsyncram_component.address_aclr_b                     = "NONE";
    altsyncram_component.byteena_aclr_b                     = "NONE";
    altsyncram_component.width_byteena_b                    = 1;
    altsyncram_component.clock_enable_input_a               = "NORMAL";
    altsyncram_component.clock_enable_output_a              = "NORMAL";
    altsyncram_component.clock_enable_input_b               = "NORMAL";
    altsyncram_component.clock_enable_output_b              = "NORMAL";

    altsyncram_component.clock_enable_core_a                = "USE_INPUT_CLKEN";
    altsyncram_component.clock_enable_core_b                = "USE_INPUT_CLKEN";
    altsyncram_component.read_during_write_mode_port_a      = "NEW_DATA_NO_NBE_READ";
    altsyncram_component.read_during_write_mode_port_b      = "NEW_DATA_NO_NBE_READ";
    altsyncram_component.enable_ecc                         = "FALSE";
    altsyncram_component.width_eccstatus                    = 3;
    altsyncram_component.ecc_pipeline_stage_enabled         = "FALSE";
    altsyncram_component.operation_mode                     = "BIDIR_DUAL_PORT";
    altsyncram_component.byte_size                          = 0;
    altsyncram_component.read_during_write_mode_mixed_ports = "DONT_CARE";
    altsyncram_component.ram_block_type                     = "AUTO";
    altsyncram_component.init_file                          = "UNUSED";
    altsyncram_component.init_file_layout                   = "UNUSED";
    altsyncram_component.maximum_depth                      = 0;
    altsyncram_component.intended_device_family             = "Stratix";

    altsyncram_component.lpm_hint                           = "UNUSED";
    altsyncram_component.lpm_type                           = "altsyncram";
    altsyncram_component.implement_in_les                   = "OFF";
    altsyncram_component.power_up_uninitialized             = "FALSE";

*/

endmodule // limits_buffer
