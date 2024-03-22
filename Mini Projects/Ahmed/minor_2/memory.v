//
// FIFO memory
//
module fifomem
#(
  parameter DATASIZE = 8, // Memory data word width
  parameter ADDRSIZE = 7  // Number of mem address bits
)
(
  input   wr_en, wfull, wr_clk,
  input   [ADDRSIZE-1:0] wr_addr, rd_addr,
  input   [DATASIZE-1:0] wr_data,
  output  [DATASIZE-1:0] rd_data
);

  // RTL Verilog memory model
  localparam DEPTH = 1<<ADDRSIZE;//2*addsize

  reg [DATASIZE-1:0] mem [0:DEPTH-1];

  assign rd_data = mem[rd_addr];

  always @(posedge wr_clk)
    if (wr_en && !wfull)
      mem[wr_addr] <= wr_data;

endmodule
