module top_module (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output [3:0] q );
    
    assign q=(c==4'd0)?b:(c==4'd1)?e:(c==4'd2)?a:(c==4'd3)?d:4'hf;
        
        
endmodule
