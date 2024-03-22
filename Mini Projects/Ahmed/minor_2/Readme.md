
# Minor Project: Asynchronous FIFO

This Project involve designing of an asynchronous FIFO with the following specifications.

- Design Specifications:
    - Transmitter A transmits data (burst of size 120), at 200MHz clock frequency.
    - Receiver B receives the data at 50MHz clock frequency.
    - No idle cycles between read and write are involved.

- Write interface:
    - wr_clk : write clock (200MHz)
    - wr_en: active high enable signal for the write operation to occur
    - wr_data: 8-bit data coming from the transmitter
    - wr_rst: active high reset signal to reset the write pointer involved, note, you do not reset the contents of the memory.

- Read interface:
    - rd_clk: read clock (50 MHz)
    - rd_en: active high enable signal for read operation to occur
    - rd_data: 8-bit data going to the receiver
    - rd_rst: active high reset signal to reset the read pointer involved.

- FIFO status interface:
    - o_fifo_full: goes high when FIFO is full. No more data writes are possible in that case.
    - o_fifo_empty: goes high when FIFO is empty. No more data reads are possible in that case.


## Asynchronous FIFO
An Asynchronous FIFO (First-In, First-Out) is a type of digital circuit used in electronic design to manage data transmission between two asynchronous clock domains. It stores data temporarily, allowing data to be transferred from one clock domain to another without synchronization issues. Unlike synchronous FIFOs, asynchronous FIFOs do not rely on a common clock signal between the input and output sides, making them suitable for interfacing between systems with different clock frequencies or sources.


## Block Diagram

<p align="center">
  <img src="Screenshot 2024-03-15 160750.png">
</p>

## Directory structure

```
├── Asynchronous_FIFO.v
├── Asynchronous_FIFO_TB.sv
├── memory.v
├── Readme.md
├── read_handler.v
├── synchronizer_rptr.v
├── synchronizer_wptr.v
└── write_handler.v
```

- **README.md**- This markdown file has the project report.
- **Asynchronous_FIFO.v**- This is the top module, This has instantiation of `memory.v` `read_handler.v` `synchronizer_rptr.v` `synchronizer_wptr.v` `write_handler.v`.
- **Asynchronous_FIFO_TB.v**- This is the verilog file to test the FIFO.
- **memory.v**- This memory array use to temporarly store the data.
- **synchronizer_rptr.v**- They are made of 2 D Flip Flop’s.As the FIFO is operating at 2 different clock domains so there is a need to synchronize the Read pointer.
- **synchronizer_wptr.v**- They are made of 2 D Flip Flop’s.As the FIFO is operating at 2 different clock domains so there is a need to synchronize the Write pointer.
- **read_handler.v**- This module is responsible handling of read pointer and generate the fifo empty signal.
- **write_handler.v**- This module is responsible handling of write pointer and generate the fifo full signal.

**Logic for FIFO full & empty signals**

When the status counter reaches the maximum FIFO depth it will assert FIFO full signal and when its value is zero it will assert FIFO empty signal

  - FIFO full
      `assign wfull_val = (wgraynext=={~wq2_rptr[ADDRSIZE:ADDRSIZE-1], wq2_rptr[ADDRSIZE-2:0]});`
  - FIFO empty
      `assign rempty_val = (rgraynext == rq2_wptr);`

## FIFO Depth Calculation

  Frequency of Write clock = 200 MHz
  Frequency of Read clock = 50 MHz
  Burst Size = 120

  Time period of Write clock = 5 nsec
  Time period of Read clock = 20 nsec

  Time to send a burst = 120*5 = 600 nsec
  Number of data that can be read in 600 nsec  = 600/20 = 30

  Number of bytes need to store in FIFO = 120 - 30 = 90

  FIFO Depth = 90

## Schematic diagram
<p align="center">
  <img src="Screenshot 2024-03-20 031804.png">
</p>

## Simulation Waveform-

<p align="center">
  <img src="simulation.png">
</p>

### Section 1

<p align="center">
  <img src="Section 1.png">
</p>

### Section 2

<p align="center">
  <img src="Section 2.png">
</p>

### Section 3

<p align="center">
  <img src="Section 3.png">
</p>