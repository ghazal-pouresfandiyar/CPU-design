# Custom 8-bit Verilog CPU Design

This project involves the design and implementation of an 8-bit processor following the **Von Neumann architecture**. The CPU was modeled in **Verilog** and verified through simulation to execute a variety of memory-resident instructions.

---

## 🚀 Project Overview

The processor is designed with a 3-bit opcode to support 6 core instructions and uses a 1-bit mode selector to toggle between **direct and indirect addressing**. The system operates on an 8-bit data path with a 4-bit address space, allowing for 16 unique memory locations.

### Key Features

- **Word Size**: 8-bit instructions and data  
- **Addressing Space**: 16 lines of 8-bit memory  
- **Control Unit**: 3-bit sequence counter (SC) managing up to 8 timing states ($T_0$ to $T_7$)  
- **Instruction Cycle**: Fetch, Decode, Indirect, and Execute phases  

---

## 🛠 Hardware Architecture

### Internal Registers

| Register | Size | Description |
|----------|------|-------------|
| **PC** | 4-bit | Program Counter; holds the address of the next instruction |
| **AR** | 4-bit | Address Register; holds the memory address for data access |
| **IR** | 8-bit | Instruction Register; holds the instruction fetched from memory |
| **AC** | 8-bit | Accumulator; the primary register for ALU operations |
| **DR** | 8-bit | Data Register; holds data operands during execution |

---

## 📘 Instruction Set Architecture (ISA)

The instruction format uses:
- Bit 7 → Addressing mode
- Bits 6–4 → Opcode
- Bits 3–0 → Memory address

### Supported Instructions

- **ADD (000)**: Adds memory content to the Accumulator  
- **SUB (001)**: Subtracts memory content from the Accumulator  
- **XOR (010)**: Bitwise XOR between memory and Accumulator  
- **MUL (011)**: Multiplies by 2 using `AC ← AC + AC`  
- **LOAD (100)**: Loads data from memory into Accumulator  
- **STORE (101)**: Stores Accumulator value into memory  
- **CMP (110)**: Bitwise NOT operation on memory operand  

---

## 📂 Implementation Details

### ALU Design

The ALU is based on an **8-bit ripple-carry adder/subtractor**. It also includes logic for XOR and NOT operations, with a multiplexer selecting the final output based on the opcode.

### Control Unit Logic

The control unit manages the common bus system and ensures correct data flow between registers and memory during each timing state ($T_i$), based on decoded control signals.

---

## 🧪 Simulation & Verification

The design was verified using a **test bench** with a 5ns clock cycle over a 1000ns duration.

- **Fetch/Decode**: Verified correct PC increment and instruction loading into IR  
- **Arithmetic/Logic**: Confirmed correct ADD, SUB, XOR results in waveform simulation  
- **Indirect Addressing**: Verified multi-level memory addressing behavior  
