# Custom 8-bit Verilog CPU Design

This repository contains the design and implementation of a custom **8-bit processor** developed as part of a Computer Architecture course. The CPU follows the **Von Neumann architecture** and was verified through simulation using a custom test bench.

---

## 🚀 Project Overview

The objective was to design a functional processor from the ground up, including the instruction set, control unit logic, and ALU.

### Key Features

* 
**Architecture**: 8-bit data path with a 4-bit address space (16 memory locations).


* 
**Addressing Modes**: Supports both **Direct** (Mode 0) and **Indirect** (Mode 1) addressing.


* 
**Instruction Cycle**: Implements a 4-stage cycle: Fetch, Decode, Indirect, and Execute.


* 
**Hardware Description**: Written in **Verilog**.



---

## 🛠 Hardware Architecture

### Internal Registers

| Register | Description | Size |
| --- | --- | --- |
| **PC** | Program Counter (stores next instruction address) | 4-bit 

 |
| **AR** | Address Register (stores memory address for data) | 4-bit 

 |
| **IR** | Instruction Register (holds current instruction) | 8-bit 

 |
| **AC** | Accumulator (stores ALU results) | 8-bit 

 |
| **DR** | Data Register (holds data fetched from memory) | 8-bit 

 |

### Instruction Set Architecture (ISA)

The processor uses a 3-bit Opcode to support the following instructions:

* 
**ADD (000)**: $AC \leftarrow AC + M[AR]$ 


* 
**SUB (001)**: $AC \leftarrow AC - M[AR]$ 


* 
**XOR (010)**: $AC \leftarrow AC \oplus M[AR]$ 


* 
**MUL (011)**: $M[AR] \leftarrow M[AR] \times 2$ 


* 
**LOAD (100)**: $AC \leftarrow M[AR]$ 


* 
**STORE (101)**: $M[AR] \leftarrow AC$ 


* 
**CMP (110)**: $M[AR] \leftarrow \sim M[AR]$ (Bitwise NOT) 



---

## 📂 Implementation Details

### Instruction Format

The 8-bit instruction is structured as follows:

* 
**Bit 7**: Addressing Mode (0 for Direct, 1 for Indirect).


* 
**Bits 6-4**: Opcode.


* 
**Bits 3-0**: Memory Address.



### Control Unit

A 3-bit **Sequence Counter (SC)** manages the timing of micro-operations. The execution flow is determined by specific timing signals ($T_0$ to $T_7$).

### ALU Design

The ALU performs arithmetic and logic operations using:

* An **8-bit Ripple Carry Adder/Subtractor**.


* Bitwise XOR and NOT logic units.


* A multiplexer to select the final output based on the opcode.



---

## 🧪 Simulation & Verification

Functional correctness was verified by populating memory with sample data and instructions. The simulation confirmed:

1. Successful **Direct Addressing** operations for all logic and arithmetic functions.


2. Correct resolution of **Indirect Addressing** (fetching a pointer from memory to find the final operand).


3. Proper register transitions and memory updates as viewed on the simulation waveform.
