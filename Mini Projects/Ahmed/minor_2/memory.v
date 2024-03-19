module memory
#(
  parameter DATASIZE = 8, // Memory data word width
  parameter ADDRSIZE = 3,  // Number of mem address bits
  parameter DEPTH = 8
)
(
  input   wr_clk, wr_en, rd_clk, rd_en,
  input   [ADDRSIZE-1:0] wr_addr, rd_addr,
  input   [DATASIZE-1:0] wr_data,
  input	  wr_full, rd_empty,
  output  [DATASIZE-1:0] rd_data
);


  reg [DATASIZE-1:0] mem [0:DEPTH-1];

  assign rd_data = mem[rd_addr];

  always @(posedge wr_clk)
    if (wr_en && !wr_full)
      mem[wr_addr] <= wr_data;

endmodule


