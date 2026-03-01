# Adaptive-ECG-Accelerator
Adaptive ECG filtering system using AMD Zynq SoC on PYNQ-Z2. The design combines AI-based decision logic in the Processing System with hardware-accelerated FIR and Moving Average filters in Programmable Logic. AXI DMA enables high-speed PS–PL data transfer, achieving low-latency, condition-based ECG preprocessing for edge healthcare applications.

1.Project Overview
This project presents an AI-assisted adaptive ECG signal preprocessing system implemented using the AMD Zynq SoC architecture on the PYNQ-Z2 platform. The system integrates hardware acceleration in Programmable Logic (PL) with intelligent decision-making in the Processing System (PS) to achieve low-latency and efficient ECG filtering.

The design demonstrates heterogeneous computing by combining ARM-based software control with FPGA-based parallel signal processing.

2.Problem Statement
ECG signal preprocessing is essential for accurate cardiac diagnosis. Traditional software-based filtering introduces latency and processes signals in a linear, non-adaptive manner.

This project addresses the need for:

Low-latency ECG preprocessing

Hardware-accelerated filtering

Adaptive filter selection based on heart rate conditions

Efficient PS–PL data communication

3.System Architecture
The architecture is built on the AMD Zynq SoC, leveraging:

Processing System (PS) – Runs adaptive logic and system control

Programmable Logic (PL) – Implements hardware filter accelerators

AXI DMA – Enables high-speed data transfer between PS and PL

Data Flow

ECG Dataset (PS / DDR)
→ Heart Rate Analysis (PS)
→ Adaptive Decision Logic (PS)
→ AXI DMA Transfer (PS → PL)
→ Selected Filter Accelerator (FIR / Moving Average)
→ AXI DMA Transfer (PL → PS)
→ Filtered Output Visualization

4.Hardware Components (PL)
#FIR Filter Accelerator
Implemented in Verilog (RTL)

AXI4-Stream interface

Designed for precise frequency-domain filtering

Suitable for high-risk or emergency conditions

#Moving Average Filter Accelerator
Implemented in Verilog (RTL)

AXI4-Stream interface

Provides smoothing for stable heart rate conditions

5.Software Components (PS)
Adaptive Manager implemented in Python

Heart rate calculation using peak detection

Dynamic filter selection logic

DMA-based data transfer control

ECG visualization using Matplotlib

6.Technologies Used
AMD Zynq SoC (PS + PL architecture)

PYNQ-Z2 Development Board

Verilog (RTL Design)

AXI DMA Protocol

AXI4-Stream Interface

Python (NumPy, SciPy, Matplotlib)

Vivado Design Suite

