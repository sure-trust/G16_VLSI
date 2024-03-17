module synchronizer #(parameter WIDTH=3) (input clk, rst, [WIDTH:0] data_in, output reg [WIDTH:0] data_out);
  reg [WIDTH:0] p;
  always@(posedge clk) begin
    if(rst) begin
      p <= 0;
      data_out <= 0;
    end
    else begin
      p <= data_in;
      d_out <= p;
    end
  end
endmodule