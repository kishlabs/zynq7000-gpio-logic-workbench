# ZedBoard LED Controller — Design & Architecture

A concise, structured description of the LED control subsystem focusing on hardware correctness, robustness, and clarity.

---

## Contents
1. [Goals](#goals)  
2. [Overview](#overview)  
3. [Signal Conditioning Pipeline](#signal-conditioning-pipeline)  
4. [Debounce & Pulse Strategy](#debounce--pulse-strategy)  
5. [LED Controller Behavior](#led-controller-behavior)  
6. [Button Priority & Timing](#button-priority--timing)  
7. [Constraints, Verification, Takeaways](#constraints-verification-takeaways)

---

## Goals
- Convert mechanical button inputs into reliable single events.
- Eliminate metastability and bouncing.
- Ensure “one and only one” action per press.
- Keep PL logic fully synchronous and modular.

---

## Overview
High-level blocks:
- Synchronizer (2-FF)  
- Debounce (counter-based)  
- Edge-to-pulse converter  
- LED control FSM/register

ASCII flow:
```
Button → [2-FF Sync] → [Debounce Counter] → [Edge Detector → Pulse] → [LED Controller]
```

---

## Signal Conditioning Pipeline
- Synchronizer: two flip-flops sampled by system clock to absorb metastability.
- Debouncer: increments while input is steady; resets on change.
- Edge detector: generates a single-cycle pulse from debounced level:
  btn_pulse = btn_db & ~btn_db_d

Design principle: every asynchronous input must pass this pipeline before use.

---

## Debounce & Pulse Strategy
- Method: counter-based stable-window (typical target: 10 ms).
- Behavior:
  - On stable HIGH for N cycles → accept.
  - On LOW → immediate reset.
  - Convert accepted level to one-clock pulse to prevent repeat actions on hold.

Parameter reference (example for 100 MHz clock):
| Target | Time | Cycles |
|---:|---:|---:|
| Debounce window | 10 ms | 1,000,000 / 100 = 1,000,000? (adjust to actual clk) |

(Adjust cycle count to your PL clock frequency.)

---

## LED Controller Behavior
- 8-bit register holds LED state.
- Operations triggered on button pulses:
  - Reset (synchronous)
  - Load from switches
  - Shift left
  - Shift right
  - Invert
- Priority resolved in a deterministic if/else-if chain on clock edge.

---

## Button Priority & Timing
Defined deterministic priority (highest → lowest):
1. Reset  
2. Load  
3. Shift Left  
4. Shift Right  
5. Invert

Rationale: safety-first (reset), then state-load, then shifts, then cosmetic invert.

---

## Constraints & Pin Mapping
- All ports must be mapped in XDC to valid ZedBoard PL pins.
- Verify full bus constraints; partial mappings cause synthesis/runtime errors.

---

## Verification
- Simulation: debounce counters, pulse edges, register updates.
- Hardware: per-button testing to confirm a single action per press; confirm hold does nothing.

---

## Takeaways
> Reliable hardware anticipates imperfect physical signals — synchronize, debounce, and use pulses.

Keep modules small and testable. Prefer explicit priorities and synchronous updates for predictable behavior.