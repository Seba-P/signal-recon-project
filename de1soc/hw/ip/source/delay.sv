module delay
#(
  parameter DELAY     = 1,
  parameter WIDTH     = 1,
  parameter RESET     = 1, // '0' - don't support reset
  parameter RESET_VAL = { WIDTH{ 1'b0 } },
  parameter RAMSTYLE  = "logic"
)
(
  input  wire             clock,
  input  wire             reset,
  
  input  wire [WIDTH-1:0] in_data,
  output wire [WIDTH-1:0] out_data
);

(* ramstyle = RAMSTYLE *) reg [WIDTH-1:0] delay_line[DELAY];
integer del;

generate 
  if(DELAY == 0) 
  begin
    assign out_data = in_data;
  end
  else if(RESET)
  begin
    always_ff @(posedge clock)
    begin
        if(reset)
        begin
          for(del = 0; del < DELAY; del++)
            delay_line[del] <= RESET_VAL;
        end
        else
        begin
          delay_line[0] <= in_data;

          for(del = 1; del < DELAY; del++)
            delay_line[del] <= delay_line[del-1];
        end
    end
          
    assign out_data = delay_line[DELAY-1];
  end
  else
  begin
    always_ff @(posedge clock)
    begin
      delay_line[0] <= in_data;

      for(del = 1; del < DELAY; del++)
        delay_line[del] <= delay_line[del-1];
    end
          
    assign out_data = delay_line[DELAY-1];
  end
endgenerate

endmodule
