module binaryGray #(parameter S = 8)(
  input [S-1:0] binaryIn,
  output [S-1:0] grayOut
    );
    
    genvar i;
    generate
      for (i = S-1; i > 0; i=i-1)
    begin : xor_tag
        xor (grayOut[i-1], binaryIn[i], binaryIn[i-1]);
    end
    endgenerate
    
  assign grayOut[S-1] = binaryIn[S-1];
    
endmodule