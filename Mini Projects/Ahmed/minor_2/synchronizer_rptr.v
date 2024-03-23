//
// Read pointer to write clock synchronizer
//
module sync_r2w
#(
  parameter ADDRSIZE = 7
)
(
  input   wr_clk, wr_rst,
  input   [ADDRSIZE:0] rptr,
  output reg  [ADDRSIZE:0] wq2_rptr//readpointer with write side
);

  reg [ADDRSIZE:0] wq1_rptr;

  always @(posedge wr_clk or posedge wr_rst)
    if (wr_rst) {wq2_rptr,wq1_rptr} <= 0;
    else {wq2_rptr,wq1_rptr} <= {wq1_rptr,rptr};

endmodule
