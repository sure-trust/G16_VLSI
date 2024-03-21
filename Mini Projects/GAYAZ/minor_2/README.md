<i>

  # ASYNCHRONOUS FIFO
</i>

In this design all parts are desgin in different module. Here have two synchronizer module for wrt synchronizer and read synchroniser. one fifo module one top module one module for full condition and one empty condition.
And the testbench is written in system verilog.
and also in verilog
<b>
<i>

# CONTENTS
 * INTRODUCTION 

 * FIFO STRUCTURE

 * ARCHITECTURE

 * OPERATION

 * OUTPUT

 * SIMULATION WAVEFORM
</i>
</b>

<i>

  # INTRODUCTION
</i>

An asynchronous FIFO, short for First-In-First-Out, is a type of data buffer that allows data to be written into it at one rate and read from it at another rate. Unlike synchronous FIFOs, which rely on a common clock signal to synchronize data transfer between the read and write operations, asynchronous FIFOs operate without a common clock signal. Instead, they use handshaking signals, typically called "empty" and "full" to control data flow.

Asynchronous FIFOs are commonly used in digital systems where data is transferred between components operating at different clock frequencies or with independent timing domains. They provide a means of buffering data and synchronizing its transfer without requiring complex clock domain synchronization techniques.

The operation of an asynchronous FIFO involves careful consideration of timing constraints to ensure proper data integrity and prevent issues like data loss or corruption. These FIFOs typically employ techniques such as gray coding or two-phase handshaking to manage data transfers effectively in asynchronous environments.
  

<i>

  # FIFO STRUCTURE
</i>
<p align ="center">
<img src="https://github.com/GayazPatan/Images/assets/156210984/70ecbe19-27b3-4ff3-8df0-b89a986f331d" width="720px" height=auto />
</p>

<p align ="center">
  <b>
    Block Diagram Of Asynchronous FIFO
  </b>
</p>

<i>

  # ARCHITECTURE
</i>
<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/bc07e6fd-00cd-4fe3-be89-13fadd46e929" width="720px" height=auto />
</p>

<i>

# OPERATION
</i>
The steps involved in the operation of an asynchronous FIFO (First-In-First-Out) are as follows:
<i>

#### Write Operation:
</i>
<b> Data Input:</b> Data is written into the FIFO by the writing device (producer).<br/>
<b> Address Pointer Update: </b> The write address pointer increments to the next available storage location in the FIFO.</br>
<b> Handshaking: </b>If the FIFO is not full, handshaking signals (such as 'write enable') may be used to indicate that data is being written.

<i>

#### Read Operation:
</i>
<b>Data Output:</b> Data is read from the FIFO by the reading device (consumer).<br/>
<b>Address Pointer Update:</b> The read address pointer increments to the next available data location in the FIFO.</br>
<b>Handshaking: </b>If the FIFO is not empty, handshaking signals (such as 'read enable') may be used to indicate that data is being read.
<i>

#### Empty and Full Detection:
</i>

<b>

Empty Detection :</b> Empty detection involves checking whether the FIFO has any data available for reading. This is done by comparing the read and write pointers. If they are equal, the FIFO is empty.Some FIFO implementations may include a dedicated empty flag or status bit that indicates when the FIFO is empty.

<b>

Full Detection :</b> Full detection involves checking whether the FIFO has reached its maximum capacity and cannot accept any more data for writing.This is typically done by comparing the read and write pointers. If the write pointer catches up to the read pointer, the FIFO is full.Like empty detection, some FIFO implementations may include a dedicated full flag or status bit that indicates when the FIFO is full.

When the FIFO is detected as empty, appropriate action may be taken, such as preventing further read operations until new data is available. When the FIFO is detected as full, further write operations may be blocked until space becomes available in the FIFO.

Empty and full detection mechanisms ensure that data is managed effectively within the FIFO, preventing underflows and overflows while allowing for efficient data transfer between devices. These mechanisms are essential for the proper functioning of asynchronous FIFOs in digital systems.

<i>

  #### Data Transfer:
</i>
Data is transferred between the FIFO and the devices connected to it based on the handshaking signals and the status of the FIFO (empty or full).

<p align ="center">
<img src="https://github.com/GayazPatan/Images/assets/156210984/919d6a6d-0eca-4927-a4a4-89a76ffa7df5" width="720px" height=auto />
</p>

<i>

  #### Synchronization:
</i>
Handshaking signals are used to synchronize the write and read operations between devices operating at different clock frequencies or with independent timing domains.Handshaking ensures that both devices are synchronized and ready for data transfer, preventing data loss or corruption. It also allows for flow control, ensuring that data is not overwhelmed or lost due to differences in processing speeds or buffer capacities between devices. Handshaking is crucial in asynchronous communication, where devices may not share a common clock signal and operate independently.

<i>

  #### Error Handling:
</i>
Error conditions, such as overflow (writing to a full FIFO) or underflow (reading from an empty FIFO), need to be detected and handled appropriately to ensure data integrity.

<i>

  # OUTPUT
</i>
<p align ="center">
    <img src="https://github.com/GayazPatan/Images/assets/156210984/9af5f923-3acd-43e9-a562-fe62127b934d" width=720px height=auto />
</p>    
<i>

  # SIMULATION WAVEFORM
</i>
<p align ="center">
<img src="https://github.com/GayazPatan/Images/assets/156210984/2c8c221b-d20d-497c-b7f9-25a25ef88b99" width=720px height=auto />
