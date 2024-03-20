module rptr_empty
#(
  parameter ADDRSIZE = 4
)
(
  input   rd_en, rd_clk, rd_rst,
  input   [ADDRSIZE :0] rq2_wptr,
  output reg  rempty,
  output  [ADDRSIZE-1:0] raddr,
  output reg [ADDRSIZE :0] rptr
);

  reg [ADDRSIZE:0] rbin;
  wire [ADDRSIZE:0] rgraynext, rbinnext;


  always @(posedge rd_clk or posedge rd_rst)
    if (rd_rst)
      {rbin, rptr} <= 0;
    else
      {rbin, rptr} <= {rbinnext, rgraynext};

  // Memory read-address pointer (okay to use binary to address memory)
  assign raddr = rbin[ADDRSIZE-1:0];
  assign rbinnext = rbin + (rd_en & ~rempty);
  assign rgraynext = (rbinnext>>1) ^ rbinnext;

  assign rempty_val = (rgraynext == rq2_wptr);

  always @(posedge rd_clk or posedge rd_rst)
    if (rd_rst)
      rempty <= 1'b1;
    else
      rempty <= rempty_val;

endmodule
