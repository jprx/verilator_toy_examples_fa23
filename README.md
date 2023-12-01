# Verilator Toy Examples
An example getting-started with Verilator project for learning about simulating RTL and Verilog basics.

### Simple Adder
A very simple combinatorial adder module demonstrating how to add two numbers.

Implementation is in `simple_adder.sv` and test bench in `simple_adder_tb.cc`.

### Ripple Carry Adder
Demonstrating a few SystemVerilog concepts (module declaration, generate blocks, and packed arrays) by creating 32 `full_adder` modules and hooking them up to the output.
This file shows how to create an adder without relying on the `+` operator, consisting of multiple full adder modules created programatically and hooked up together.

Implementation is in `ripple_carry.sv` and test bench in `ripple_carry_tb.sv`.

### Faulty Adder
A very simple synchronous circuit demonstrating the use of reset and clock signals and clocked elements within a module.
This module introduces clocked elements and reset lines.
Notice the addition of extra testbench code to handle the clock signal and reset line during initialization and test case evaluation.

This adder will run 256 times, keeping track of a counter that increments each clock cycle.
On the 256th cycle this adder will switch to returning the incorrect value.
We keep track of the current cycle using an internal counter.

Implementation is in `faulty_adder.sv` and test bench in `faulty_adder_tb.cc`.

## Usage Instructions

1. `make`
1. `./simple_adder`, `./ripple_carry`, or `./faulty_adder`.
