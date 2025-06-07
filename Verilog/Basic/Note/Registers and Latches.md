## Registers and Latches in Verilog

### 1. **Registers**

* In Verilog, `reg` is a data type that holds its value until changed.
* Registers are commonly used to model **sequential logic** that updates only on clock edges.
* Usually described with `always @(posedge clk)` blocks.

#### Example of positive-edge triggered register:

```verilog
reg q;
always @(posedge clk) begin
    if (reset)
        q <= 0;
    else
        q <= d;
end
```

* Here, `q` updates only at the rising edge of the clock.
* This models a **flip-flop** or register.

---

### 2. **Latches**

* A latch is a level-sensitive device.
* It stores data as long as the enable signal is active.
* In Verilog, latches are inferred when assignments are incomplete in combinational blocks or when output depends on a level-sensitive enable.

#### Example of a transparent latch:

```verilog
reg q;
always @(enable or d) begin
    if (enable)
        q = d;
end
```

* When `enable` is high, `q` follows `d`.
* When `enable` is low, `q` holds its previous value.
* This infers a **level-sensitive latch**.

---

### 3. **Difference between Registers and Latches**

| Feature             | Register (Flip-Flop)             | Latch                                                  |
| ------------------- | -------------------------------- | ------------------------------------------------------ |
| Sensitivity         | Edge-triggered (posedge/negedge) | Level-sensitive                                        |
| Control Signal      | Clock                            | Enable                                                 |
| Behavior            | Updates only on clock edge       | Updates whenever enable is active                      |
| Usage               | Synchronous logic                | Asynchronous or special cases                          |
| Inferred by Verilog | `always @(posedge clk)`          | `always @(enable or data)` with incomplete assignments |

---

### 4. **Synthesis Tips**

* Avoid unintended latches by **assigning outputs in all cases** in combinational blocks.
* Use edge-triggered always blocks to infer registers (flip-flops).
* Use level-sensitive enables carefully to infer latches only when needed.

---

### Summary

* `reg` in Verilog can represent both registers and latches depending on coding style.
* Registers update on clock edges (sequential logic).
* Latches are level-sensitive and hold values while enabled.
* Be careful to avoid unintended latches in combinational code.
