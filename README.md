# FIFO Design in Verilog

This project implements a **parameterized FIFO (First-In First-Out)** buffer using **SystemVerilog**, with configurable width and depth.

## Features
- Parameterized `width` and `depth`  
- Synchronous read and write (single clock)  
- Asynchronous active-low reset  
- Full and empty flag generation  
- Output current FIFO element count via `countout`

## FIFO Interface

| Signal     | Direction | Description                         |
|------------|-----------|-------------------------------------|
| clk        | Input     | Clock signal                        |
| reset      | Input     | Asynchronous active-low reset       |
| datain     | Input     | Data to be written into FIFO        |
| write_en   | Input     | Write enable                        |
| read_en    | Input     | Read enable                         |
| dataout    | Output    | Data read from FIFO                 |
| full       | Output    | FIFO is full                        |
| empty      | Output    | FIFO is empty                       |
| countout   | Output    | Current number of elements in FIFO  |

## Testbench
The testbench (`tb_FIFO.sv`) includes the following test scenarios:
- Normal write and read operation  
- Underflow condition  
- Overflow prevention  
- Wrap-around pointer testing

