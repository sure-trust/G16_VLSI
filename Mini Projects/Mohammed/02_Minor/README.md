# Asynchronous FIFO
in this design all parts are desgin in different module. Here have two sunchronizer module for wrt synchronizer and read synchroniser. one fifo module one top module one module for full condition and one empty condition.
And the testbench is written in system verilog.
and also in verilog

# Contents
 + Introduction 

 + FIFO structure

 + Architecture

 + Asynchronous FIFO Pointers

 + Synchronizers & Binary Gray Counter

 + Full & Empty Logic Block

 + Outputs and Simulation

# Introduction
FIFO-Every memory in which the data word that is written in first also comes out first when the memory is read is a first-in first-out memory.

An asynchronous FIFO refers to a FIFO design where data values are written sequentially into a FIFO buffer using one clock domain, and the data values are sequentially read from the same FIFO buffer using another clock domain, where the two clock domains are asynchronous to each other. 

One common technique for designing an asynchronous FIFO is to use Gray code pointers that are synchronized into the opposite clock domain before generating synchronous FIFO full or empty status signals.

  


# FIFO Structure
![FIFOO](https://github.com/touheed1829/PROJECTS/assets/142418059/dbcfb805-3cc7-4883-92c6-56e96ffca8d4)

# Architecture

![Archi1](https://github.com/touheed1829/PROJECTS/assets/142418059/7440b741-fe06-4e1e-850d-fef906336026)


![Archi](https://github.com/touheed1829/PROJECTS/assets/142418059/33cff1d2-3855-4f61-b1b2-9913485b480a)


# Asynchronous FIFO Pointers


#### Write Pointer:

The write pointer always points to the next word to be written; therefore, on reset, both pointers are set to zero, which also happens to be the next FIFO word location to be written

#### Read Pointer:

The read pointer always points to the current FIFO word to be read. The fact that the read pointer is always pointing to the next FIFO word to be read means that the receiver logic does not have to use two clock periods to read the data word.



### Synchroniser using two flip flop


![Two](https://github.com/touheed1829/PROJECTS/assets/142418059/d02a695b-dbc0-4d87-83f3-021c8ec0e099)





# Synchronizers & Binary Gray Counter

Synchronizers are very simple in operation; they are made of 2 D Flip Flop’s.As the FIFO is operating at 2 different clock domains so there is a need to synchronize the Write and Read pointers for generating empty and full logic which in turn is used for addressing the FIFO memory.

The Figure below shows how synchronization takes place; the logic behind this is very simple

#### Write Pointer Synchronization

![SYNCHO WRITE](https://github.com/touheed1829/PROJECTS/assets/142418059/b608aee3-2c25-4c72-b1ca-b6026bd25295)

#### Read Pointer Synchronization

![Read ptr](https://github.com/touheed1829/PROJECTS/assets/142418059/f4e2b9ae-fb3d-4f4d-9bd7-cd198cbfd3b0)

We need to design a counter which can give Binary and Gray output’s, the need for Binary counter is to address the FIFO MEMORY i.e. Write and Read address. And the need of Gray counter is for addressing Read and Write pointers.


# Full & Empty Logic Block

When the status counter reaches the maximum FIFO depth it will assert FIFO full signal and when its value is zero it will assert FIFO empty signal

![LAST](https://github.com/touheed1829/PROJECTS/assets/142418059/f5a0694f-4655-4f40-8ed7-156d0ac791c8)


# OUTPUTS------


![log](https://github.com/touheed1829/PROJECTS/assets/142418059/1bb412c6-e402-4f28-af5a-76c7e454f76a)




# Simulation Waveform-----


![SIMULATION](https://github.com/touheed1829/PROJECTS/assets/142418059/ff635dc7-d3e4-482c-b39e-fa20c0310841)
