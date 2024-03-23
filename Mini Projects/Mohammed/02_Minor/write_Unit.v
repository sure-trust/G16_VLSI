module write_Unit 
#(parameter S = 12, Depth = 8'b1001_0110 )(
  input wr_clk,
  input wr_en,
  input wr_rst,
  input [S-1:0] rd_ptr,
  output reg [S-1:0] wr_ptr,
  output reg o_fifo_full
);

reg [S-1:0]counter;
    
always @ (posedge wr_clk or posedge wr_rst)
begin
    if (wr_rst)
        counter <= 0;
    else if (!wr_rst && wr_en && !o_fifo_full && (counter[S-2:0] < Depth-1))
    begin
        counter[S-2:0] <= counter[S-2:0] + 1;
        counter[S-1] <= counter[S-1];
    end
    else if (!wr_rst && wr_en && !o_fifo_full && (counter[S-2:0] == Depth-1))
    begin
        counter[S-2:0] <= 0;
        counter[S-1] <= ~counter[S-1];
    end
    else
        counter <= counter;
end

always @ (*)
begin
    if ((wr_ptr[S-1] != rd_ptr[S-1]) && (wr_ptr[S-2:0] == rd_ptr[S-2:0]))
        o_fifo_full = 1'b1;
    else
        o_fifo_full = 1'b0;
end

assign wr_ptr = counter;

endmodule