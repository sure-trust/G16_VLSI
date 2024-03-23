DESIGN SPECIFICATIONS

a) DESIGN:

Transmitter A   ===>   Receiver B

Transmitter A sends data with a Burst size of 120 to the Receiver B at a frequency of 200MHz


b) WRITE INTERFACE:

	wr_clk(200MHz)
	wr_en(active high for write output)
	wr_data(8-bit data from the transmitter)
	wr_rst(active high)
	
c) READ INTERFACE:
	rd_clk(200MHz)
	rd_en(active high)
	rd_data(8-bit data from receiver)
	rd_rst(active high)
	rd_ptr = 0(initial case)

d)FIFO STATUS INTERFACE:
	
	O_fifo_full(High if FIFO is full)
	O_fifo_empty(High if FIFO is empty)


