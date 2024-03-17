module read_Unit 
#(parameter S = 12, Depth = 8'b1001_0110 )(
  input rd_clk,
  input rd_en,
  input rd_rst,
  input [S-1:0] wr_ptr,
  output reg [S-1:0] rd_ptr,
  output reg fifo_empty
);

  reg [7:0] Memory[0:Depth-1];
  reg write_ptr;
  always @(posedge rd_clk or posedge rd_rst)
   begin
    if (rd_en) begin
      if (rd_rst) 
        begin
          rd_ptr <= Memory[wr_ptr];
           write_ptr <= wr_ptr + 1;
        end 
      else 
        begin
          fifo_empty <= 1'b1;
        end
    end 
     else 
        begin
           fifo_empty <= 1'b0;
        end
  end

    assign wr_ptr = write_ptr;
endmodule