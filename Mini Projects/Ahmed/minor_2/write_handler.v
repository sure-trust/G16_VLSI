module wptr_full
#(
  parameter ADDRSIZE = 4
)
(
  input   wr_en, wr_clk, wr_rst,
  input   [ADDRSIZE :0] wq2_rptr,
  output reg  wfull,
  output  [ADDRSIZE-1:0] wr_addr,
  output reg [ADDRSIZE :0] wptr
);

   reg [ADDRSIZE:0] wbin;
  wire [ADDRSIZE:0] wgraynext, wbinnext;

  // GRAYSTYLE2 pointer
  always @(posedge wr_clk or posedge wr_rst)
    if (wr_rst)
      {wbin, wptr} <= 0;
    else
      {wbin, wptr} <= {wbinnext, wgraynext};

  // Memory write-address pointer (okay to use binary to address memory)
  assign wr_addr = wbin[ADDRSIZE-1:0];
  assign wbinnext = wbin + (wr_en & ~wfull);
  assign wgraynext = (wbinnext>>1) ^ wbinnext;


  assign wfull_val = (wgraynext=={~wq2_rptr[ADDRSIZE:ADDRSIZE-1], wq2_rptr[ADDRSIZE-2:0]});

  always @(posedge wr_clk or posedge wr_rst)
    if (wr_rst)
      wfull <= 1'b0;
    else
      wfull <= wfull_val;

endmodule
