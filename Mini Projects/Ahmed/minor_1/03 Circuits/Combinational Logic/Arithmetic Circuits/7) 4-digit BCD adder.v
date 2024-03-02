module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );

    reg [3:0]c;
    
    //Instantiating BCD adder modules.
    bcd_fadd U1(a[3:0], b[3:0], cin, c[0],sum[3:0]);
    bcd_fadd U2(a[7:4], b[7:4], c[0], c[1],sum[7:4]);
    bcd_fadd U3(a[11:8], b[11:8], c[1], c[2],sum[11:8]);
    bcd_fadd U4(a[15:12], b[15:12], c[2], c[3],sum[15:12]);
    
    assign cout = c[3];
    
endmodule