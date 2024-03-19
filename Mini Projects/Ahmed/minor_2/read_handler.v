module read_handler
#(
  parameter ADDRSIZE = 6
)
(
  input   rd_clk, rd_rst, rd_en, 
  input   [ADDRSIZE :0] rq2_wptr,
  output reg [ADDRSIZE:0] rd_addr, rd_ptr,
  output reg  rd_empty
);

  wire [ADDRSIZE:0] rd_graynext, rd_binnext;

  // Memory read-address pointer
  
  assign b_rptr_next = rd_addr+(rd_en & !rd_empty);
  assign rd_graynext = (rd_binnext>>1) ^ rd_binnext;
  assign rd_empty_val = (rd_graynext == rq2_wptr);
 
  always @(posedge rd_clk or negedge rd_rst) begin
    if (!rd_rst) begin
      rd_addr <= 0;
      rd_ptr <= 0;
      end
  	 else begin
      rd_addr <= rd_binnext;
      rd_ptr <= rd_graynext;
    end
  end


  always @(posedge rd_clk or negedge rd_rst)
    if (!rd_rst)
      rd_empty <= 1'b1;
    else
      rd_empty <= rd_empty_val;

endmodule
