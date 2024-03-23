module Binary2Gray
# (parameter S = 8) (
input [S-1:0] binary_in,
output [S-1:0] gray_out
);

genvar i;
wire xor_out;

for (genvar i = S-1; i > 0; i = i - 1)
begin
    xor xor_tag (xor_out, binary_in[i], binary_in[i-1]);
    assign gray_out[i-1] = xor_out;
end

assign gray_out[S-1] = binary_in[S-1];

endmodule