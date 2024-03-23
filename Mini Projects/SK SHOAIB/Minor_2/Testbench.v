module async_fifo_TestBench;

  parameter DATA_WIDTH = 8;

  wire [DATA_WIDTH-1:0] data_out;
  wire fifo_full;
  wire fifo_empty;
  reg [DATA_WIDTH-1:0] data_in;
  reg wr_en, wrclk, wrrst_n;
  reg rd_en, rdclk, rdrst_n;
  reg [DATA_WIDTH-1:0] wrdata_q[$], wrdata;
  
  asynchronous_fifo a_fifo (wrclk, wrrst_n,rdclk, rdrst_n,wr_en,rd_en,data_in,data_out,fifo_full,fifo_empty);
  always #10ns wrclk = ~wrclk;
  always #35ns rdclk = ~rdclk;
  initial begin
    wrclk = 1'b0; 
    wrrst_n = 1'b0;
    wr_en = 1'b0;
    data_in = 0;
    repeat(10) @(posedge wrclk);
    wrrst_n = 1'b1;
    repeat(2) begin
      for (int i=0; i<30; i++) begin
        @(posedge wrclk iff !fifo_full);
        wr_en = (i%2 == 0)? 1'b1 : 1'b0;
        if (wr_en) begin
          data_in = $urandom;
          wrdata_q.push_back(data_in);
        end
      end
      #50;
    end
  end

  initial begin
    rdclk = 1'b0; 
    rdrst_n = 1'b0;
    rd_en = 1'b0;

    repeat(20) @(posedge rdclk);
    rdrst_n = 1'b1;

    repeat(2) begin
      for (int i=0; i<30; i++) begin
        @(posedge rdclk iff !fifo_empty);
        rd_en = (i%2 == 0)? 1'b1 : 1'b0;
        if (rd_en) begin
          wrdata = wrdata_q.pop_front();
          if(data_out !== wrdata) $error("Time = %0t: Comparison Failed: expected wr_data = %h, rd_data = %h", $time, wrdata, data_out);
          else $display("Time = %0t: Comparison Passed: wr_data = %h and rd_data = %h",$time, wrdata, data_out);
        end
      end
      #50;
    end

    $finish;
  end
  
  initial begin 
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
endmodule