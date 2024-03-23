module Gray2Binary
# (parameter S = 8) (
input [S-1:0] gray_in,
output [S-1:0] binary_out
);

genvar i;
wire xor_out1;

for (genvar i = S-1; i > 0; i = i - 1)
begin
    xor xor_tag (xor_out1, binary_out[i], gray_in[i-1]);
    assign binary_out[i-1] = xor_out1;
end

assign binary_out[S-1] = gray_in[S-1];

endmodule