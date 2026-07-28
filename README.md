# Tiny RISC32 Processor

## Overview
This repository contains the RTL design and verification files for a custom 32-bit RISC processor implemented in Verilog. The project showcases a completely modular datapath architecture with tightly coupled units for instruction fetching, decoding, execution, and memory access. 

## System Architecture
The processor is built using a purely modular RTL approach, separating the datapath into distinct functional units:

*   **Fetch Unit (`fetch_unit.v`):** Manages the Program Counter (PC) and interfaces with a 256x32-bit instruction memory. It seamlessly handles standard sequential execution as well as branch target routing.
*   **Instruction Decode & Fetch (`operfetch.v`):** Decodes the 32-bit instruction to extract the opcode, immediate flags, and register addresses. It handles sign-extension and zero-extension for immediate values and pre-calculates branch targets.
*   **Control Unit (`control_signals.v`):** A combinational decoder that generates precise control signals (WriteBack, Load, Store, Branch, Call, Return) and distinct ALU operation codes based on the instruction opcode.
*   **Register File (`registerfile.v`):** A 16x32-bit general-purpose register file featuring synchronous write and asynchronous read operations.
*   **Execute Unit (`execute_unit.v`):** Contains a versatile Arithmetic Logic Unit (ALU) supporting 13 discrete operations (ADD, SUB, MUL, DIV, MOD, AND, OR, NOT, LSL, LSR, ASR). It also evaluates equality (`eq`) and greater-than (`gt`) flags for conditional branching.
*   **Memory Access (`memory_access.v`):** Interfaces with a 256x32-bit data memory block to execute deterministic Load and Store operations.

## Instruction Set Architecture (ISA) Support
The custom ISA handles a robust set of instructions critical for general-purpose computing:
*   **Arithmetic & Logical:** Addition, Subtraction, Multiplication, Division, Modulo, Bitwise AND/OR/NOT, and Arithmetic/Logical Shifts.
*   **Memory Operations:** Load (`ld`) and Store (`st`) with immediate or register-based offset calculation.
*   **Control Flow:** Unconditional Jump (`b`), Conditional Branches (`beq`, `bgt`), Function Calls (`call`), and Returns (`ret`).

## Simulation & Verification
The processor's execution logic has been rigorously validated. 
*   **Testbench (`processor_tb.v`):** A custom Verilog testbench drives the processor using pre-loaded machine code instructions mapped directly into the instruction memory.
*   **Monitoring:** The simulation tracks the Program Counter, state changes across core registers (R1-R4), and control flags (eq, gt, isBeq, isBgt) in real-time to verify data integrity and correct branch execution.

## Getting Started
To simulate this processor locally:
1. Compile all Verilog files in the `/src` directory alongside `processor_tb.v` in the `/tb` directory using a standard simulator like Icarus Verilog or ModelSim.
2. Run the simulation to view the `$monitor` console output, which logs the register states and PC progression at each clock cycle.
