
# Hardware Setup – ZedBoard LED Control Project

This document describes the **physical hardware setup** and preparation steps required to run this project on the ZedBoard.

The project uses **only the Programmable Logic (PL)** side of the Zynq device.

---

## 1. Required Hardware

- ZedBoard (Zynq-7000 Development Board)
- USB Type-A to Micro-USB cable (for JTAG + power)
- Host PC with Vivado installed
- No external peripherals required

---

## 2. Power and Connectivity

### Power Source
The ZedBoard can be powered via:
- **USB (recommended for this project)**

Ensure the board receives stable power before programming.

### JTAG Connection
- Connect the **micro-USB JTAG port** on the ZedBoard to the host PC
- This provides:
  - FPGA programming access
  - Board communication through Vivado Hardware Manager

---

## 3. Board Configuration (Jumpers & Switches)

Ensure the following default configuration:

- Boot Mode: **JTAG**
- No SD card required
- No Ethernet / UART needed

The design does not use the Processing System (PS), so no boot image is required.

---

## 4. FPGA Clock Source

- The design uses the **100 MHz PL system clock**
- This clock is provided internally on the ZedBoard
- It is connected to the FPGA through the `clk` input pin

The debounce timing (~10 ms) is calculated assuming a 100 MHz clock.

---

## 5. Input Devices Used

### Push Buttons
The ZedBoard provides five mechanical push buttons:

| Button | Label | Used For |
|------|------|---------|
| Center | BTNC | Invert LEDs |
| Up | BTNU | Load switch values |
| Down | BTND | Reset LEDs |
| Left | BTNL | Shift LEDs left |
| Right | BTNR | Shift LEDs right |

These buttons are **mechanical and asynchronous**, and therefore must be debounced and synchronized in logic.

---

### Slide Switches
- 8 slide switches are used as input data
- Each switch corresponds to one LED bit
- Switch values are sampled only when **BTNU (Load)** is pressed

---

## 6. Output Devices Used

### LEDs
- 8 discrete LEDs on the ZedBoard
- Driven directly from an 8-bit register in the FPGA
- LED states persist until modified by a button event

---

## 7. Pin Mapping

All FPGA pins are mapped using a dedicated constraint file:

```

constraints/zedboard_pinmap.xdc

```

Important notes:
- All ports are explicitly constrained
- No unconstrained IOs are allowed
- Pin locations are taken from official ZedBoard documentation
- Incorrect or partial pin constraints will prevent bitstream generation

---

## 8. Programming the FPGA

Steps to program the ZedBoard:

1. Open Vivado
2. Open the project
3. Run:
   - Synthesis
   - Implementation
   - Generate Bitstream
4. Open **Hardware Manager**
5. Connect to target
6. Program the device using the generated bitstream

After programming:
- LEDs will reflect the internal register state
- Buttons will immediately control the LEDs

---

## 9. Hardware Usage Notes

- Press each button **once** for one operation
- Holding a button will **not** repeat the action
- Mechanical bouncing does not affect behavior
- Multiple buttons pressed simultaneously are resolved using priority logic

Photographs demonstrating correct operation are available in the `hardware/` folder.

---

## 10. Troubleshooting

If the design does not behave as expected:

- Verify the board is in **JTAG boot mode**
- Check that the correct bitstream is programmed
- Ensure the correct constraint file is used
- Confirm the 100 MHz clock pin is correctly mapped
- Avoid using buttons without debounce logic

---

## 11. Summary

This hardware setup requires:
- No external components
- No Processing System configuration
- Only standard ZedBoard IO devices

The simplicity of the setup allows the focus to remain on **robust digital design practices** rather than board complexity.

