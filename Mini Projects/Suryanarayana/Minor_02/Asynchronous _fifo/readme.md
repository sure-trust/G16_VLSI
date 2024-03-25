
# Asynchronous FIFO
Design specifications

1. Transmitter A transmits data(burst=120),at 200MHz clk frequency
2. Receiver B receives the data at 50MHz clk frequency
3. No idle cycles b/w read and write are involved
  #Write interface:
 1. wr_clk: write clock (200MHz)
 2. wr_en: active high enable signal for the write operation to occur
 3. wr_data: 8-bit data coming from the transmitter
 4. wr_rst: active high reset signal to reset the write pointer involved, note, you do not reset the contents of the memory
  #Read interface:
 1. rd_clk: read clock (50 MHz)
 2. rd_en: active high enable signal for read operation to occur
 3. rd_data: 8-bit data going to the receiver
 4. rd_rst: active high reset signal to reset the read pointer involved.
  #FIFO status interface:
 1. o_fifo_full: goes high when FIFO is full. No more data writes are possible in that case.
 2. o_fifo_empty: goes high when FIFO is empty. No more data reads are possible in that case
<p align = "center">
  <img src="https://github.com/M-Suryanarayana/fifo/assets/156163346/40887562-0f2d-453a-9c24-c8ff856536ec" width="720px" Height="auto">
</p>
<p align = "center">
  <img src="https://github.com/M-Suryanarayana/fifo/assets/156163346/7db5fe4c-a892-49c2-b16a-a75e7da721e8" width="720px" Height="auto">
</p>