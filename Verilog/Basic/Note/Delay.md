## ⏱️ Types of Delay in Verilog

### 1. **Statement-level delay (timing delay)**

Using `#` to delay an operation in simulation.

#### Example:

```verilog
initial begin
  a = 1;
  #10; // wait for 10 nanoseconds
  b = 2;
end
```

> In this example, `b=2` happens exactly 10ns after `a=1`.

---

### 2. **Delay in continuous assignment**

```verilog
assign #5 y = a & b;
```

> This means `y` will update 5 nanoseconds after any change in `a` or `b`.

---

### 3. **Delay inside always block**

You can also use delay inside an `always` block, but it is **not recommended for real designs**.

#### Example (for learning):

```verilog
always @(a or b) begin
  #2 y = a & b;
end
```

> When `a` or `b` changes, output `y` changes after 2ns delay.

---

## 📌 Note: Difference between delay and clock-driven logic

Delay is only meaningful in **simulation**, but in **real hardware design (FPGA/ASIC)**, behavior is controlled by clocks and registers, not by delays.

---

## ⚠️ Why avoid delay in real designs?

* Synthesis tools like Vivado or Quartus **ignore delays**.
* Real logic design should be based on clock and registers, not delays.
* Delay is only useful for testbenches, simulation, and initial modeling.

---

## ✅ Main uses of delay in Verilog

| Use case                | Description                              |
| ----------------------- | ---------------------------------------- |
| **Testbench**           | Create timing gaps between input signals |
| **Simple simulation**   | Model basic logical timing behavior      |
| **Gate delay modeling** | Simulate propagation delay in gates      |

---

## 🧪 Example testbench with delay

```verilog
initial begin
  a = 0; b = 0;
  #10 a = 1;
  #5  b = 1;
  #10 $finish;
end
```
> The input signals change exactly at the specified simulation times.
