# Verilog CPU Components and ALU Project

This project is a Verilog-based digital design and computer architecture build focused on core CPU components. It includes low-level hardware modules such as multiplexers, full adders, a 32-bit adder, arithmetic logic support, and a larger merged CPU file that brings together ALU and datapath-related logic.

The goal of the project was to build and understand the hardware foundations behind processor execution, starting from basic combinational modules and scaling upward into arithmetic and CPU-stage integration.

## What This Project Includes

The project contains the following Verilog modules and files:

- `mux1.v`  
  A 1-bit 2-to-1 multiplexer

- `mux2.v`  
  A parameterized 2-to-1 multiplexer for wider buses, typically used for 32-bit signals

- `mux2_2bit.v`  
  A dedicated 2-bit 2-to-1 multiplexer

- `mux4.v`  
  A parameterized 4-to-1 multiplexer built from smaller muxes

- `full_adder.v`  
  A 1-bit full adder implemented using logic gates

- `adder32.v`  
  A 32-bit ripple-carry adder built from 32 full adders

- `alu_arithmetic.v`  
  Arithmetic support module used for addition and subtraction by conditionally inverting `b` and setting carry-in

- `alu.v`  
  ALU logic that combines arithmetic, bitwise AND, bitwise OR, and set-less-than style behavior

- `cpu_legacy_merged.v`  
  A larger merged file containing multiple modules related to ALU logic and early CPU datapath construction

- `memory_init.hex`  
  A memory initialization file with data values and machine code used for testing

## Project Overview

This project focuses on how CPU logic is built from the ground up.

At the lowest level, the design starts with simple gates and 1-bit modules. Those small units are then reused to create wider and more capable hardware blocks. For example, the 1-bit full adder is reused to build a 32-bit adder, and smaller multiplexers are reused to build wider and more flexible data selection logic.

From there, the ALU combines arithmetic and logical operations so that the processor can perform tasks such as:

- addition
- subtraction
- bitwise AND
- bitwise OR
- comparison logic for set-less-than style operations

The merged CPU file shows progress toward connecting these blocks into a larger processor datapath, including instruction fetch, decode, execute, and memory-related modules.

## Main Concepts Demonstrated

This project demonstrates several important digital design and computer architecture concepts:

- combinational logic design
- hierarchical hardware design
- parameterized Verilog modules
- ripple-carry addition
- multiplexing and data-path selection
- ALU operation selection
- sign extension and immediate handling
- basic CPU stage integration
- memory initialization for hardware testing

## Module Notes

### `full_adder.v`
This module implements a 1-bit full adder using XOR, AND, and OR gates. It produces:

- a 1-bit sum output
- a carry-out output

This is one of the most important building blocks in the project because it is reused in the larger 32-bit adder.

### `adder32.v`
This module chains 32 full adders together to form a 32-bit ripple-carry adder.

It takes:

- two 32-bit inputs
- one carry-in

It produces:

- a 32-bit result
- a final carry-out

This demonstrates structural Verilog design and how larger arithmetic units are created from repeated smaller components.

### `alu_arithmetic.v`
This module handles addition and subtraction logic.

It works by:

- inverting `b` when subtraction is needed
- setting the carry-in appropriately
- passing the result through the 32-bit adder

This is a classic hardware approach for supporting both addition and subtraction with shared circuitry.

### `alu.v`
This module acts as the main arithmetic logic unit.

It supports operations such as:

- bitwise AND
- bitwise OR
- arithmetic add/subtract behavior
- comparison support through set-less-than style logic

It also includes reduction logic used to determine whether the result is zero.

### `mux1.v`, `mux2.v`, `mux2_2bit.v`, `mux4.v`
These files implement multiplexers of different sizes.

They are used to select between inputs in the datapath, which is one of the most common tasks inside a CPU. Multiplexers control which values move forward at each stage depending on control signals.

### `cpu_legacy_merged.v`
This file appears to be a combined working file containing multiple modules tied to a larger CPU design effort.

It includes:

- ALU-related modules
- arithmetic support
- muxes
- adder logic
- instruction fetch work
- decode-stage related logic
- execute-stage related logic
- memory-stage related logic

This file reflects integration work where separate hardware components begin coming together into a processor-style architecture.

### `memory_init.hex`
This file initializes memory with both data and instruction values.

From the contents, it appears to include:

- an integer array in memory
- storage locations for a sum and OR-reduction result
- machine instructions for loading values, checking termination, looping, and storing results

This is useful for simulation and testing since it gives the CPU or memory module a known starting state.

## What I Learned

This project helped reinforce how processor hardware is built in layers.

A few key takeaways from this work:

- small logic modules matter because they become the foundation for larger systems
- structural Verilog is very useful for building repeated hardware cleanly
- arithmetic in hardware is not abstract like software, it depends on actual data-path design
- muxes are everywhere in CPU design because control flow depends on selecting the right signal at the right time
- integrating modules is often harder than writing them individually

It also gave me more hands-on understanding of how ALUs, adders, and datapath components interact inside a processor.

## How to Use the Project

This project can be compiled and simulated using a Verilog simulator such as:

- Icarus Verilog
- ModelSim
- Vivado Simulator
- Quartus tools, depending on setup

A common flow would be:

1. Compile the Verilog source files
2. Load the memory initialization file if the memory module supports it
3. Simulate the design
4. Inspect output signals, arithmetic results, and control behavior

Example compile flow with Icarus Verilog might look like:

```bash
iverilog -o cpu_sim full_adder.v adder32.v mux1.v mux2.v mux2_2bit.v mux4.v alu_arithmetic.v alu.v
vvp cpu_sim
