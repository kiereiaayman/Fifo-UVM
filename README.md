# Synchronous FIFO Verification (UVM)

A UVM-based verification project for a synchronous FIFO design using assertions, functional coverage, and constrained-random testing.

## Features
- UVM testbench with sequences: reset, write-only, read-only, and mixed operations
- Assertion-based checks (SVA) for flags, pointers, and counter behavior
- Functional coverage with randomized stimulus
- Scoreboard validation for data correctness
- Flag verification: full, empty, almostfull, almostempty
- Pointer wraparound and overflow/underflow handling

## How to Run

### Requirements
- QuestaSim or ModelSim
- SystemVerilog and UVM support enabled

### Simulation Steps
1. Open a terminal in the project root directory.
2. Run the following command:
   ```bash
   vsim -do run.do
   
## Authors
- Verification: Kiereia Ayman

- RTL Design: Eng. Karim Wassim
