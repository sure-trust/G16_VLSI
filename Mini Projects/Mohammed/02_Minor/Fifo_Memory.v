module Fifo_Memory
//Set Fifo Depth 90 and Fifo Width 8 and Fifo Size = 90/8 = 12
#(parameter S = 8, Depth = 8'b1001_0110)(
        input wr_clk,
        input rd_clk,
        input [S-1:0] wr_ptr,
        input [S-1:0] rd_ptr,
        input wr_en,
        input [7:0] wr_data,
        output reg [7:0] rd_data
    );
    
    // Memory Declaration
    reg [7:0] Memory [0:Depth-1];
    
    always @ (posedge wr_clk)
    begin
        if (wr_en)
            Memory [wr_ptr] <= wr_data;
        else
            Memory [wr_ptr] <= Memory[wr_ptr];
    end

    //Ouput storing in Read Data 
    always @ (posedge rd_clk)
    begin
        rd_data <= Memory[rd_ptr];
    end
    
endmodule