module async_fifo #(
    parameter DATA_WIDTH = 8,
    parameter FIFO_DEPTH = 90
) (
    input wire wr_clk,
    input wire wr_en,
    input wire [DATA_WIDTH-1:0] wr_data,
    input wire wr_rst,
    input wire rd_clk,
    input wire rd_en,
    output reg [DATA_WIDTH-1:0] rd_data,
    input wire rd_rst,
    output reg o_fifo_full,
    output reg o_fifo_empty
);

// FIFO memory
reg [DATA_WIDTH-1:0] fifo_mem [FIFO_DEPTH-1:0];

// Write pointer
reg [$clog2(FIFO_DEPTH)-1:0] wr_ptr;
wire wr_ptr_gray_next;

// Read pointer
reg [$clog2(FIFO_DEPTH)-1:0] rd_ptr;
wire rd_ptr_gray_next;

// Write synchronizer
wire [$clog2(FIFO_DEPTH)-1:0] wr_ptr_gray_sync;
wire [$clog2(FIFO_DEPTH)-1:0] rd_ptr_gray_sync;

// Full and empty signals
wire full;
wire empty;

// Write logic
always @(posedge wr_clk or posedge wr_rst) begin
    if (wr_rst) begin
        wr_ptr <= 0;
    end else if (wr_en && !full) begin
        fifo_mem[wr_ptr] <= wr_data;
        wr_ptr <= wr_ptr + 1;
    end
end

// Read logic
always @(posedge rd_clk or posedge rd_rst) begin
    if (rd_rst) begin
        rd_ptr <= 0;
    end else if (rd_en && !empty) begin
        rd_data <= fifo_mem[rd_ptr];
        rd_ptr <= rd_ptr + 1;
    end
end

// Pointer gray code conversion
assign wr_ptr_gray_next = (wr_ptr[3] ^ wr_ptr[2] ^ wr_ptr[1] ^ wr_ptr[0]);
assign rd_ptr_gray_next = (rd_ptr[3] ^ rd_ptr[2] ^ rd_ptr[1] ^ wr_ptr[0]);

// Pointer synchronizers
sync_signal #(.WIDTH($clog2(FIFO_DEPTH))) sync_wr_ptr (
    .clk(rd_clk),
    .data_in(wr_ptr_gray_next),
    .data_out(wr_ptr_gray_sync)
);

sync_signal #(.WIDTH($clog2(FIFO_DEPTH))) sync_rd_ptr (
    .clk(wr_clk),
    .data_in(rd_ptr_gray_next),
    .data_out(rd_ptr_gray_sync)
);

// Full and empty logic
assign full = (wr_ptr_gray_sync[$clog2(FIFO_DEPTH)-1] != rd_ptr_gray_sync[$clog2(FIFO_DEPTH)-1]) &&
              (wr_ptr_gray_sync[$clog2(FIFO_DEPTH)-2:0] == rd_ptr_gray_sync[$clog2(FIFO_DEPTH)-2:0]);

assign empty = (wr_ptr_gray_sync[$clog2(FIFO_DEPTH)-1] == rd_ptr_gray_sync[$clog2(FIFO_DEPTH)-1]) &&
               (wr_ptr_gray_sync[$clog2(FIFO_DEPTH)-2:0] == rd_ptr_gray_sync[$clog2(FIFO_DEPTH)-2:0]);

always @(*) begin
    o_fifo_full = full;
    o_fifo_empty = empty;
end

endmodule

module sync_signal #(
    parameter WIDTH = 8
) (
    input wire clk,
    input wire [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out
);

reg [WIDTH-1:0] sync_stage1;
reg [WIDTH-1:0] sync_stage2;

//we're using synchronoizers to avoid the metastable state

always @(posedge clk) begin
    sync_stage1 <= data_in; 
    sync_stage2 <= sync_stage1;//metastable state
    data_out <= sync_stage2;//leads to fixed value of 1 
end

endmodule