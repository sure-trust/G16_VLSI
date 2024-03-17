module rdptr_h #(parameter PTR_WIDTH=3) (
  input rdclk, rdrst_n, rd_en,
  input [PTR_WIDTH:0] g_wrptr_sync,
  output reg [PTR_WIDTH:0] b_rdptr, g_rdptr,
  output reg fifo_empty
);

  reg [PTR_WIDTH:0] b_rdptr_next;
  reg [PTR_WIDTH:0] g_rdptr_next;

  assign b_rdptr_next = b_rdptr+(rd_en & !fifo_empty);
  assign g_rdptr_next = (b_rdptr_next >>1)^b_rdptr_next;
  assign rdempty = (g_wrptr_sync == g_rdptr_next);
  
  always@(posedge rdclk or negedge rdrst_n) begin
    if(!rdrst_n) begin
      b_rdptr <= 0;
      g_rdptr <= 0;
    end
    else begin
      b_rdptr <= b_rdptr_next;
      g_rdptr <= g_rdptr_next;
    end
  end
  
  always@(posedge rdclk or negedge rdrst_n) begin
    if(!rdrst_n) fifo_empty <= 1;
    else        fifo_empty <= rdempty;
  end
endmodule