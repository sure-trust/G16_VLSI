# Asynchronous FIFO - Minor Project 2

## Problem Statement

Design an asynchronous FIFO with the following specifications.

### Design Specifications:
-	Transmitter A transmits data (burst of size 120), at 200MHz clock frequency
-	Receiver B receives the data at 50MHz clock frequency
-	No idle cycles between read and write are involved

### Write Interface:
-	wr_clk: write clock (200MHz)
-	wr_en: active high enable signal for the write operation to occur
-	wr_data: 8-bit data coming from the transmitter
-	wr_rst: active high reset signal to reset the write pointer involved, note, you do not reset the contents of the memory

### Read Interface:
-	rd_clk: read clock (50 MHz)
-	rd_en: active high enable signal for read operation to occur
-	rd_data: 8-bit data going to the receiver
-	rd_rst: active high reset signal to reset the read pointer involved

### FIFO Status Interface:
-	o_fifo_full: goes high when FIFO is full. No more data writes are possible in that case
-	o_fifo_empty: goes high when FIFO is empty. No more data reads are possible in that case 

### Reference Diagram


<img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/3572739a-d07a-48fd-aa98-5f1836930251" alt="Refernce Diagram" style="width:50%" >

### Design Details:

**Inputs and Output to FIFO**

|  Signal  |  Description                     |
|----------|----------------------------------|
|  wr_clk     | Clock signal for synchronization |
|  rd_clk     | Clock signal for synchronization  |
|  wr_rst     | Reset signal to bring the write pointer to idle state |
|  rd_rst     | Reset signal to bring the write pointer to idle state |
|  wr_en      | Write enable  |
|  rd_en      | Read enable  |
|  wr_data    | Signal used to write data to the memory |
|  rd_data    | Signal used to read data from the memory 
|  FIFO_full  | Signal used to indicate FIFO is full or not |
|  FIFO_empty | Signal used to indicate FIFO is empty or not |


### Assumed diagram

<img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/b1d6483f-3559-4d6b-8975-e52300ed9b40" alt="Assumed Diagram" style="width:50%" >

### Depth Calculation

<img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/f9376045-3d8c-4b9a-ac51-1b7393ae1685" alt="Depth Calculation" style="width:50%" >


### Assumed Architecture
<img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/55bb0e21-5b58-4048-a85b-f56f6e90a145" alt="Assumed Architecture" style="width:50%" >


# Introduction To Asynchronous Fifo
- In asynchronous FIFO, data read and write operations use different clock frequencies. Since write and read clocks are not synchronized, it is referred to as asynchronous FIFO. Usually, these are used in systems where data need to pass from one clock domain to another which is generally termed as ‘clock domain crossing’. Thus, asynchronous FIFO helps to synchronize data flow between two systems working on different clocks.


<style>
img {
  display: block;
  margin-left: auto;
  margin-right: auto;
}
</style>
<img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/25b4c268-8df2-4220-931c-3b392e83081b" alt="image" style="width:50%">

## Operation:

- In the case of synchronous FIFO, the write and read pointers are generated on the same clock. However, in the case of asynchronous FIFO write pointer is aligned to the write clock domain whereas the read pointer is aligned to the read clock domain. Hence, it requires domain crossing to calculate FIFO full and empty conditions. This causes metastability in the actual design. In order to resolve this metastability, 2 flip flops or 3 flip flops synchronizer can be used to pass write and read pointers.

## Dual Flop Synchronizer:

<img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/5232d3a8-6391-4b2e-be3d-465458b0a522" alt="dff" style="width:50%">



- When signals move from one clock domain to another, it may not be sampled correctly leading to unstable oscillations in the signal called metastability.

- Double Flop Synchronizer or Two flip-flop synchronizer is the simplest synchronization technique to ensure that the signal is sampled correctly at the destination domain.

- Metastability occurs when the setup/hold time of a flip-flop is violated and it leads to unstable oscillations.

- The oscillating signal from the source domain requires some time to settle down (setlling time) and this is what we provide by connecting an extra flip-flop working on the destination clock.

## Usage of Gray to Binary & Binary to Gray Converter:

- In an asynchronous FIFO, Gray to binary converters are used when data is read from the FIFO, converting Gray code data received from the asynchronous domain into binary data usable by the synchronous domain.

- Conversely, binary to Gray converters are used when data is written into the FIFO, converting binary data from the synchronous domain into Gray code data suitable for transmission across asynchronous clock domains.

- These converters help ensure proper synchronization and reliable data transfer between asynchronous clock domains while minimizing the risk of metastability and timing violations. 

# Waveforms

### First Part
<img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/d7ba7bef-1697-4d46-986e-0bb3ab6f72cf" alt="dff" style="width:50%">

### Second Part
<img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/38de83ef-95b7-4f51-8f82-66f8153ba4fc" alt="dff" style="width:50%">


### Full Waveforms

<img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/2e502bd4-9e06-4d3a-8e2e-fac43d0ec533" alt="dff" style="width:50%">









