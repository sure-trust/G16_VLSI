`include "synchronizer.v"
`include "write_handler.v"
`include "read_handler.v"
`include "memory.v"
// Code your design here
module Asynchronous_FIFO
#(
  parameter DATASIZE = 8,
  parameter DEPTH = 16
 )
(
    input wr_clk,        // Write clock (200MHz)
    input wr_rst,        // Write reset signal (active high)
    input rd_clk,        // Read clock (50MHz)
    input rd_rst,        // Read reset signal (active high)
    input wr_en,         // Write enable signal
    input rd_en,         // Read enable signal
    input [DATASIZE-1:0] wr_data, // Write data (8-bit)
    output reg [DATASIZE-1:0] rd_data, // Read data (8-bit)
    output reg o_fifo_full,   // FIFO full status output
    output reg o_fifo_empty   // FIFO empty status output
);
  parameter ADDRSIZE = $clog2(DEPTH);

  wire [ADDRSIZE-1:0] wr_addr, rd_addr;
  reg [ADDRSIZE:0] wr_ptr, rd_ptr, wq2_rptr, rq2_wptr;

  synchronizer #(ADDRSIZE) Write_pointer (rd_clk, rd_rst, wr_prt, rq2_wptr);
  
  synchronizer #(ADDRSIZE) read_pointer (wr_clk, wr_rst, rd_prt, wq2_rptr);
  
  write_handler #(ADDRSIZE)(wr_clk, wr_rst, wr_en, wq2_rptr, wr_addr, wr_ptr, o_fifo_full);
  
  read_handler #(ADDRSIZE) (rd_clk, rd_rst, rd_en, rq2_wptr, rd_addr, rd_ptr, o_fifo_empty);
    
  memory fifomem (wr_clk, wr_en, rd_clk, rd_en, wr_addr, rd_addr, wr_data, o_fifo_full, o_fifo_empty, rd_data);
  
endmodule