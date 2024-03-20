cd# Minor Project: Asynchronous FIFO

This Project involve designing of an asynchronous FIFO with the following specifications.

-Design Specifications:
    -Transmitter A transmits data (burst of size 120), at 200MHz clock frequency.
    -Receiver B receives the data at 50MHz clock frequency.
    -No idle cycles between read and write are involved.
-Write interface:
    -wr_clk: write clock (200MHz)
    -wr_en: active high enable signal for the write operation to occur
    -wr_data: 8-bit data coming from the transmitter
    -wr_rst: active high reset signal to reset the write pointer involved, note, you do not reset the contents of the memory.
-Read interface:
    -rd_clk: read clock (50 MHz)
    -rd_en: active high enable signal for read operation to occur
    -rd_data: 8-bit data going to the receiver
    -rd_rst: active high reset signal to reset the read pointer involved.
-FIFO status interface:
    -o_fifo_full: goes high when FIFO is full. No more data writes are possible in that case.
    -o_fifo_empty: goes high when FIFO is empty. No more data reads are possible in that case.



### Asynchronous FIFO
An Asynchronous FIFO (First-In, First-Out) is a type of digital circuit used in electronic design to manage data transmission between two asynchronous clock domains. It stores data temporarily, allowing data to be transferred from one clock domain to another without synchronization issues. Unlike synchronous FIFOs, asynchronous FIFOs do not rely on a common clock signal between the input and output sides, making them suitable for interfacing between systems with different clock frequencies or sources.


### Block Diagram

<p align="center">
  ![Screenshot 2024-03-15 160750](https://github.com/Razi-720/Hdlbits_Solution/assets/145758591/998b5fdc-ba77-41ec-89b7-1fc9352c36d0)
</p>

### Directory structure
.
├── Asynchronous_FIFO.v
├── Asynchronous_FIFO_TB.sv
├── memory.v
├── Readme.md
├── read_handler.v
├── synchronizer_rptr.v
├── synchronizer_wptr.v
└── write_handler.v


- **README.md**- This markdown file has the project report.
- **Asynchronous_FIFO.v**- This is the top module, This has instantiation of `memory.v` `read_handler.v` `synchronizer_rptr.v` `synchronizer_wptr.v` `write_handler.v`.
- **Asynchronous_FIFO_TB.v**- This is the Verilog file to test the FIFO.
- **memory.v**- This memory array is used to temporarily store the data.
- **synchronizer_rptr.v**- They are made of 2 D Flip Flop’s. As the FIFO is operating at 2 different clock domains there is a need to synchronize the Read pointer.
- **synchronizer_wptr.v**- They are made of 2 D Flip Flop’s. As the FIFO is operating at 2 different clock domains there is a need to synchronize the Write pointer.
- **read_handler.v**- This module is responsible for handling of read pointer and generating the FIFO empty signal.
- **write_handler.v**- This module handles the write pointer and generates the FIFO full signal.

-Logic for FIFO full & empty signals
    When the status counter reaches the maximum FIFO depth it will assert FIFO full signal and when its value is zero it will assert FIFO empty signal
    -FIFO full
        `assign wfull_val = (wgraynext=={~wq2_rptr[ADDRSIZE:ADDRSIZE-1], wq2_rptr[ADDRSIZE-2:0]});`
    -FIFO empty
        `assign rempty_val = (rgraynext == rq2_wptr);`

### Schematic diagram
<p align="center">
  ![Screenshot 2024-03-20 031804](https://github.com/Razi-720/Hdlbits_Solution/assets/145758591/fc00bea9-c839-461a-a858-fd2dd6d76132)
</p>

### Simulation Waveform-

<p align="center">
  ![Screenshot 2024-03-20 021412](https://github.com/Razi-720/Hdlbits_Solution/assets/145758591/40b77272-d069-471b-ab02-25dc518d35cf)
</p>
