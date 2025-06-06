## 🧠 Difference Between `assign` and `initial`


| Feature           | `assign` (Continuous Assignment)     | `initial` (Initialization Block)            |
| ----------------- | ------------------------------------ | ------------------------------------------- |
| Purpose           | Describes **combinational logic**    | Used **once at simulation start**           |
| Execution         | **Continuously active**              | Runs **only once**                          |
| Common Use Case   | In RTL design (hardware description) | In testbenches and initial setup            |
| Data Type Used On | Only works with `wire`               | Usually used with `reg` or memory variables |
| Synthesizable     | ✅ Yes (for hardware logic)           | ❌ No (simulation-only)                      |

---

## ✳️ `assign` Statement

### ✅ Definition

The `assign` statement is used to define **combinational logic** that continuously updates based on inputs.

### ✅ Syntax

```verilog
assign <wire_signal> = <expression>;
```

### ✅ Simple Example

```verilog
wire a, b, c;
assign c = a & b;  // c always equals a AND b
```

### ✅ Key Points

* Can only be used with `wire` types.
* Executes **continuously** whenever the right-hand expression changes.
* Cannot be used inside `always` blocks.

### ✅ Advanced Example: Half Adder

```verilog
module half_adder (
    input  wire a,
    input  wire b,
    output wire sum,
    output wire carry
);
    assign sum   = a ^ b;
    assign carry = a & b;
endmodule
```

---

## 🔄 `initial` Block

### ✅ Definition

The `initial` block is used to **run code once** at the **start of simulation**.

### ✅ Syntax

```verilog
initial begin
    // Code that runs once at time zero
end
```

### ✅ Use Cases

* Initialize `reg` variables
* Print debug info (`$display`, `$monitor`)
* Generate a test clock
* Stop simulation (`$finish`, `$stop`)

### ✅ Simple Example

```verilog
reg clk = 0;

initial begin
    clk = 0;
end
```

### ✅ Clock Generation Example

```verilog
reg clk = 0;

initial begin
    forever #5 clk = ~clk;  // Clock with 10 time unit period
end
```

### ✅ Full Testbench Example

```verilog
module testbench;
    reg a, b;
    wire sum, carry;

    half_adder ha(.a(a), .b(b), .sum(sum), .carry(carry));

    initial begin
        $monitor("Time=%0t a=%b b=%b sum=%b carry=%b", $time, a, b, sum, carry);
        a = 0; b = 0;
        #10;
        a = 0; b = 1;
        #10;
        a = 1; b = 0;
        #10;
        a = 1; b = 1;
        #10;
        $finish;
    end
endmodule
```

---

## 🆚 Professional Comparison

| Category            | `assign`          | `initial`                         |
| ------------------- | ----------------- | --------------------------------- |
| RTL Design          | ✅ Yes             | ❌ No (use reset logic instead)    |
| Testbench           | ❌ Not common      | ✅ Main use case                   |
| Simulation Behavior | Runs continuously | Executes once at time zero        |
| Use with `always`   | ❌ Not allowed     | ✅ Can be used alongside           |
| Type restriction    | Requires `wire`   | Typically used with `reg`, memory |

---

## ⚠️ Important Notes

1. `assign` works **only** with `wire`.
2. `initial` blocks are **simulation-only**. They are **not synthesizable** in real hardware.
3. Use `initial` for setting up testbenches and default values.
4. Don't use `assign` inside `always` blocks — it's a syntax error.

---

## 🎯 Summary: When to Use Which?

| Goal                         | Use This                  |
| ---------------------------- | ------------------------- |
| Describe combinational logic | `assign`                  |
| Set initial values           | `initial`                 |
| Write testbenches            | `initial`, `always`       |
| Create memory or registers   | `reg` with `always` block |
