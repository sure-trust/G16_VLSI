module fifoMemory#(parameter S = 8, depth = 8'b0101_1010)(
  input wrclk,
  input rdclk,
  input [S-1:0] wrptr,
  input [S-1:0] rdptr,
  input wren,          
  input [7:0] wrdata,
  output reg [7:0] rddata
    );
    
    // Declaring memory
  reg [7:0] MEM [0:depth-1];
    
    //
  always @ (posedge wrclk)
    begin
      if (wren)
        MEM [wrptr] <= wrdata;
        else
          MEM [wrptr] <= MEM [wrptr];
    end
    
  always @ (posedge rdclk)
    begin
      rddata <= MEM[rdptr];
    end
    
endmodule