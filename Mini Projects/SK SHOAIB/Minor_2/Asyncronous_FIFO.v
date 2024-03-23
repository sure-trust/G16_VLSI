module asynchronous_fifo #(parameter DEPTH=16, DATA_WIDTH=8) (
  input wrclk, wrrst_n,
  input rdclk, rdrst_n,
  input wr_en, rd_en,
  input [DATA_WIDTH-1:0] data_in,
  output reg [DATA_WIDTH-1:0] data_out,
  output reg fifo_full, 
  output reg fifo_empty
);
  parameter PTR_WIDTH = $clog2(DEPTH);
  reg [PTR_WIDTH:0] g_wrptr_sync, g_rdptr_sync;
  reg [PTR_WIDTH:0] b_wrptr, b_rdptr;
  reg [PTR_WIDTH:0] g_wrptr, g_rdptr;
  wire [PTR_WIDTH-1:0] waddr, raddr;
  dffsynchronizer #(PTR_WIDTH) sync_wrptr (rdclk, rdrst_n, g_wrptr, g_wrptr_sync); 
  dffsynchronizer #(PTR_WIDTH) sync_rdptr (wrclk, wrrst_n, g_rdptr, g_rdptr_sync);   
  wrptr_h #(PTR_WIDTH) wrptr_h(wrclk, wrrst_n, wr_en,g_rdptr_sync,b_wrptr,g_wrptr,fifo_full);
  rdptr_h #(PTR_WIDTH) rdptr_h(rdclk, rdrst_n, rd_en,g_wrptr_sync,b_rdptr,g_rdptr,fifo_empty);
  fifo_mem fmem(wrclk, wr_en, rdclk, rd_en,b_wrptr, b_rdptr, data_in,fifo_full,fifo_empty, data_out);
endmodule

//fifo memory
module fifo_mem #(parameter DEPTH=8, DATA_WIDTH=8, PTR_WIDTH=3) (
  input wrclk, wr_en, rdclk, rd_en,
  input [PTR_WIDTH:0] b_wrptr, b_rdptr,
  input [DATA_WIDTH-1:0] data_in,
  input fifo_full, 
  input fifo_empty,
  output reg [DATA_WIDTH-1:0] data_out
);
  reg [DATA_WIDTH-1:0] mem[0:DEPTH-1];
  
  always@(posedge wrclk) begin
    if(wr_en & !fifo_full) begin
      mem[b_wrptr[PTR_WIDTH-1:0]] <= data_in;
    end
  end
  assign data_out = mem[b_rdptr[PTR_WIDTH-1:0]];
endmodule

//dff synchronizer 
module dffsynchronizer #(parameter WIDTH=3) (
  input clk, rst,
  input [WIDTH:0] data_in, 
  output reg [WIDTH:0] data_out);
  
  reg [WIDTH:0] p;
  always@(posedge clk) begin
    if(!rst) begin
      p <= 0;
      data_out <= 0;
    end
    else begin
      p <= data_in;
      data_out <= p;
    end
  end
endmodule

//read handler
module rdptr_h #(parameter PTR_WIDTH=6) (
  input rdclk, rdrst_n, rd_en,
  input [PTR_WIDTH:0] g_wrptr_sync,
  output reg [PTR_WIDTH:0] b_rdptr, g_rdptr,
  output reg fifo_empty
);

  reg [PTR_WIDTH:0] b_rdptr_next;
  reg [PTR_WIDTH:0] g_rdptr_next;

  assign b_rdptr_next = b_rdptr+(rd_en & !fifo_empty);
  assign g_rdptr_next = (b_rdptr_next >>1)^b_rdptr_next;
  assign rdempty = (g_wrptr_sync == g_rdptr_next);
  
  always@(posedge rdclk or negedge rdrst_n) begin
    if(!rdrst_n) begin
      b_rdptr <= 0;
      g_rdptr <= 0;
    end
    else begin
      b_rdptr <= b_rdptr_next;
      g_rdptr <= g_rdptr_next;
    end
  end
  
  always@(posedge rdclk or negedge rdrst_n) begin
    if(!rdrst_n) fifo_empty <= 1;
    else        fifo_empty <= rdempty;
  end
endmodule

//write handler
module wrptr_h #(parameter PTR_WIDTH=6) (
  input wrclk, wrrst_n, wr_en,
  input [PTR_WIDTH:0] g_rdptr_sync,
  output reg [PTR_WIDTH:0] b_wrptr, g_wrptr,
  output reg fifo_full
);

  reg [PTR_WIDTH:0] b_wrptr_next;
  reg [PTR_WIDTH:0] g_wrptr_next;
   
  reg wrap_around;
  wire wrfull;
  
  assign b_wrptr_next = b_wrptr+(wr_en & !fifo_full);
  assign g_wrptr_next = (b_wrptr_next >>1)^b_wrptr_next;
  
  always@(posedge wrclk or negedge wrrst_n) begin
    if(!wrrst_n) begin
      b_wrptr <= 0; 
      g_wrptr <= 0;
    end
    else begin
      b_wrptr <= b_wrptr_next; 
      g_wrptr <= g_wrptr_next; 
    end
  end
  
  always@(posedge wrclk or negedge wrrst_n) begin
    if(!wrrst_n) fifo_full <= 0;
    else        fifo_full <= wrfull;
  end

  assign wrfull = (g_wrptr_next == {~g_rdptr_sync[PTR_WIDTH:PTR_WIDTH-1], g_rdptr_sync[PTR_WIDTH-2:0]});

endmodule