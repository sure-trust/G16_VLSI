module sync_w2r
#(
  parameter ADDRSIZE = 4
)
(
  input   rd_clk, rd_rst,
  input   [ADDRSIZE:0] wptr,
  output reg [ADDRSIZE:0] rq2_wptr
);

  reg [ADDRSIZE:0] rq1_wptr;

  always @(posedge rd_clk or posedge rd_rst)
    if (rd_rst)
      {rq2_wptr,rq1_wptr} <= 0;
    else
      {rq2_wptr,rq1_wptr} <= {rq1_wptr,wptr};

endmodule

