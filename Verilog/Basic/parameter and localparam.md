# 🧩 Understanding `parameter` and `localparam` in Verilog

*From Beginner to Advanced — with Full Syntax and Use Cases*

---

## 🔹 1. What is a `parameter`?

### ✅ Definition:

A **`parameter`** is a **constant** that defines configurable values inside a Verilog module.
It allows you to **customize** modules during **instantiation** without rewriting code.

---

### ✅ Common Uses:

* Setting **bus width**
* Defining **memory depth**
* Creating **reusable and scalable designs**
* Customizing behavior (like counters, FIFOs, ALUs)

---

### 📘 Basic Example:

```verilog
module my_reg #(parameter WIDTH = 8) (
    input  wire [WIDTH-1:0] d,
    output reg  [WIDTH-1:0] q
);
    always @(*) q = d;
endmodule
```

When instantiated:

```verilog
my_reg #(16) r1 (.d(data_in), .q(data_out));  // WIDTH = 16
```

Or with named parameter:

```verilog
my_reg #(.WIDTH(32)) r2 (.d(din), .q(dout));  // WIDTH = 32
```

---

## 🔹 2. What is `localparam`?

### ✅ Definition:

A **`localparam`** is a **local constant** that **cannot** be changed during instantiation.

---

### 🧠 Key Difference:

| Feature                          | `parameter` | `localparam` |
| -------------------------------- | ----------- | ------------ |
| Overridable during instantiation | ✅ Yes       | ❌ No         |
| Useful for public config         | ✅ Yes       | ⛔ No         |
| Used for internal constants      | ❌ Risky     | ✅ Yes        |
| Good for expressions             | ✅ Yes       | ✅ Yes        |

---

### 📘 Example:

```verilog
module counter #(parameter WIDTH = 4) (
    input wire clk,
    output reg [WIDTH-1:0] count
);

    localparam MAX = (1 << WIDTH) - 1;

    always @(posedge clk) begin
        if (count == MAX)
            count <= 0;
        else
            count <= count + 1;
    end

endmodule
```

* `WIDTH` is configurable
* `MAX` is **internally fixed** and cannot be overridden

---

## 🔹 Syntax Tips

### ✅ Multiple Parameters:

```verilog
module fifo #(
    parameter WIDTH = 8,
    parameter DEPTH = 16
) (
    input wire clk,
    ...
);
```

### ✅ Parameter Expressions:

```verilog
parameter N = 4;
parameter SIZE = 2 * N;
```

### ✅ Using `$clog2` (SystemVerilog):

```verilog
parameter DEPTH = 64;
parameter ADDR_WIDTH = $clog2(DEPTH);  // log2 for address width
```

> 🚨 `$clog2` is a **SystemVerilog** feature. Some tools may not support it in plain Verilog.

---

## 🔹 How to Avoid Hardcoding

❌ Bad practice:

```verilog
reg [7:0] data;  // hardcoded 8-bit width
```

✅ Good practice:

```verilog
parameter WIDTH = 8;
reg [WIDTH-1:0] data;
```

---

## 🔹 Summary Table

| Feature                   | `parameter`                | `localparam` |
| ------------------------- | -------------------------- | ------------ |
| Can be overridden?        | ✅ Yes                      | ❌ No         |
| Internal-only use?        | ⚠️ Yes (but not protected) | ✅ Perfect    |
| Allows expressions?       | ✅ Yes                      | ✅ Yes        |
| Useful for module config? | ✅ Yes                      | ❌ No         |

---

