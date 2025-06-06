# 🔢 Value Assignment in Verilog & Working with Numbers

**Beginner to Professional – Full Guide with Examples**

---

## ✅ 1. Types of Assignment in Verilog

### 📌 1.1. Procedural Assignment (inside `initial` / `always`)

```verilog
reg [3:0] a;
initial a = 4'b1010;  // Binary assignment
```

### 📌 1.2. Continuous Assignment (`assign` for wires)

```verilog
wire [7:0] b;
assign b = 8'd150;
```

---

## 🧠 2. Number Format in Verilog

General syntax:

```verilog
<size>'<base><value>
```

| Part      | Meaning                                                    |
| --------- | ---------------------------------------------------------- |
| `<size>`  | Number of bits (e.g., `8`)                                 |
| `<base>`  | Radix: `b` (binary), `d` (decimal), `h` (hex), `o` (octal) |
| `<value>` | The actual value                                           |

---

### 📘 Examples

| Code       | Meaning                            |
| ---------- | ---------------------------------- |
| `4'b1010`  | 4-bit binary number (value: 10)    |
| `8'd255`   | 8-bit decimal (value: 255)         |
| `16'h1F3A` | 16-bit hexadecimal (value: 0x1F3A) |
| `6'o77`    | 6-bit octal (value: 63)            |

---

## ⚠️ 3. Special Values: `x` and `z`

| Symbol | Meaning                    |
| ------ | -------------------------- |
| `x`    | Unknown / undefined value  |
| `z`    | High impedance (tri-state) |

```verilog
reg [3:0] a = 4'bxx01;
wire b = 1'bz;
```

---

## ➕ 4. Signed vs Unsigned Numbers

By default, numbers are **unsigned** in Verilog.

To define **signed** values:

```verilog
reg signed [7:0] a = -5;
```

> ⚠️ Mixing signed and unsigned types requires caution and sometimes conversion using `$signed()` or `$unsigned()`.

---

## 🎛️ 5. Initial Assignment in Testbenches

```verilog
initial begin
  a = 4'd5;
  b = 8'hFA;
  c = 3'b101;
end
```

---

## 🔁 6. Overflow and Truncation

Verilog **doesn’t automatically warn** about overflow:

```verilog
reg [3:0] x = 4'd15;  // OK
x = 4'd16;            // Overflow! x becomes 0

reg [3:0] y = 4'd20 + 4'd3;  // y = 7 (23 mod 16)
```

---

## 📏 7. Bit Extension and Truncation

### ✅ Zero extension:

```verilog
reg [3:0] a = 4'b1010;
reg [7:0] b = {4'b0000, a};  // b = 00001010
```

### ✅ Sign extension:

```verilog
reg signed [3:0] a = -2;         // 4'b1110
reg signed [7:0] b = $signed(a); // b = 11111110
```

---

## 🔧 8. Arithmetic Operators

| Operation      | Symbol | Example  |
| -------------- | ------ | -------- |
| Addition       | `+`    | `a + b`  |
| Subtraction    | `-`    | `a - b`  |
| Multiplication | `*`    | `a * b`  |
| Division       | `/`    | `a / b`  |
| Modulus        | `%`    | `a % b`  |
| Left shift     | `<<`   | `a << 2` |
| Right shift    | `>>`   | `a >> 1` |

---

## 🛠️ 9. Pro Tips

* Always specify the number of bits (`4'd3`, `8'hFA`) to avoid bugs.
* Use `localparam` or `parameter` for constants.
* Combine bits using concatenation `{}` and slicing `[MSB:LSB]`.

---

## ✅ 10. Full Example

```verilog
module example;
  reg signed [7:0] a = -5;
  reg [7:0] b = 8'd25;
  wire signed [8:0] result;

  assign result = a + b;  // -5 + 25 = 20
endmodule
```