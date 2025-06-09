# 📘 Two-Dimensional Arrays

---

## 1. **Definition of 2D Arrays**

* A **two-dimensional array** in Verilog is essentially an array of vectors.
* It can be visualized as a matrix of rows and columns.
* Each element is a **vector** (packed array), and multiple such elements form the **unpacked array**.

---

## 2. **Syntax**

```verilog
reg [7:0] matrix [0:3];  // 4 rows, each 8 bits wide
```

* `matrix` is a 2D array with 4 rows and 8 bits per row.
* The left part `[7:0]` is the **packed dimension** (bit width of each element).
* The right part `[0:3]` is the **unpacked dimension** (number of elements).

---

## 3. **Accessing Elements**

* To access a specific element, use the row index:

```verilog
matrix[2] = 8'hFF;    // Assign 0xFF to the 3rd row
```

* You can also read it the same way:

```verilog
data_out = matrix[2]; // Read the 3rd row
```

---

## 4. **Example: Initializing a 2D Array**

```verilog
module example_2d_array;
  reg [7:0] matrix [0:3];

  initial begin
    matrix[0] = 8'hAA;
    matrix[1] = 8'h55;
    matrix[2] = 8'hFF;
    matrix[3] = 8'h00;

    $display("Row 0: %h", matrix[0]);
    $display("Row 1: %h", matrix[1]);
    $display("Row 2: %h", matrix[2]);
    $display("Row 3: %h", matrix[3]);
  end
endmodule
```

---

## 5. ✅ Example: Simple RAM using a 2D Array

```verilog
module simple_ram (
  input wire clk,
  input wire write_enable,
  input wire [3:0] address,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);
  // 16-word RAM, each word is 8 bits
  reg [7:0] memory [0:15];

  always @(posedge clk) begin
    if (write_enable)
      memory[address] <= data_in;  // Write to memory
    data_out <= memory[address];   // Read from memory
  end
endmodule
```

### 🔍 Notes:

* The memory is declared as a **2D array**: `reg [7:0] memory [0:15];`
* Each memory location (element) is 8 bits.
* Read and write occur on the **same clock edge**.
* In real designs, care should be taken with simultaneous read/write to the same address.

---

## 6. 💡 Common Applications

* RAM / ROM design
* Register files
* Lookup tables
* Matrix-like structures (e.g., image buffers)

---

## 7. 🧠 Summary Table

| Concept            | Description                           |
| ------------------ | ------------------------------------- |
| Declaration        | `reg [width-1:0] array [range];`      |
| Example            | `reg [7:0] mem [0:15];`               |
| Access Syntax      | `mem[index]`                          |
| Use Cases          | RAMs, register files, storage arrays  |
| Synthesis Friendly | ✅ Yes (tools map it to memory blocks) |
| Packed vs Unpacked | Packed = data width, Unpacked = index |

