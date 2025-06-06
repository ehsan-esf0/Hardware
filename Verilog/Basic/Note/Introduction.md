## 1. **Module**

* A module is the basic building block in Verilog.
* It can represent a simple or complex circuit.
* Every module has inputs and outputs to communicate with the outside.
* Similar to a "function" or "class" in programming, but for hardware description.

### Simple Module Example

```verilog
module AND_Gate (
    input a,    // input a
    input b,    // input b
    output y    // output y
);
    assign y = a & b;  // output y is the AND of inputs a and b
endmodule
```

---

## 2. **Ports: Input and Output**

* **input**: signals coming into the module.
* **output**: signals going out from the module.
* **inout**: bidirectional signals (used less often).

Example of a simple OR gate:

```verilog
module OR_Gate (
    input a,
    input b,
    output y
);
    assign y = a | b;
endmodule
```

---

## 3. **wire and reg**

### a) `wire`:

* Used to connect different parts of the circuit.
* It behaves like a physical wire.
* Typically used in combinational logic.

### b) `reg`:

* Used to store a value (like a memory element).
* Its value can be changed inside `always` blocks.
* Used mainly in sequential logic.

---

### Example:

```verilog
module example(
    input clk,
    input a,
    output reg q
);
    always @(posedge clk) begin
        q <= a;  // At positive edge of clk, store a in q
    end
endmodule
```

Here, `q` is declared as `reg` because it holds its value between clock cycles.

---

## 4. **assign**

* Used to continuously assign a value to a `wire`.
* Used in combinational logic to define output.

```verilog
assign y = a & b;  // y is always a AND b
```

---

## 5. **always**

* `always` blocks describe behavior that happens either sequentially (with clock) or combinationally (whenever inputs change).
* Inside `always`, you can use control statements like if, case, loops, etc.

### Sequential example (D flip-flop):

```verilog
always @(posedge clk) begin
    q <= d;  // At clock’s rising edge, q gets d
end
```

### Combinational example:

```verilog
always @(a or b) begin
    y = a | b;
end
```

or equivalently

```verilog
always @(*) begin
    y = a | b;  // y updates whenever a or b changes
end
```

---

## 6. **Operators**

| Operator | Meaning          | Example    |     |     |
| -------- | ---------------- | ---------- | --- | --- |
| `&`      | Bitwise AND      | `a & b`    |     |     |
| \`       | \`               | Bitwise OR | \`a | b\` |
| `^`      | Bitwise XOR      | `a ^ b`    |     |     |
| `~`      | Bitwise NOT      | `~a`       |     |     |
| `+`      | Addition         | `a + b`    |     |     |
| `-`      | Subtraction      | `a - b`    |     |     |
| `*`      | Multiplication   | `a * b`    |     |     |
| `==`     | Equality check   | `a == b`   |     |     |
| `!=`     | Inequality check | `a != b`   |     |     |

Example:

```verilog
assign sum = a + b;       // sum of a and b
assign equal = (a == b);  // is a equal to b?
```

---

## 7. **Conditional Statements**

* Use `if-else` and `case` inside `always` blocks for logic decisions.

### if-else example

```verilog
always @(*) begin
    if (a > b)
        y = a;
    else
        y = b;
end
```

### case example

```verilog
always @(*) begin
    case (sel)
        2'b00: y = a;
        2'b01: y = b;
        2'b10: y = c;
        default: y = 0;
    endcase
end
```

---

## 8. **Parameters**

* Parameters are constants that can be set when instantiating a module.
* Useful for making modules configurable.

Example:

```verilog
module counter #(parameter WIDTH = 8) (
    input clk,
    input rst,
    output reg [WIDTH-1:0] count
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 0;
        else
            count <= count + 1;
    end
endmodule
```

---

## 9. **Testbench**

* A separate module used to test your design.
* Has no inputs or outputs.
* Drives inputs and observes outputs.

### Simple testbench for AND Gate

```verilog
module testbench;
    reg a, b;
    wire y;

    AND_Gate uut (
        .a(a),
        .b(b),
        .y(y)
    );

    initial begin
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;  // end simulation
    end
endmodule
```

