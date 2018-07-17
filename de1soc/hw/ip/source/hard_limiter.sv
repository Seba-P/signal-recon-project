
module hard_limiter
#(
  parameter USE_COMB_LOGIC = 0
)
(
  /* Common IF */
  input  wire        reset,               //   reset.reset
  input  wire        clock,               //   clock.clk
  /* Limits buffer controller IF */
  input  wire [31:0] limbuff_data,        // limbuff.data
  input  wire        limbuff_valid,       //        .valid
  /* Iteration controller IF */
  input  wire        iter_valid_signal,   //    iter.new_signal
  input  wire        iter_output_enable,  //        .new_signal_1
  output wire        iter_ready,          //        .new_signal_2
  /* FIR filter IF */
  input  wire [15:0] fir_data,            //     fir.data
  input  wire        fir_valid,           //        .valid
  input  wire [ 1:0] fir_error,           //        .error
  output wire        fir_ready,           //        .ready
  /* Output IF */
  output wire [15:0] out_data,            //     out.data
  output wire        out_valid,           //        .valid
  input  wire        out_ready            //        .ready
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

SIGNAL_CASE_T signal_case_r;
// wire [ 1:0] signal_case;
wire        below_min;
wire        above_max;

assign below_min    = $signed(fir_data) < $signed(limbuff_data[15:0]);
assign above_max    = $signed(fir_data) > $signed(limbuff_data[31:16]);
// assign signal_case  = '{ above_max, below_min };

generate
  if(USE_COMB_LOGIC == 0)
  begin
    reg  [31:0] limbuff_data_r;
    reg         limbuff_valid_r;
    reg         iter_valid_signal_r;
    reg         iter_output_enable_r;
    // reg         iter_ready_r;
    reg  [15:0] fir_data_r;
    reg         fir_valid_r;
    // reg         fir_ready_r;
    reg  [15:0] out_data_r;
    reg         out_valid_r;

    // assign fir_ready  = fir_ready_r;
    assign iter_ready   = out_ready;
    assign fir_ready    = out_ready & iter_output_enable;
    assign out_data     = out_data_r;
    assign out_valid    = out_valid_r;

    always_ff @(posedge clock)
    begin
      if(reset)
      begin
        limbuff_data_r        <= '0;
        limbuff_valid_r       <= '0;
        iter_valid_signal_r   <= '0;
        iter_output_enable_r  <= '0;
        // iter_ready_r          <= '0;
        fir_data_r            <= '0;
        fir_valid_r           <= '0;
        // fir_ready_r           <= '0;
        out_data_r            <= '0;
        out_valid_r           <= '0;
        signal_case_r         <= INVALID; // ?
      end
      else
      begin
        limbuff_data_r        <= limbuff_data;
        limbuff_valid_r       <= limbuff_valid;
        iter_valid_signal_r   <= iter_valid_signal;
        iter_output_enable_r  <= iter_output_enable;
        // iter_ready_r          <= out_ready;
        fir_data_r            <= fir_data; // TODO: data stall
        fir_valid_r           <= fir_valid;
        // fir_ready_r           <= out_ready & iter_output_enable;

        unique case(signal_case_r)
          INBOUND:
            // out_data_r  <= fir_data;
            out_data_r  <= fir_data_r;
          BELOW_MIN:
            // out_data_r  <= limbuff_data[15:0];
            out_data_r  <= limbuff_data_r[15:0];
          ABOVE_MAX:
            // out_data_r  <= limbuff_data[31:16];
            out_data_r  <= limbuff_data_r[31:16];
          INVALID:
            // out_data_r  <= fir_data;
            out_data_r  <= fir_data_r;
        endcase

        out_valid_r   <= fir_valid_r /*& iter_valid_signal_r*/& iter_output_enable & signal_case_r != INVALID;
        signal_case_r <= '{ above_max, below_min };
      end
    end
  end
  else
  begin
    assign iter_ready = out_ready;
    assign fir_ready  = out_ready & iter_output_enable;
    assign out_data   = ~reset & (signal_case_r == BELOW_MIN ? limbuff_data[15:0] :
                                                             (signal_case_r == ABOVE_MAX ? limbuff_data[31:16] : fir_data));
    assign out_valid  = ~reset & fir_valid & iter_valid_signal & signal_case_r != INVALID;

    /*
    reg  [15:0] out_data_r;
    reg         out_valid_r;

    assign iter_ready   = out_ready;
    assign fir_ready    = out_ready & iter_output_enable;
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

        out_valid = fir_valid & iter_valid_signal & signal_case != INVALID;
      end
    end
    */
  end
endgenerate

endmodule
