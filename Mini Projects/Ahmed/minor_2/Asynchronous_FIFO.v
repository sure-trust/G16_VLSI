module Asynchronous_fifo (
    input wire wr_clk,        // Write clock (200MHz)
    input wire wr_en,         // Write enable signal
    input wire [7:0] wr_data, // Write data (8-bit)
    input wire wr_rst,        // Write reset signal (active high)
    input wire rd_clk,        // Read clock (50MHz)
    input wire rd_en,         // Read enable signal
    output reg [7:0] rd_data, // Read data (8-bit)
    input wire rd_rst,        // Read reset signal (active high)
    output reg o_fifo_full,   // FIFO full status output
    output reg o_fifo_empty   // FIFO empty status output
);

// Parameters
parameter DEPTH = 90; // Depth of the FIFO

// Internal signals
reg [7:0] mem [0:DEPTH-1]; // FIFO memory
reg [6:0] wr_addr, rd_addr;  // Write and read address
reg [6:0] wr_ptr, rd_ptr; // Write and read pointers
reg [6:0] wq2_rptr, rq2_wptr; // Synchronized Write and read pointers
reg [6:0] temp_wr_ptr, temp_rd_ptr; //temporary Write and read pointers

//Synchronization of read pointers
always@(posedge wr_clk) begin
    if(wr_rst) begin
      wq2_rptr <= 0;
    end
    else begin
      temp_rd_ptr <= rd_ptr;
      wq2_rptr <= temp_rd_ptr;
    end
  end

//Synchronization of write pointers
always@(posedge rd_clk) begin
    if(rd_rst) begin
      rq2_wptr <= 0;
    end
    else begin
       temp_wr_ptr<= wr_ptr;
      wq2_rptr <= temp_wr_ptr;
    end
  end

// Write process
always @(posedge wr_clk or posedge wr_rst) begin
    if (wr_rst) begin
        wr_ptr <= 0;
    end else if (wr_en && !o_fifo_full) begin
        mem[wr_addr] <= wr_data;
    end
end

// Read process
always @(posedge rd_clk or posedge rd_rst) begin
    if (rd_rst) begin
        rd_ptr <= 0;
    end else if (rd_en && !o_fifo_empty) begin
        rd_data <= mem[rd_addr];
    end
end

// Write pointer handler
  wire [6:0] waddr_next;
  wire [6:0] wptr_next;
  
  assign waddr_next = wr_addr+(wr_en & !o_fifo_full);
  assign wptr_next = (waddr_next >>1)^waddr_next; //binary to gray conversion
  
  always@(posedge wr_clk, wr_rst) begin
    if(wr_rst) begin
      wr_addr <= 0; // set default value
      wr_ptr <= 0;
    end
    else begin
      wr_addr <= waddr_next;
      wr_ptr <= wptr_next;
    end
  end

// Read pointer handler

  wire [6:0] raddr_next;
  wire [6:0] rptr_next;

  assign raddr_next = rd_addr+(rd_en & !o_fifo_empty);
  assign rptr_next = (raddr_next >>1)^raddr_next;//binary to gray conversion
  
  always@(posedge rd_clk , rd_rst) begin
    if(rd_rst) begin
      rd_addr <= 0;
      rd_ptr <= 0;
    end
    else begin
      rd_addr <= raddr_next;
      rd_ptr <= rptr_next;
    end
  end
  
//Empty FIFO logic 
  always@(posedge rd_clk ,rd_rst) begin
    if(rd_rst) o_fifo_empty <= 1;
    else        o_fifo_empty <= (rq2_wptr == rptr_next);
  end

//Full FIFO logic 
  always@(posedge wr_clk , wr_rst) begin
    if(wr_rst) o_fifo_full <= 0;
    else       o_fifo_full <= (wptr_next == {~wq2_rptr[6:5], wq2_rptr[4:0]});
  end

endmodule