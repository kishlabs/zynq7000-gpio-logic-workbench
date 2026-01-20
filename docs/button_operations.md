# Button Operations – Hardware Demonstration

This document demonstrates the behavior of each push button on the ZedBoard using **real hardware photographs**.

Each section shows:
- the **initial LED state**
- the **button pressed**
- the **resulting LED state**

This ensures the behavior is clearly observable and reproducible.

---

## 🔹 Initial State (Before Any Operation)

After programming the FPGA:
- The LED register is initialized to `00000000`
- All LEDs are OFF

This is the baseline state before any button interaction.

![Initial State](/images/initial_state.jpg)

---

## 🔼 BTNU – Load Switch Values

### Purpose
Loads the current slide switch values into the LED register.

### Before Pressing BTNU
- LEDs retain their previous state
- Switch values do **not** affect LEDs yet

![Before Load](/images//before_load.jpg)

### After Pressing BTNU
- LED pattern matches the slide switch positions
- Only one load occurs per press

![After Load](/images/btn_load.jpg)

---

## ⬅️ BTNL – Shift Left

### Purpose
Shifts the LED register one bit to the left.

### Behavior
- MSB is discarded
- LSB is filled with `0`
- One shift per button press

![Shift Left](/images/btn_shift_left.jpg)

---

## ➡️ BTNR – Shift Right

### Purpose
Shifts the LED register one bit to the right.

### Behavior
- LSB is discarded
- MSB is filled with `0`
- One shift per button press

![Shift Right](/images//btn_shift_right.jpg)

---

## 🔄 BTNC – Invert LEDs

### Purpose
Inverts all bits of the LED register.

### Behavior
- `1` → `0`
- `0` → `1`
- Operation occurs once per press

![Invert](/images/btn_invert.jpg)

---

## ⏹️ BTND – Reset LEDs

### Purpose
Clears the LED register.

### Behavior
- All LEDs turn OFF
- System returns to known state

![Reset](/images/btn_reset.jpg)

---

## 🧠 Behavioral Guarantees

This design guarantees:

- ✔ Exactly **one action per button press**
- ✔ No repeated actions while holding a button
- ✔ No glitches due to mechanical bounce
- ✔ Deterministic behavior even with fast presses

These guarantees are achieved through:
- synchronization
- debounce logic
- pulse-based control

---

## 📌 Notes

- All images are captured from a **real ZedBoard**
- No simulation screenshots are used here
- This section serves as **hardware proof**, not theory
