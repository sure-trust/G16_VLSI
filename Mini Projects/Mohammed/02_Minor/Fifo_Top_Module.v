module Fifo_Top_Module 
#(parameter S = 8)(
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
    .o_fifo_full(o_fifo_full)
);

read_Unit uutRead_Unit(
    .rd_clk(rd_clk),
    .rd_en(rd_en),
    .rd_rst(rd_rst),
    .wr_ptr(wr_ptrG2B),
    .rd_ptr(rd_ptr),
    .o_fifo_empty(o_fifo_empty)      
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