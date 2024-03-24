module writeUnit #(parameter N = 16, depth = 8'b0101_1010_)(
        input wrclk,
        input wren,
        input wrrst,
  		input [S-1:0]rdPtr,
  		output [S-1:0]wrPtr,
        output reg full
    );
    
    // Since we are designing a FIFO, we take an extra bit address full/empty functionality
    
  reg [S-1:0]count;
    
  always @ (posedge wrclk or posedge wrrst)
    begin
      if (wrrst)
          count <= 0;
      else if (!wrrst && wren && !full && (count[S-2:0] < depth-1))
        begin
          count[S-2:0] <= count[S-2:0] + 1;
          count[S-1] <= count[S-1];
        end
      else if (!wrrst && wren && !full && (count[S-2:0] == depth-1))
        begin
          count[S-2:0] <= 0;
          count[S-1] <= ~count[S-1];
        end
        else
            count <= count;
    end
    
    always @ (*)
    begin
      if ((wrptr[S-1] != rdptr[S-1]) && (wrptr[S-2:0] == rdptr[S-2:0]))
            full = 1'b1;
        else
            full = 1'b0;
    end
    
    assign wrptr = count;
    
endmodule