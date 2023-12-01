# Verilator Toy Examples
An example getting-started with Verilator project for learning about simulating RTL and Verilog basics.

### Simple Adder
A very simple combinatorial adder module demonstrating how to add two numbers.

Implementation is in `simple_adder.sv` and test bench in `simple_adder_tb.cc`.

### Faulty Adder
A very simple synchronous circuit demonstrating the use of reset and clock signals and clocked elements within a module.

Implementation is in `faulty_adder.sv` and test bench in `faulty_adder_tb.cc`.

## Usage Instructions

1. `make`
1. `./simple_adder` or `./faulty_adder`
