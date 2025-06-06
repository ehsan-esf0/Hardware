# ⏰ Understanding **Clock** and **Reset** in Verilog

These two signals — `clock` and `reset` — are fundamental in digital systems and essential for writing **sequential logic** in Verilog.

---

## 🕒 1. **Clock (`clk`)**

### ✅ Definition:

A **clock** is a periodic digital signal (square wave) that alternates between `0` and `1`. It synchronizes operations in sequential logic.

### 📉 Clock waveform:

```
clk: ──┐┌──┐┌──┐┌──┐
      └┘  └┘  └┘  └┘
```

### ✅ Purpose:

* Synchronizes **flip-flops**, **registers**, and **state machines**
* Triggers actions at each rising/falling edge

### ✅ Types of edges:

* `posedge clk` → **Positive edge** (rising edge)
* `negedge clk` → **Negative edge** (falling edge)

### ✅ Basic usage:

```verilog
always @(posedge clk) begin
    q <= d;  // Capture 'd' into 'q' at every rising edge of clk
end
```

---

## 🔁 2. **Reset (`rst`)**

### ✅ Definition:

The **reset** signal initializes the system or puts it into a known default state. Like hitting the "restart" button on a computer.

### ✅ Two types of reset:

| Type             | Description                       | Syntax Example                          |
| ---------------- | --------------------------------- | --------------------------------------- |
| **Asynchronous** | Works **independently** of clock  | `@(posedge clk or posedge rst)`         |
| **Synchronous**  | Works **together** with the clock | `@(posedge clk)` with `if (rst)` inside |

---

### 📘 Example – Asynchronous Reset:

```verilog
always @(posedge clk or posedge rst) begin
    if (rst)
        q <= 0;
    else
        q <= d;
end
```

> Reset can happen **immediately**, no need to wait for a clock edge.

---

### 📘 Example – Synchronous Reset:

```verilog
always @(posedge clk) begin
    if (rst)
        q <= 0;
    else
        q <= d;
end
```

> Reset only happens at the **rising edge of clk**.

---

## 💡 Why do we need reset?

* To initialize registers, counters, FSMs, etc.
* To put the system in a **predictable state** after power-up or error

---

## 🧪 Full Example – Register with clk and rst:

```verilog
module simple_register (
    input wire clk,
    input wire rst,
    input wire [7:0] d,
    output reg [7:0] q
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 8'b0;
        else
            q <= d;
    end

endmodule
```

---

## ⚙️ Generating a clock in testbench:

```verilog
initial begin
    clk = 0;
    forever #5 clk = ~clk;  // Clock period = 10 time units
end
```

---

## 🧠 Pro Tips:

| Concept                 | Tip                                                            |
| ----------------------- | -------------------------------------------------------------- |
| **Clock**               | Always clean, consistent frequency (avoid glitches)            |
| **Async Reset**         | Useful for FPGA designs — allows fast initialization           |
| **Sync Reset**          | Easier to control and simulate                                 |
| **Use `<=`**            | For non-blocking assignments inside sequential `always` blocks |
| **Do NOT use `assign`** | For registers; use `reg` with `always`                         |

---

## 🧩 Summary Table:

| Signal | Usage               | Edge Sensitivity            | Purpose                 |
| ------ | ------------------- | --------------------------- | ----------------------- |
| `clk`  | Controls timing     | `posedge` or `negedge`      | Drives sequential logic |
| `rst`  | Resets system state | synchronous or asynchronous | Initialization          |
