# 🧪 How to Write a Basic Testbench in Verilog

**From Beginner to Advanced — Step-by-Step with Full Example**

---

## ✅ 1. What is a Testbench?

A **Testbench** is a Verilog module used **only for simulation**. It:

* Generates input signals
* Applies test cases
* Monitors output behavior
* Does **not synthesize** (not used in hardware)

---

## 🎯 Why Use a Testbench?

* To **verify** your module works as expected
* Simulate **different input patterns**
* Validate design before synthesis
* View **waveforms** in tools like GTKWave or ModelSim

---

## ⚙️ Basic Testbench Structure

```verilog
`timescale 1ns / 1ps  // Time unit / precision

module tb_my_module;

    // 1. Declare signals
    reg clk;
    reg rst;
    reg [7:0] data_in;
    wire [7:0] data_out;

    // 2. Instantiate the Unit Under Test (UUT)
    my_module uut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .data_out(data_out)
    );

    // 3. Clock generation
    always #5 clk = ~clk;  // Toggle every 5 ns → 10 ns clock period

    // 4. Stimulus block
    initial begin
        // Initial values
        clk = 0;
        rst = 1;
        data_in = 8'd0;

        // Apply reset
        #10 rst = 0;

        // Apply test inputs
        #10 data_in = 8'd42;
        #20 data_in = 8'd100;
        #30 data_in = 8'd255;

        // End simulation
        #100 $finish;
    end

endmodule
```

---

## 📘 Explanation of Each Part

| Part            | Purpose                                       |
| --------------- | --------------------------------------------- |
| `reg`           | Used for inputs (because we drive them in TB) |
| `wire`          | Used for outputs                              |
| `uut`           | The actual module under test                  |
| `initial` block | Time-based stimulus generation                |
| `always` block  | Clock signal generator                        |

---

## 🧠 Advanced Tips

### 🔍 Display values in the console:

```verilog
initial begin
    $monitor("Time=%0t clk=%b rst=%b data_in=%d data_out=%d", $time, clk, rst, data_in, data_out);
end
```

### 💾 Generate waveform (for GTKWave or ModelSim):

```verilog
initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, tb_my_module);
end
```

* Use `gtkwave wave.vcd` to view the signal activity.

---

## ⚡ Compile and Run Simulation (Icarus Verilog)

```bash
iverilog -o test tb_my_module.v my_module.v
vvp test
```

* This generates a VCD file if you included `$dumpfile`.
* View with `gtkwave wave.vcd`.

---

## 📌 Summary: Steps to Build a Testbench

1. Declare all signals (`reg` for inputs, `wire` for outputs)
2. Instantiate the module you want to test
3. Add a clock generator if needed
4. Use `initial` block to write stimulus (input values over time)
5. Use `$monitor`, `$display`, or `$dumpvars` to observe behavior
6. Run simulation with Icarus, ModelSim, etc.
