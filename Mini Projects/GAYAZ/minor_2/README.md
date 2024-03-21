<i>

  # Asynchronous FIFO
</i>

In this design all parts are desgin in different module. Here have two sunchronizer module for wrt synchronizer and read synchroniser. one fifo module one top module one module for full condition and one empty condition.
And the testbench is written in system verilog.
and also in verilog
<b>
<i>

# Contents
 * Introduction 

 * FIFO structure

 * Architecture

 * outputs

 * simulation
</i>
</b>

<i>

  # Introduction
</i>

An asynchronous FIFO, short for First-In-First-Out, is a type of data buffer that allows data to be written into it at one rate and read from it at another rate. Unlike synchronous FIFOs, which rely on a common clock signal to synchronize data transfer between the read and write operations, asynchronous FIFOs operate without a common clock signal. Instead, they use handshaking signals, typically called "empty" and "full" to control data flow.

Asynchronous FIFOs are commonly used in digital systems where data is transferred between components operating at different clock frequencies or with independent timing domains. They provide a means of buffering data and synchronizing its transfer without requiring complex clock domain synchronization techniques.

The operation of an asynchronous FIFO involves careful consideration of timing constraints to ensure proper data integrity and prevent issues like data loss or corruption. These FIFOs typically employ techniques such as gray coding or two-phase handshaking to manage data transfers effectively in asynchronous environments.
  

<i>

  # FIFO Structure
</i>
<p align ="center">
<img src="https://github.com/GayazPatan/Images/assets/156210984/50a26d94-2a56-4bbc-af55-7268ed62279d" width="720px" height=auto />
</p>

<p align ="center">
  <b>
    Block Diagram Of Asynchronous FIFO
  </b>
</p>

<i>

  # Architecture
</i>
<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/bc07e6fd-00cd-4fe3-be89-13fadd46e929" width="720px" height=auto />
</p>

<i>
  # OUTPUT
</i>
<p align ="center">
    <img src="https://github.com/GayazPatan/Images/assets/156210984/9af5f923-3acd-43e9-a562-fe62127b934d" width=720px height=auto />
</p>    
<i>

  # Simulation waveform-
</i>
<p align ="center">
<img src="https://github.com/GayazPatan/Images/assets/156210984/2c8c221b-d20d-497c-b7f9-25a25ef88b99" width=720px height=auto />
