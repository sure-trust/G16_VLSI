module READ#(parameter S = 8, depth = S'b0101_1010)(
        input rdclk,
        input rden,
        input rdrst,
  		input [S-1:0] wrPtr,
  		output [S-1:0]rdPtr,
        output reg empty      
    );
    
    
    reg [N-1:0]count;
    
  always @ (posedge rdclk or posedge rdrst)
    begin
      if (rdrst)
            count <= 0;
      else if (!rdrst && rden && !empty && (count[S-2:0] < depth-1))
        begin
          count[S-2:0] <= count[S-2:0] + 1;
          count[S-1] <= count[S-1];
        end
      else if(!rdrst && rden && !empty && (count[S-2:0] == depth-1))
        begin
          count[S-2:0] <= 0;
          count[S-1] <= ~count[S-1];
        end
        else
            count <= count;
    end
    
    always @ (*)
    begin
      if ((wrptr[S-1] == rdptr[S-1]) && (wrptr[S-2:0] == rdptr[S-2:0]))
            empty = 1'b1;
        else
            empty = 1'b0;
    end
    
    assign rdptr = count;
    
endmodule