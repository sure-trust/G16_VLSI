module read_Unit 
#(parameter S = 8, Depth = 8'b1001_0110 )(
  input rd_clk,
  input rd_en,
  input rd_rst,
  input [S-1:0] wr_ptr,
  output reg [S-1:0] rd_ptr,
  output reg o_fifo_empty
);

reg [S-1:0]counter;
    
always @ (posedge rd_clk or posedge rd_rst)
begin
    if (rd_rst)
        counter <= 0;
    else if (!rd_rst && rd_en && !o_fifo_empty && (counter[S-2:0] < Depth-1))
    begin
        counter[S-2:0] <= counter[S-2:0] + 1;
        counter[S-1] <= counter[S-1];
    end
    else if (!rd_rst && rd_en && !o_fifo_empty && (counter[S-2:0] == Depth-1))
    begin
        counter[S-2:0] <= 0;
        counter[S-1] <= ~counter[S-1];
    end
    else
        counter <= counter;
end

always @ (*)
begin
    if ((wr_ptr[S-1] == rd_ptr[S-1]) && (wr_ptr[S-2:0] == rd_ptr[S-2:0]))
        o_fifo_empty = 1'b1;
    else
        o_fifo_empty = 1'b0;
end

assign rd_ptr = counter;

endmodule