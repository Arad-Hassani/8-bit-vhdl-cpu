# 8-Bit CPU Design in VHDL

A simple 8-bit central processing unit designed in VHDL using Intel/Altera Quartus.

The system combines an arithmetic logic unit (ALU), two 8-bit input registers, an FSM-based control unit, a 3-to-8 opcode decoder, and seven-segment display logic into a complete synchronous digital system.

This project was originally developed for a Digital Systems course and has since been cleaned and documented as a portfolio project.

---

## Overview

The CPU operates on two 8-bit inputs, `A` and `B`.

An 8-state finite state machine acts as the control sequencer. Its 3-bit state is passed to a 3-to-8 decoder, which generates a one-hot opcode used by the ALU to select one of eight arithmetic or logical operations.

The result is divided into two 4-bit values and routed to seven-segment display logic.

### System Flow

```text
                        +----------------+
                        |      FSM       |
                        |  Control Unit  |
                        +-------+--------+
                                |
                         current_state
                                |
                                v
                        +----------------+
                        | 3-to-8 Decoder |
                        +-------+--------+
                                |
                             opcode
                                |
             +------------------+------------------+
             |                                     |
             v                                     v
      +-------------+                       +-------------+
A --->| 8-bit Reg A |----+             +----| 8-bit Reg B |<--- B
      +-------------+    |             |    +-------------+
                         v             v
                       +-----------------+
                       |      ALU        |
                       |     8-bit       |
                       +--------+--------+
                                |
                              Result
                                |
                                v
                       +------------------+
                       | Seven-Segment    |
                       | Display Logic    |
                       +------------------+
