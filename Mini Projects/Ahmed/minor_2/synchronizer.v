module synchronizer
#(
  parameter ADDRSIZE = 3
)
(
  input   clk, rst,
  input   [ADDRSIZE:0] ptr,
  output reg  [ADDRSIZE:0] ptr_sync//synchronized pointer
);

  reg [ADDRSIZE:0] ptr1;

  always@(posedge clk) begin
    if(!rst) begin
      ptr1 <= 0;
      ptr_sync <= 0;
    end
    else begin
      ptr1 <= ptr;
      ptr_sync <= ptr1;
    end
  end

endmodule
