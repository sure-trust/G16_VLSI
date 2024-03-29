module top_module (
    input wire clk,
    input wire [7:0] in,
    output reg [7:0] pedge
);

    reg [7:0]prev_in;
    always @(posedge clk) 
        begin      
        for(int i=0;i<8;i=i+1) 
            begin
            if(in[i]==1&&prev_in[i]==0) 
                begin            
                pedge[i]<=1;
            end
            else 
                begin
                pedge[i]<=0;
            end
        end        
        prev_in<=in;
    end
endmodule
