module wrptr_h #(parameter PTR_WIDTH=3) (
  input wrclk, wrrst_n, wr_en,
  input [PTR_WIDTH:0] g_rdptr_sync,
  output reg [PTR_WIDTH:0] b_wrptr, g_wrptr,
  output reg fifo_full
);

  reg [PTR_WIDTH:0] b_wrptr_next;
  reg [PTR_WIDTH:0] g_wrptr_next;
   
  reg wrap_around;
  wire wrfull;
  
  assign b_wrptr_next = b_wrptr+(wr_en & !fifo_full);
  assign g_wrptr_next = (b_wrptr_next >>1)^b_wrptr_next;
  
  always@(posedge wrclk or negedge wrrst_n) begin
    if(!wrrst_n) begin
      b_wrptr <= 0; 
      g_wrptr <= 0;
    end
    else begin
      b_wrptr <= b_wrptr_next; 
      g_wrptr <= g_wrptr_next; 
    end
  end
  
  always@(posedge wrclk or negedge wrrst_n) begin
    if(!wrrst_n) fifo_full <= 0;
    else        fifo_full <= wrfull;
  end

  assign wrfull = (g_wrptr_next == {~g_rdptr_sync[PTR_WIDTH:PTR_WIDTH-1], g_rdptr_sync[PTR_WIDTH-2:0]});

endmodule