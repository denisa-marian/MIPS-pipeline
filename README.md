# MIPS Pipeline – VHDL Implementation

This project implements a 5-stage pipelined MIPS processor using **VHDL**, designed and simulated in **Xilinx Vivado** and tested on a **Nexys A7 FPGA** board.  
It models a simplified CPU architecture capable of parallel instruction execution with hazard management and modular design.

The processor is built around the classic **5 pipeline stages**:
1. **IF (Instruction Fetch)** – loads instructions from memory
2. **ID (Instruction Decode & Register Fetch)** – decodes opcodes and reads register values
3. **EX (Execute)** – performs arithmetic and logic operations using the ALU
4. **MEM (Memory Access)** – reads/writes data to memory
5. **WB (Write Back)** – writes results back to the register file

The project demonstrates concepts such as:
- Instruction-level parallelism
- Hazard detection and control
- Pipelined data flow
- Modular VHDL design

##Technologies Used
- **VHDL**
- **Xilinx Vivado**
- **Nexys A7 (Artix-7 FPGA)**
- **Assembly MIPS test programs**
