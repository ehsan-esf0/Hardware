## 🔁 always Block in Verilog

### ✅ What Is `always`?

The `always` block is a core construct in Verilog that allows you to model:

* **Combinational logic**
* **Sequential logic** (with clocks)
* **State machines**
* **Memory behavior**

Unlike `assign`, the `always` block can **store values (reg)** and can **include procedural code** like `if`, `case`, `for`, etc.

---

## 🧠 Syntax of `always`

```verilog
always @(sensitivity_list) begin
    // Procedural code here
end
```

---

## 🟦 Sensitivity List

The **sensitivity list** defines **which signals** trigger the execution of the `always` block. When any signal in the list **changes**, the block is **reevaluated**.

### 👇 There are 2 main types of `always` blocks:

---

## 1️⃣ Combinational Logic Block

### ✅ Syntax

```verilog
always @(*) begin
    // combinational logic
end
```

### ✅ Example

```verilog
always @(*) begin
    out = a & b;
end
```

### 🔍 Explanation:

* `@(*)` is shorthand for "sensitive to all signals used inside."
* This block will be evaluated **any time a or b changes**.
* This is used to implement **combinational logic** like mux, adders, etc.

### ✅ Equivalent (manual) sensitivity list

```verilog
always @(a or b) begin
    out = a & b;
end
```

> 🧠 Tip: Always use `@(*)` to avoid forgetting a signal in the list.

---

## 2️⃣ Sequential Logic Block (Flip-Flops / Clocked Logic)

### ✅ Syntax

```verilog
always @(posedge clk) begin
    // sequential logic
end
```

Or:

```verilog
always @(negedge clk) begin
    // triggered on falling edge
end
```

### ✅ Example: D Flip-Flop

```verilog
always @(posedge clk) begin
    q <= d;
end
```

### ✅ Example: Register with Reset

```verilog
always @(posedge clk or posedge rst) begin
    if (rst)
        q <= 0;
    else
        q <= d;
end
```

---

## 🧪 Example with all types

```verilog
module example (
    input wire clk,
    input wire rst,
    input wire a, b,
    output reg out
);

    // Combinational logic block
    wire temp;
    assign temp = a ^ b;

    // Sequential block with reset
    always @(posedge clk or posedge rst) begin
        if (rst)
            out <= 0;
        else
            out <= temp;
    end

endmodule
```

---

## 🧠 Summary: Sensitivity List Guide

| Sensitivity List                | Purpose                       | When to Use                  |
| ------------------------------- | ----------------------------- | ---------------------------- |
| `@(*)`                          | All used signals              | Combinational logic (safe)   |
| `@(a or b or c)`                | Specific signals              | Combinational logic (manual) |
| `@(posedge clk)`                | Positive clock edge           | Flip-flops, registers        |
| `@(negedge clk)`                | Negative clock edge           | Special flip-flops           |
| `@(posedge clk or posedge rst)` | Clock with asynchronous reset | Synchronous reset logic      |

---

## ⚠️ Warnings

1. Forgetting a signal in sensitivity list for combinational logic **can cause simulation mismatches**.
2. Use `@(*)` instead of listing all signals manually — it’s safer.
3. **Only one** `always` block should write to a specific `reg`.
4. Never mix **blocking (`=`)** and **non-blocking (`<=`)** assignments in sequential logic.



