# SimpleTestbench

This is a simple testbench created using SystemVerilog. The Device-Under-Test (DUT) is a two-state Hardware thread consisting an adder - sumItUp.sv - and a hardware thread that simply takes in the value from the adder and then sends the total as the output. The Adder takes in Natural numbers as input, and sums the total once the input is equal to zero. The main focus of this repo is the testbench, rather than the adder itself since it is quite simple (hence the name).

The testbench contains randomization and constraints which are not supported on some of the free software that are used (e.g. ModelSim) in the academics. So far, Xilinx Vivado version 2024.1 was used to test the testbench and have worked, but cannot be certain for other software.

## Testbench

The testbench randomly generates the values for DUT to sum up. On a higher level, the testbench will randomly generate values variable length between 2 to 10, and the values between 65,536.
