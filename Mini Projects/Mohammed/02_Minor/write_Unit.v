module write_Unit 
#(parameter S = 12, Depth = 8'b1001_0110 )(
  input wr_clk,
  input wr_en,
  input wr_rst,
  input [S-1:0] rd_ptr,
  output reg [S-1:0] wr_ptr,
  output reg fifo_full
);

  reg [7:0] Memory [0:Depth-1];

  always @(posedge wr_clk or posedge wr_rst) 
  begin
    if (wr_en) begin
      if (wr_rst) 
      begin
        Memory[wr_ptr] <= rd_ptr;
        wr_ptr <= wr_ptr + 1;
      end 
      else 
        begin
          fifo_full <= 1'b1;
        end
    end 
    else 
        begin
          fifo_full <= 1'b0;
        end
  end

endmodule