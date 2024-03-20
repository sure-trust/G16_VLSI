# Asynchronous FIFO
in this design all parts are desgin in different module. Here have two sunchronizer module for wrt synchronizer and read synchroniser. one fifo module one top module one module for full condition and one empty condition.
And the testbench is written in system verilog.
and also in verilog

# contents
Introduction 

FIFO structure

Architecture

Asynchronous FIFO Pointers

Synchronizers & Binary Gray Counter

Full & Empty Logic Block

outputs

simulation


# Introduction
FIFO-Every memory in which the data word that is written in first also comes out first when the memory is read is a first-in first-out memory.

An asynchronous FIFO refers to a FIFO design where data values are written sequentially into a FIFO buffer using one clock domain, and the data values are sequentially read from the same FIFO buffer using another clock domain, where the two clock domains are asynchronous to each other. 

One common technique for designing an asynchronous FIFO is to use Gray code pointers that are synchronized into the opposite clock domain before generating synchronous FIFO full or empty status signals.

  


# FIFO Structure

![FIFO](https://github.com/GayazPatan/Images/assets/156210984/35766ad7-9966-4cc5-bd0e-3d7a467258ca.png) 

# Architecture

![image](https://github.com/GayazPatan/Images/assets/156210984/bc07e6fd-00cd-4fe3-be89-13fadd46e929.png)


![image](https://github.com/GayazPatan/Images/assets/156210984/90204fdc-69bb-42fa-a60f-89287a05c52a.png)


# Asynchronous FIFO Pointers


Write Pointer:

The write pointer always points to the next word to be written; therefore, on reset, both pointers are set to zero, which also happens to be the next FIFO word location to be written

Read Pointer:

The read pointer always points to the current FIFO word to be read. The fact that the read pointer is always pointing to the next FIFO word to be read means that the receiver logic does not have to use two clock periods to read the data word.



Synchroniser using two flip flop


![image](https://github.com/GayazPatan/Images/assets/156210984/10ff28ce-12da-469b-9444-8c2b2b0d4baf.png)





# Synchronizers & Binary Gray Counter

Synchronizers are very simple in operation; they are made of 2 D Flip Flop’s.As the FIFO is operating at 2 different clock domains so there is a need to synchronize the Write and Read pointers for generating empty and full logic which in turn is used for addressing the FIFO memory.

The Figure below shows how synchronization takes place; the logic behind this is very simple

<p align ="center">
<img src="https://github.com/GayazPatan/Images/assets/156210984/aef2bd59-1959-46e1-90f6-ac334679d6c5.png" width="780" height="320" />

<p align ="center">
<img src="https://github.com/GayazPatan/Images/assets/156210984/e77604b5-5f80-4e1f-844e-64063126eeb8.png" width="7800" height="320" />



We need to design a counter which can give Binary and Gray output’s, the need for Binary counter is to address the FIFO MEMORY i.e. Write and Read address. And the need of Gray counter is for addressing Read and Write pointers.


# Full & Empty Logic Block

When the status counter reaches the maximum FIFO depth it will assert FIFO full signal and when its value is zero it will assert FIFO empty signal

![image](https://github.com/GayazPatan/Images/assets/156210984/12cb159b-a8aa-4b02-8f0e-c62fbfce136e.png)


# Output & simulation waveform-


![output](https://github.com/GayazPatan/Images/assets/156210984/2c8c221b-d20d-497c-b7f9-25a25ef88b99.png)
