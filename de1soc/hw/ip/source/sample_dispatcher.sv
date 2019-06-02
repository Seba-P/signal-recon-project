
module sample_dispatcher
(
  /* Common IF */
  input  wire        reset,
  input  wire        clock,
  /* SGDMA IF */
  input  wire [15:0] in_data,
  input  wire        in_valid,
  output wire        in_ready,
  /* Signal generator IF */
  output wire        sig_gen_cross_dir, // 1 -> upward, 0 -> downward
  output wire [14:0] sig_gen_duration,
  output wire        sig_gen_valid,
  input  wire        sig_gen_ready
);

typedef enum reg
{
  IDLE,
  PENDING
} state_t;

reg        in_ready_r;
reg        sig_gen_valid_r;
reg        sig_gen_cross_dir_r;
reg [14:0] sig_gen_duration_r;

state_t    sample_state_r;

assign in_ready           = in_ready_r;
assign sig_gen_cross_dir  = sig_gen_cross_dir_r;
assign sig_gen_duration   = sig_gen_duration_r;
assign sig_gen_valid      = sig_gen_valid_r;

/* SGDMA IF */
always_ff @(posedge clock)
begin
  if (reset)
  begin
    sample_state_r  <= IDLE;
    in_ready_r      <= '0;
  end
  else
  begin
    case (sample_state_r)
      IDLE:
      begin
        if (in_valid)
          sample_state_r <= PENDING;

        in_ready_r <= in_valid;
      end

      PENDING:
      begin
        if (sig_gen_valid & sig_gen_ready)
          sample_state_r <= IDLE;

        in_ready_r <= 'd0;
      end
    endcase
  end
end

/* Signal generator IF */
always_ff @(posedge clock)
begin
  if (reset)
  begin
    sig_gen_cross_dir_r <= '0;
    sig_gen_duration_r  <= '0;
    sig_gen_valid_r     <= '0;
  end
  else
  begin
    case (sample_state_r)
      IDLE:
      begin
        if (in_valid)
        begin
          sig_gen_cross_dir_r <= in_data[15];
          sig_gen_duration_r  <= in_data[14:0];
        end

        sig_gen_valid_r <= in_valid;
      end

      PENDING:
      begin
        sig_gen_valid_r <= !sig_gen_ready;
      end
    endcase
  end
end

endmodule
