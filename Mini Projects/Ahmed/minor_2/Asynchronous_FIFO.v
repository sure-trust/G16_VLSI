`include "read_handler.v"
`include "write_handler.v"
`include "memory.v"
`include "synchronizer_rptr.v"
`include "synchronizer_wptr.v"
// Top level wrapper
//
module Asynchronous_FIFO
#(
  parameter DSIZE = 8,
  parameter ASIZE = 4
 )
(
  input   wr_en, wr_clk, wr_rst,//wr_en write enable signal
  input   rd_en, rd_clk, rd_rst,//rd_en read enable signal
  input   [DSIZE-1:0] wr_data,

  output  [DSIZE-1:0] rd_data,
  output  o_fifo_full,
  output  o_fifo_empty
);

  wire [ASIZE-1:0] waddr, raddr;
  wire [ASIZE:0] wptr, rptr, wq2_rptr, rq2_wptr;

  synchronizer_rptr (wr_clk, wr_rst, rptr, wq2_rptr);
  synchronizer_wptr (rd_clk, rd_rst, wptr, rq2_wptr);
  memory #(DSIZE, ASIZE) FIFO_Memory (wr_en, o_fifo_full, wr_clk, waddr, raddr, wr_data, rd_data);
  read_handler #(ASIZE) Read_handler (rd_en, rd_clk, rd_rst, rq2_wptr, o_fifo_empty, raddr, rptr);
  write_handler #(ASIZE) Write_handler (wr_en, wr_clk, wr_rst, wq2_rptr, o_fifo_full, waddr, wptr);

endmodule
