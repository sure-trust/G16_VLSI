module fifo_mem #(parameter DEPTH=8, DATA_WIDTH=8, PTR_WIDTH=3) (
  input wrclk, wr_en, rdclk, rd_en,
  input [PTR_WIDTH:0] b_wrptr, b_rdptr,
  input [DATA_WIDTH-1:0] data_in,
  input fifo_full, fifo_empty,
  output reg [DATA_WIDTH-1:0] data_out
);
  reg [DATA_WIDTH-1:0] fifo[0:DEPTH-1];
  
  always@(posedge wrclk) begin
    if(wr_en & !fifo_full) begin
      fifo[b_wrptr[PTR_WIDTH-1:0]] <= data_in;
    end
  end
  assign data_out = fifo[b_rdptr[PTR_WIDTH-1:0]];
endmodule