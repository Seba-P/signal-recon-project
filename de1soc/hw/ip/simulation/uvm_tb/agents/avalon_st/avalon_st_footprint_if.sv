
interface avalon_st_footprint_if
(
  input reset,
  input clock
);

  wire [ 127:0] channel;
  wire [4095:0] data;
  wire [ 255:0] error;
  wire          ready;
  wire          valid;
  wire [   4:0] empty;
  wire          start_of_packet;
  wire          end_of_packet;

  modport sink
  (
    input  channel,
    input  data,
    input  error,
    output ready,
    input  valid,
    input  empty,
    input  start_of_packet,
    input  end_of_packet
  );

  modport source
  (
    output channel,
    output data,
    output error,
    input  ready,
    output valid,
    output empty,
    output start_of_packet,
    output end_of_packet
  );

endinterface : avalon_st_footprint_if
