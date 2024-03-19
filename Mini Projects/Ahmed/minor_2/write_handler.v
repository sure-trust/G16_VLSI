module write_handler#(
  parameter ADDRSIZE = 6
)
(
  input   wr_clk, wr_rst, wr_en, 
  input   [ADDRSIZE :0] wq2_rptr,
  output reg [ADDRSIZE:0] wr_addr, wr_ptr,
  output reg  wr_full
);

  wire [ADDRSIZE:0] wr_graynext, wr_binnext;
  reg wrap_around;
  wire wr_full_val;

  // Memory write-address pointer
  //assign wr_addr = wr_bin[ADDRSIZE-1:0];
  assign wr_binnext = wr_addr + (wr_en & ~wr_full);
  assign wr_graynext = (wr_binnext>>1) ^ wr_binnext;// binary to gray conversion

  // Next Pointer State;
  always @(posedge wr_clk or negedge wr_rst) begin
    if (!wr_rst)begin
      wr_addr<= 0;
      wr_ptr <= 0;
      end
    else begin
      wr_addr <= wr_binnext; 
      wr_ptr <= wr_graynext; 
    end
  end

//Logic for FIFO full
  assign wr_full_val = (wr_graynext=={~wq2_rptr[ADDRSIZE:ADDRSIZE-1], wq2_rptr[ADDRSIZE-2:0]});

  always @(posedge wr_clk or negedge wr_rst)
    if (!wr_rst)
      wr_full <= 1'b0;
    else
      wr_full <= wr_full_val;

endmodule
