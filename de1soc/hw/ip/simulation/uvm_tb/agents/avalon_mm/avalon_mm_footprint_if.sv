
interface avalon_mm_footprint_if
(
  input reset,
  input clock
);

  wire [  63:0] address;
  wire [ 127:0] byteenable;
  wire          debugaccess;
  wire          read;
  wire [1023:0] readdata;
  wire [   1:0] response;
  wire          write;
  wire [1023:0] writedata;
  wire          lock;
  wire          waitrequest;
  wire          readdatavalid;
  wire          writeresponsevalid;
  wire [  10:0] burstcount;
  wire          beginbursttransfer;

  modport slave
  (
  	input  address,
    input  byteenable,
    input  debugaccess,
    input  read,
    output readdata,
    output response,
    input  write,
    input  writedata,
    input  lock,
    output waitrequest,
    output readdatavalid,
    output writeresponsevalid,
    input  burstcount,
    input  beginbursttransfer
  );

  modport master
  (
    output address,
    output byteenable,
    output debugaccess,
    output read,
    input  readdata,
    input  response,
    output write,
    output writedata,
    output lock,
    input  waitrequest,
    input  readdatavalid,
    input  writeresponsevalid,
    output burstcount,
    output beginbursttransfer
  );

endinterface : avalon_mm_footprint_if
