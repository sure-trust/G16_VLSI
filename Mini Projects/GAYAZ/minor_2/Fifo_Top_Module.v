module Fifo_Top_Module 
#(parameter S = 12)(
    input wr_clk,
    input rd_clk,
    input wr_rst,
    input rd_rst,
    input wr_en,
    input rd_en,
    input [7:0] wr_data,
    output [7:0] rd_data,
    output o_fifo_full,
    output o_fifo_empty
);

wire wr_EnDer;
wire [S-1:0] wr_ptr;
wire [S-1:0] wr_ptrB2G;
wire [S-1:0] rd_ptrDualFlopSyncOut;
wire [S-1:0] rd_ptr;
wire [S-1:0] wr_ptrG2B;
wire [S-1:0] wr_ptrDualFlopSyncOut;
wire [S-1:0] rd_ptrB2G;
wire [S-1:0] rd_ptrG2B;

Fifo_Memory uutFifo_Memory (
    .wr_clk(wr_clk),
    .rd_clk(rd_clk),
    .wr_ptr(wr_ptr),
    .rd_ptr(rd_ptr),
    .wr_en(wr_EnDer),
    .wr_data(wr_data),
    .rd_data(rd_data)
);

assign wr_EnDer = wr_en & ~o_fifo_full;

write_Unit uutWrite_Unit(
    .wr_clk(wr_clk),
    .wr_en(wr_en),
    .wr_rst(wr_rst),
    .rd_ptr(rd_ptrG2B),
    .wr_ptr(wr_ptr),
    .fifo_full(o_fifo_full)
);

read_Unit uutRead_Unit(
    .rd_clk(rd_clk),
    .rd_en(rd_en),
    .rd_rst(rd_rst),
    .wr_ptr(wr_ptrG2B),
    .rd_ptr(rd_ptr),
    .fifo_empty(o_fifo_empty)      
);

Binary2Gray uutBinary2GrayWrite (
    .binary_in(wr_ptr),
    .gray_out(wr_ptrB2G)
);

Dual_flop_sync uutDual_Flop_SyncWrite(
    .data_in(wr_ptrB2G),
    .data_out(wr_ptrDualFlopSyncOut),
    .clk(rd_clk),
    .rst(rd_rst)
);

Gray2Binary uutGray2BinaryWrite(
    .gray_in(wr_ptrDualFlopSyncOut),
    .binary_out(wr_ptrG2B)
);

Binary2Gray uutBinary2GrayRead (
    .binary_in(rd_ptr),
    .gray_out(rd_ptrB2G)
);

Dual_flop_sync uutDual_Flop_SyncRead(
    .data_in(rd_ptrB2G),
    .data_out(rd_ptrDualFlopSyncOut),
    .clk(wr_clk),
    .rst(wr_rst)
);

Gray2Binary uutGray2BinaryRead(
    .gray_in(rd_ptrDualFlopSyncOut),
    .binary_out(rd_ptrG2B)
);

endmodule

module Dual_flop_sync 
//Set Parameter 
#( parameter S = 12)(
    input clk,
    input rst,
    input [S-1:0] data_in,
    output reg [S-1:0] data_out
);


reg [S-1:0] Connection;

always @ (posedge clk or posedge rst)
begin
    if (rst == 1'b1)
    begin
        Connection <= 0;
        data_out <= 0;
    end
    else
        begin
            Connection <= data_in;
            data_out <= Connection;
        end

end
endmodule

module Fifo_Memory
//Set Fifo Depth 90 and Fifo Width 8 and Fifo Size = 90/8 = 12
#(parameter S = 12, Depth = 8'b1001_0110)(
        input wr_clk,
        input rd_clk,
        input [S-1:0] wr_ptr,
        input [S-1:0] rd_ptr,
        input wr_en,
        input [7:0] wr_data,
        output reg [7:0] rd_data
    );
    
    // Memory Declaration
    reg [7:0] Memory [0:Depth-1];
    
    always @ (posedge wr_clk)
    begin
        if (wr_en)
            Memory [wr_ptr] <= wr_data;
        else
            Memory [wr_ptr] <= Memory[wr_ptr];
    end

    //Ouput storing in Read Data 
    always @ (posedge rd_clk)
    begin
        rd_data <= Memory[rd_ptr];
    end
    
endmodule

module Binary2Gray
# (parameter S = 12) (
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

module Gray2Binary
# (parameter S = 12) (
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

module read_Unit 
#(parameter S = 12, Depth = 8'b1001_0110 )(
  input rd_clk,
  input rd_en,
  input rd_rst,
  input [S-1:0] wr_ptr,
  output reg [S-1:0] rd_ptr,
  output reg fifo_empty
);

  reg [7:0] Memory[0:Depth-1];
  reg write_ptr;
  always @(posedge rd_clk or posedge rd_rst)
   begin
    if (rd_en) begin
      if (rd_rst) 
        begin
          rd_ptr <= Memory[wr_ptr];
           write_ptr <= wr_ptr + 1;
        end 
      else 
        begin
          fifo_empty <= 1'b1;
        end
    end 
     else 
        begin
           fifo_empty <= 1'b0;
        end
  end

    assign wr_ptr = write_ptr;
endmodule

module write_Unit 
#(parameter S = 12, Depth = 8'b1001_0110 )(
  input wr_clk,
  input wr_en,
  input wr_rst,
  input [S-1:0] rd_ptr,
  output reg [S-1:0] wr_ptr,
  output reg fifo_full
);

  reg [7:0] Memory [0:Depth-1];

  always @(posedge wr_clk or posedge wr_rst) 
  begin
    if (wr_en) begin
      if (wr_rst) 
      begin
        Memory[wr_ptr] <= rd_ptr;
        wr_ptr <= wr_ptr + 1;
      end 
      else 
        begin
          fifo_full <= 1'b1;
        end
    end 
    else 
        begin
          fifo_full <= 1'b0;
        end
  end

endmodule