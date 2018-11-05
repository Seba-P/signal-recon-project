
interface avalon_st_footprint_if
(
  input reset,
  input clock
);

  wire [127:0] data;
  wire [  1:0] valid;
  wire         ready;
  wire  [ 1:0] error;
  wire         start_of_packet;
  wire         end_of_packet;

  modport sink
  (
  	input  data,
  	input  valid,
  	output ready,
  	output error,
  	input  start_of_packet,
  	input  end_of_packet
  );

  modport source
  (
  	input  data,
  	input  valid,
  	output ready,
  	output error,
  	input  start_of_packet,
  	input  end_of_packet
  );

endinterface : avalon_st_footprint_if
