`include "synchronizer.sv"
`include "wrptr.sv"
`include "rdptr.sv"
`include "fifo_mem.sv"
module asynchronous_fifo #(parameter DEPTH=8, DATA_WIDTH=8) (
  input wrclk, wrrst_n,
  input rdclk, rdrst_n,
  input wr_en, rd_en,
  input [DATA_WIDTH-1:0] data_in,
  output reg [DATA_WIDTH-1:0] data_out,
  output reg fifo_full, fifo_empty
);
  parameter PTR_WIDTH = $clog2(DEPTH);
  reg [PTR_WIDTH:0] g_wrptr_sync, g_rdptr_sync;
  reg [PTR_WIDTH:0] b_wrptr, b_rdptr;
  reg [PTR_WIDTH:0] g_wrptr, g_rdptr;
  wire [PTR_WIDTH-1:0] waddr, raddr;
  synchronizer #(PTR_WIDTH) sync_wrptr (rdclk, rdrst_n, g_wrptr, g_wrptr_sync); 
  synchronizer #(PTR_WIDTH) sync_rdptr (wrclk, wrrst_n, g_rdptr, g_rdptr_sync);   
  wrptr_h #(PTR_WIDTH) wrptr_h(wrclk, wrrst_n, wr_en,g_rdptr_sync,b_wrptr,g_wrptr,fifo_full);
  rdptr_h #(PTR_WIDTH) rdptr_h(rdclk, rdrst_n, rd_en,g_wrptr_sync,b_rdptr,g_rdptr,fifo_empty);
  fifo_mem fifom(wrclk, wr_en, rdclk, rd_en,b_wrptr, b_rdptr, data_in,fifo_full,fifo_empty, data_out);
endmodule