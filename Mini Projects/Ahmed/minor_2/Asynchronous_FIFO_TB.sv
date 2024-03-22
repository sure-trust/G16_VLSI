// or browse Examples
module Asynchronous_FIFO_TB;

parameter DSIZE = 8;
parameter ASIZE = 7;

wire [DSIZE-1:0] rd_data;
wire o_fifo_full;
wire o_fifo_empty;
reg [DSIZE-1:0] wr_data;
reg wr_en, wr_clk, wr_rst;
reg rd_en, rd_clk, rd_rst;

// Model a queue for checking data
reg [DSIZE-1:0] verif_data_q[$];
reg [DSIZE-1:0] verif_wr_data;


// Instantiate the FIFO
Asynchronous_FIFO #(DSIZE, ASIZE) dut (wr_en, wr_clk, wr_rst, rd_en, rd_clk, rd_rst, wr_data, rd_data, o_fifo_full, o_fifo_empty);

initial begin
  wr_clk = 1'b0;
  rd_clk = 1'b0;

  fork
    forever #2.5ns wr_clk = ~wr_clk;
    forever #10ns rd_clk = ~rd_clk;
  join
end

initial begin
  wr_en = 1'b0;
  wr_data = '0;
  wr_rst = 1'b1;
  repeat(5) @(posedge wr_clk);
  wr_rst = 1'b0;

  repeat(2) begin
    for (int i=0; i<200; i++) begin
      @(posedge wr_clk iff !o_fifo_full);
      wr_en = (i%2 == 0)? 1'b1 : 1'b0;
      if (wr_en) begin
        wr_data = $urandom;
        verif_data_q.push_front(wr_data);
      end
    end
  end
end

initial begin
  rd_en = 1'b0;

  rd_rst = 1'b1;
  repeat(5) @(posedge rd_clk);
  rd_rst = 1'b0;

  repeat(4) begin
    for (int i=0; i<100; i++) begin
      @(posedge rd_clk iff !o_fifo_empty)
      rd_en = (i%2 == 0)? 1'b1 : 1'b0;
      if (rd_en) begin
        verif_wr_data = verif_data_q.pop_back();
        // Check the rd_data against modeled wr_data
        $display("Checking rd_data: expected wr_data = %h, rd_data = %h", verif_wr_data, rd_data);
        assert(rd_data === verif_wr_data) else $error("Checking failed: expected wr_data = %h, rd_data = %h", verif_wr_data, rd_data);
      end
    end
    #1us;
  end
$finish;
end

initial begin 
  $dumpfile("dump.vcd"); $dumpvars;
end

endmodule
