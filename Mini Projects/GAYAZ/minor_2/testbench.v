module testbench();

  reg wrclk, rdclk, wrrst, rdrst, wren, rden;
  reg [7:0] wrdata;
  wire [7:0] rddata;
  wire full, empty;

    // Instantiate the module under test
  ASYNC_FIFO #(8) dut (
    .wrclk(wrclk),
    .rdclk(rdclk),
    .wrrst(wrrst),
    .rdrst(rdrst),
    .wrdata(wrdata),
    .rddata(rddata),
    .wren(wren),
    .rden(rden),
    .full(full),
    .empty(empty)
    );

    // Clock generation
    always begin
        wrclk = 1'b0;
        #2; // Adjust delay based on your clock frequency
        wrclk = 1'b1;
        #2; // Adjust delay based on your clock frequency
    end

    always begin
        rdclk = 1'b0;
        #5; // Adjust delay based on your clock frequency
        rdclk = 1'b1;
        #5; // Adjust delay based on your clock frequency
    end

    initial begin
        // Initialize/reset signals
        wrrst = 1'b1;
        rdrst = 1'b1;
        wren = 1'b0;
        rden = 1'b0;
        wrdata = 8'h00;

        // Release reset after some time
        #10;
        wrrst = 1'b0;
        rdrst = 1'b0;

        // Test scenario
        // Write some data into the FIFO
        wren = 1'b1;
        wrdata = 8'hA8;
        #10;
      	wrdata = 8'h08;
        #10;
        wrdata = 8'h68;
        #10;
        wrdata = 8'h54;
        #10;
        wren = 1'b0;

        // Read from the FIFO
        rden = 1'b1;
        #20;
        rden = 1'b0;
      	
    end
      initial begin
        $monitor("full=%0d, empty=%0d, wrdata=%0d, rddata=%0d, wren=%0d,rden=%0d,",full,empty,wrdata,rddata,wren,rden);        		 
    end
    initial begin
        $dumpfile ("dump.vcd");
        $dumpvars ();
    end

		initial begin
        // Add more test cases as needed...
        // Finish simulation
        #100 $finish;
    end

endmodule