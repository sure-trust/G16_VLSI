`timescale 1us/1ps
module testbench();
    reg wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en;
    reg [7:0] wr_data;
    wire [7:0] rd_data;
    wire fifo_Full, fifo_Empty;
    asy_fifo #() dut (
        .wr_clk(wr_clk),
        .rd_clk(rd_clk),
        .wr_rst(wr_rst),
        .rd_rst(rd_rst),
        .wr_data(wr_data),
        .rd_data(rd_data),
        .wr_en(wr_en),
        .rd_en(rd_en),
      .fifo_Full(fifo_Full),
      .fifo_Empty(fifo_Empty)
    );

  initial begin
    wr_rst = 1'b1;
    wr_en = 1'b0;
    rd_en = 1'b0;
    wr_data = 8'h01;
    #20;
    wr_rst = 1'b0;
    #300;
    $finish;
  end
    initial begin
    wr_rst = 1'b1;
    wr_en = 1'b0;
    rd_en = 1'b0;
    rd_rst = 1'b1;
    wr_data = 0;
    #5 wr_rst = 1'b0;
      repeat (50) begin
      #5 wr_data = $random;
      wr_en = 1'b1;
      rd_en = 1'b0;
    end
  end
	
 // task read_task;
    // Write data to FIFO
   // repeat (100) begin
   //   rd_en = 1'b0;
    //end
  //  #200;
  //endtask

   // Clock generation
  
    initial begin
    wr_clk = 1'b1;
    forever #2.5 wr_clk = ~wr_clk;
    end
    initial begin
    rd_clk = 1'b1;
    forever #10 rd_clk = ~rd_clk;
    end
    initial begin
    wr_rst = 1'b1;
    wr_en = 1'b0;
    wr_data = 0;
    // Reset
    #5 wr_rst = 1'b0;

    // Write data to FIFO
      repeat (200) begin
      #5 wr_data = $random;
      wr_en = 1'b1;
      rd_en = 1'b1;
    end
  end
     initial begin
    rd_rst = 1'b1;
    rd_en = 1'b0;
    // Reset
    #5 rd_rst = 1'b0;
    repeat (100) begin
      rd_en = 1'b1;
    end
    #1000;
  end
  
  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
endmodule