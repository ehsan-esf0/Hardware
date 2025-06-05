# Data Types in Verilog: `wire` and `reg`

## 1. **wire**

* A `wire` represents a physical connection or wire in hardware.
* Its value **cannot be assigned directly inside `always` blocks**.
* The value of a `wire` is driven by continuous assignments (`assign`) or by outputs of other modules/gates.
* Mainly used in **combinational logic**.

### Characteristics of `wire`:

* Has **continuous assignment**: its value is always driven by some source.
* Can be connected to multiple sources, behaving like an electrical bus.
* Cannot be assigned a value inside `always` or `initial` blocks.

### Example:

```verilog
wire a, b, c;

assign c = a & b;  // c is always the AND of wires a and b
```

---

## 2. **reg**

* A `reg` acts like a variable that **can hold and store values**.
* Its value **can be changed inside `always` or `initial` blocks**.
* Typically used for **sequential logic** or anywhere a value needs to be stored.
* Despite the name `reg`, it doesn’t necessarily imply a hardware register but means it can hold a value over time.

### Characteristics of `reg`:

* Assigned values only inside `always` or `initial` blocks.
* Keeps its value between clock cycles.
* Used for flip-flops, latches, or internal variables.

### Example:

```verilog
reg q;

always @(posedge clk) begin
    q <= d;  // On the clock’s rising edge, q stores the value of d
end
```

---

## 3. **Key Differences**

| Feature                  | `wire`                     | `reg`            |
| ------------------------ | -------------------------- | ---------------- |
| Can assign in `always`?  | No                         | Yes              |
| Usage type               | Physical connection (wire) | Storage variable |
| Common use               | Combinational logic        | Sequential logic |
| Assigned with `assign`   | Yes                        | No               |
| Assigned inside `always` | No                         | Yes              |

---

## 4. **Example Module Using Both**

```verilog
module example(
    input clk,
    input d,
    output q
);
    wire temp;      // wire for combinational logic
    reg q_reg;      // reg for storing value

    assign temp = d & 1'b1;  // simple combinational logic

    always @(posedge clk) begin
        q_reg <= temp;       // update q_reg at clock edge
    end

    assign q = q_reg;        // output q gets stored value
endmodule
```

---

# What is `<=` in Verilog?

## 1. **Non-blocking assignment (`<=`)**

* `<=` is called a **non-blocking assignment**.
* Mostly used inside **sequential blocks** like `always @(posedge clk)`.
* When you write `a <= b;`, it means the new value of `a` will be updated **at the end of the current simulation time step**, not immediately.
* This allows multiple assignments in the same clock cycle to update simultaneously, without depending on the order of the statements.

---

## 2. Difference Between `<=` and `=`

| Assignment Type | Operator | Explanation                                                                                   |
| --------------- | -------- | --------------------------------------------------------------------------------------------- |
| Non-blocking    | `<=`     | New value updates at the end of the block; good for sequential logic                          |
| Blocking        | `=`      | Value updates immediately; next statements wait for this update; good for combinational logic |

---

## 3. Example

Suppose we want to swap two registers simultaneously on a clock edge:

```verilog
always @(posedge clk) begin
    a <= b;   // non-blocking assignment
    b <= a;
end
```

* Here, `a` gets the old value of `b`.
* `b` gets the old value of `a`.
* Both update at the same time, as expected.

If we use blocking assignment `=` instead:

```verilog
always @(posedge clk) begin
    a = b;    // blocking assignment
    b = a;
end
```

* First, `a` gets `b`.
* Then, `b` gets the **new value of `a`** (which is now equal to `b`).
* Result is not a proper swap and usually incorrect.

---

## 4. Important Notes

* Use `<=` **non-blocking** assignments in **sequential logic** (flip-flops, registers).
* Use `=` **blocking** assignments in **combinational logic** (`always @(*)` blocks).
* Following these guidelines helps create predictable and correct hardware behavior.
