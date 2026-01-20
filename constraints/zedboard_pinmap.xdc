
# ZedBoard LED Control using Debounced Push Buttons

This project demonstrates a **reliable push-button based LED controller** implemented on the **ZedBoard (Zynq-7000)** using **pure Programmable Logic (PL)**.

Unlike basic LED demos, this design focuses on solving **real hardware problems** such as:
- mechanical button bounce
- metastability from asynchronous inputs
- repeated triggering when a button is held

The entire design was **simulated, synthesized, implemented, and verified on real ZedBoard hardware**.

---

## 🧠 Motivation

Mechanical push buttons are **not clean digital signals**.

When pressed:
- they bounce between `0` and `1`
- they are asynchronous to the FPGA clock
- using them directly leads to **multiple unintended operations**

This project answers one core question:

> **How do we convert a noisy mechanical button into a single, clean hardware event?**

---

## 🏗️ System Overview

The complete system is built as a clean pipeline:

```

Push Button
↓
2-FF Synchronizer
↓
Debounce Counter
↓
Edge (Pulse) Generator
↓
LED Control Logic

```

This separation keeps the design:
- modular
- reusable
- easy to debug
- hardware-safe

*(Architecture diagrams are provided in the `architecture/` folder.)*

---

## 🔍 Design Philosophy

### Why Synchronization?
Push buttons are **asynchronous** to the FPGA clock.  
A 2-flip-flop synchronizer is used to protect the logic from metastability.

### Why Debouncing?
Button bounce can cause **multiple transitions** for a single press.  
A counter ensures the signal is stable for a fixed duration (~10 ms).

### Why Pulse Generation?
Level-based button signals cause repeated actions when held.  
A **one-clock-wide pulse** guarantees **exactly one action per press**.

---

## 🎮 Button to LED Mapping (Hardware Verified)

| ZedBoard Button | Operation |
|-----------------|-----------|
| **BTNU** | Load switch values into LEDs |
| **BTNL** | Shift LED pattern left |
| **BTNR** | Shift LED pattern right |
| **BTNC** | Invert LED pattern |
| **BTND** | Reset (clear) LEDs |

Each button press generates **one and only one operation**, regardless of how long the button is held.

---

## 📸 Hardware Validation

All functionality has been validated on a real ZedBoard.

Photographs showing each button operation are available in the `hardware/` folder:
- Load operation
- Shift left
- Shift right
- Invert
- Reset

These images serve as **physical proof** of correct hardware behavior.

---

## 📂 Project Structure

```

src/
├── button_debounce.v   # Synchronizer + debounce + pulse generator
└── top.v               # LED register and control logic

constraints/
└── zedboard_pinmap.xdc # Official ZedBoard PL pin mapping

architecture/
└── (system & flow diagrams)

hardware/
└── (real board photos)

```

---

## 🧪 Tested Environment

- **Board**: ZedBoard
- **SoC**: Zynq-7000 (xc7z020clg484)
- **Clock**: 100 MHz (PL)
- **Tool**: Vivado
- **Design Style**: Fully synchronous, PL-only

---

## 🎓 Key Learnings

- External inputs must always be synchronized
- Mechanical buttons cannot be used directly
- Debounce logic must latch state, not pulse
- Edge detection is critical for event-based designs
- Correct pin constraints are as important as RTL

---

## 🚀 Possible Extensions

- Rotate LEDs instead of shift
- Long-press detection
- Double-click detection
- FSM-based LED patterns
- PS ↔ PL interaction using interrupts
```

---

### ✅ What we achieved in this step

* One **strong**, **visual**, **story-driven** README
* No markdown clutter
* Reads like a **hardware lab notebook**
* Matches (and slightly beats) your previous repo style

---

