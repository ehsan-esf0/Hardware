# 📘 `integer`, `real`, and `reg`

---

## 🔹 1. `integer` Variables

### ✅ Definition:

* Stores **signed integer** values.
* Default size is **32 bits** (may vary by simulator).
* Used **only in procedural blocks** (`initial`, `always`).
* Not synthesizable (simulation-only).

### ✅ Syntax:

```verilog
integer counter;
```

### ✅ Example:

```verilog
integer i;
initial begin
  for (i = 0; i < 10; i = i + 1)
    $display("i = %d", i);
end
```

### ✅ Use Cases:

* Loop counters
* Temporary variables in simulations
* Returning integer values from functions

---

## 🔹 2. `real` Variables

### ✅ Definition:

* Stores **floating-point** (decimal) numbers.
* Typically **64-bit** precision.
* **Not synthesizable** – simulation-only.

### ✅ Syntax:

```verilog
real voltage, current;
```

### ✅ Example:

```verilog
real power;
initial begin
  power = 3.3 * 0.02;
  $display("Power = %f", power);
end
```

### ✅ Use Cases:

* Analog/digital modeling
* DSP simulation
* Physics-based calculations (e.g., temperature, voltage)

---

## 🔹 3. `reg` Variables

### ✅ Definition:

* Stores **binary data** (0, 1, x, z).
* Can be sized explicitly (`reg [7:0]`).
* **Synthesizable** – used in hardware design.

### ✅ Syntax:

```verilog
reg [7:0] data;
```

### ✅ Use Cases:

* Registers and storage elements in digital design
* Control signals
* Sequential logic

---

## 🔸 4. Summary Table

| Feature          | `reg`            | `integer`          | `real`            |
| ---------------- | ---------------- | ------------------ | ----------------- |
| Type             | Binary (0/1/x/z) | Signed Integer     | Floating-Point    |
| Bit-width        | User-defined     | 32-bit (default)   | 64-bit (typical)  |
| Synthesizable?   | ✅ Yes            | ❌ No               | ❌ No              |
| Procedural Only? | ✅ Yes            | ✅ Yes              | ✅ Yes             |
| Use in Loops     | ❌ Not preferred  | ✅ Common           | ❌ Rare            |
| Use in Modeling  | ✅ Logic design   | ✅ Simulation logic | ✅ Simulation only |

---

## 🔍 Example Comparison

```verilog
module example;
  reg [7:0] data;     // 8-bit register
  integer i;          // loop counter
  real power;         // simulation float value

  initial begin
    data = 8'b10101010;
    for (i = 0; i < 8; i = i + 1)
      $display("Bit %d = %b", i, data[i]);

    power = 3.3 * 0.01;
    $display("Power = %f", power);
  end
endmodule
```

---

## ✅ Key Notes:

* Use `reg` for actual hardware (synthesizable logic).
* Use `integer` and `real` for simulation purposes only.
* Avoid using `real` in logic designs — it's not hardware-compatible.
* Prefer `reg [n:0]` if you want a specific bit-width in synthesizable designs.
