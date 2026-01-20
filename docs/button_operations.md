# Push Button Operations – Hardware Verification

This document demonstrates the behavior of each ZedBoard push button using real hardware photos.

---

## 🔼 BTNU – Load Switch Values

**Function:**  
Loads the current slide switch pattern into the LED register.

**Result:**  
LEDs immediately reflect the switch positions.

![BTNU Load](../images/btn_load.jpg)

---

## ⬅️ BTNL – Shift Left

**Function:**  
Shifts the LED register one position to the left on each press.

**Result:**  
One-bit left shift per press, no repeated shifts while holding.

![BTNL Shift Left](../images/btn_shift_left.jpg)

---

## ➡️ BTNR – Shift Right

**Function:**  
Shifts the LED register one position to the right on each press.

**Result:**  
One-bit right shift per press.

![BTNR Shift Right](../images/btn_shift_right.jpg)

---

## 🔄 BTNC – Invert LEDs

**Function:**  
Bitwise inversion of the LED register.

**Result:**  
ON LEDs turn OFF, OFF LEDs turn ON.

![BTNC Invert](../images/btn_invert.jpg)

---

## ⏹️ BTND – Reset LEDs

**Function:**  
Clears the LED register.

**Result:**  
All LEDs turn OFF.

![BTND Reset](../images/btn_reset.jpg)

---

## 🧠 Notes

- Each button press generates exactly **one pulse**
- Mechanical bouncing does not cause repeated actions
- Button hold does **not** repeat the operation
- Behavior verified on real ZedBoard hardware

