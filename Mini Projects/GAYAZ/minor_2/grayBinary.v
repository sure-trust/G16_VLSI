module grayBinary#(parameter S =8)(
  input [S-1:0] grayIn,
  output [S-1:0] binaryOut
    );
    
    genvar i;
    generate
      for (i = S-1; i > 0; i=i-1)
    begin : xor_tag
        xor (binaryOut[i-1], binaryOut[i], grayIn[i-1]);
    end
    endgenerate
    
  assign binaryOut[S-1] = grayIn[S-1];
    
endmodule