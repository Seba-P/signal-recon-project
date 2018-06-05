
module hard_limiter
#(
  parameter USE_COMB_LOGIC = 0
)
(
  /* Common IF */
  input  wire        reset,             //   reset.reset
  input  wire        clock,             //   clock.clk
  /* Limits buffer controller IF */
  input  wire [31:0] limbuff_data,      // limbuff.data
  input  wire        limbuff_valid,     //        .valid
  /* Iteration controller IF */
  input  wire        iter_input_enable, //    iter.new_signal
  output wire        iter_ready,        //        .new_signal_1
  /* FIR filter IF */
  input  wire [15:0] fir_data,          //     fir.data
  input  wire        fir_valid,         //        .valid
  input  wire [ 1:0] fir_error,         //        .error
  output wire        fir_ready,         //        .ready
  /* Output IF */
  output wire [15:0] out_data,          //     out.data
  output wire        out_valid,         //        .valid
  input  wire        out_ready          //        .ready
);

typedef enum reg [1:0]
{
  INBOUND   = 2'b00,
  BELOW_MIN = 2'b01,
  ABOVE_MAX = 2'b10,
  INVALID   = 2'b11
} SIGNAL_CASE_T;

// localparam INBOUND    = 2'b00;
// localparam BELOW_MIN  = 2'b01;
// localparam ABOVE_MAX  = 2'b10;
// localparam INVALID    = 2'b11;

SIGNAL_CASE_T signal_case;
// wire [ 1:0] signal_case;
wire        below_min;
wire        above_max;

assign below_min    = $signed(fir_data) < $signed(limbuff_data[15:0]);
assign above_max    = $signed(fir_data) > $signed(limbuff_data[31:16]);
assign signal_case  = '{ above_max, below_min };

generate
  if(USE_COMB_LOGIC == 0)
  begin
    // reg         fir_ready_r;
    reg  [15:0] out_data_r;
    reg         out_valid_r;

    // assign fir_ready  = fir_ready_r;
    assign iter_ready   = out_ready;
    assign fir_ready    = out_ready;
    assign out_data     = out_data_r;
    assign out_valid    = out_valid_r;

    always_ff @(posedge clock)
    begin
      if(reset)
      begin
        // fir_ready_r   <= '0;
        out_data_r    <= '0;
        out_valid_r   <= '0;
      end
      else
      begin
        unique case(signal_case)
          INBOUND:
            out_data_r  <= fir_data;
          BELOW_MIN:
            out_data_r  <= limbuff_data[15:0];
          ABOVE_MAX:
            out_data_r  <= limbuff_data[31:16];
          INVALID:
            out_data_r  <= fir_data;
        endcase

        out_valid_r <= fir_valid & iter_input_enable & signal_case != INVALID;
      end
    end
  end
  else
  begin
    assign iter_ready = out_ready;
    assign fir_ready  = out_ready;
    assign out_data   = ~reset & (signal_case == BELOW_MIN ? limbuff_data[15:0] :
                                                             (signal_case == ABOVE_MAX ? limbuff_data[31:16] : fir_data));
    assign out_valid  = ~reset & fir_valid & iter_input_enable & signal_case != INVALID;

    /*
    reg  [15:0] out_data_r;
    reg         out_valid_r;

    assign iter_ready   = out_ready;
    assign fir_ready    = out_ready;
    assign out_data     = out_data_r;
    assign out_valid    = out_valid_r;

    always_comb
    begin
      if(reset)
      begin
        out_data  = '0;
        out_valid = '0;
      end
      else
      begin
        unique case(signal_case)
          INBOUND:
            out_data = fir_data;
          BELOW_MIN:
            out_data = limbuff_data[15:0];
          ABOVE_MAX:
            out_data = limbuff_data[31:16];
          INVALID:
            out_data = fir_data;
        endcase

        out_valid = fir_valid & iter_input_enable & signal_case != INVALID;
      end
    end
    */
  end
endgenerate

endmodule
