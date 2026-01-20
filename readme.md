# ZedBoard LED Control with Debounced Push Buttons

This project implements a fully debounced push-button based LED controller on the **ZedBoard (Zynq-7000)** using pure Programmable Logic (PL).

Each push button performs a single deterministic action on an 8-bit LED register.  
Mechanical button bounce and metastability are handled using a synchronizer, debounce counter, and edge detection.

---

## 🎯 Features

- 8-bit LED register stored in FPGA flip-flops
- Mechanical push-button debounce (≈10 ms @ 100 MHz)
- One action per button press (pulse-based control)
- Priority-based control logic
- Clean, modular Verilog design
- Tested on real ZedBoard hardware

---

## 🧠 Design Overview

**Main building blocks:**
- 2-FF synchronizer for metastability protection
- Counter-based debounce logic
- Rising-edge pulse generation
- Central LED control FSM (event-driven)

---

## 🧩 Button Function Mapping

| ZedBoard Button | Function |
|-----------------|----------|
| **BTNU** | Load switch values to LEDs |
| **BTNL** | Shift LEDs left |
| **BTNR** | Shift LEDs right |
| **BTNC** | Invert LED pattern |
| **BTND** | Reset LEDs (clear) |

---

## 📸 Hardware Demonstration

Photos showing each button operation are available in the `images/` folder and explained in detail in the documentation.

---

## 📂 Project Files

- `src/top.v` – Top-level LED control logic
- `src/button_debounce.v` – Synchronization + debounce + pulse generator
- `constraints/zedboard_pinmap.xdc` – ZedBoard PL pin mapping

---

## 🚀 How to Build

1. Open Vivado
2. Create a new RTL project for **xc7z020clg484**
3. Add Verilog sources from `src/`
4. Add constraint file from `constraints/`
5. Set `top.v` as top module
6. Run Synthesis → Implementation → Generate Bitstream
7. Program the ZedBoard via JTAG

---

## ✅ Status

✔ Fully functional on hardware  
✔ No timing violations  
✔ No unconstrained IOs  

---
