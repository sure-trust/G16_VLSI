module dualFlopSynchronizer#(parameter S = 8)(
  input [S-1:0] dataIn,
  output reg [S-1:0] dataOut,
    input clk,
    input rst
    );
    
  reg [S-1:0] meme;
    
    always @ (posedge clk or posedge rst)
    begin
        if (rst == 1'b1)
        begin
            meme <= 0;
            dataOut <= 0;
        end
        else
        begin
            meme <= dataIn;
            dataOut <= meme;
        end 
    end
endmodule