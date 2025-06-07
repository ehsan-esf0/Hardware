module Register (
    input clk,
    input reset,
    input enable,
    input [7:0] d,
    output reg [7:0] q
);

always @(posedge clk) begin
    if ( reset ) begin
        q <= 0;
    end
    else if ( enable ) begin
        q <= d;
    end 
    else begin
        q <= q;
    end
end

endmodule


`timescale 1ns / 1ps

module Register_tb;

    reg clk;
    reg reset;
    reg enable;
    reg [7:0] d;
    wire [7:0] q;


    Register uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .d(d),
        .q(q)
    );

  
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  
    end

    initial begin
       
        reset = 1;
        enable = 0;
        d = 8'h00;

        $display("Time | reset | enable | d    | q");
        $display("-------------------------------");

        #10;
        reset = 0;  
        d = 8'hAA;  

        #10;
        enable = 1; 

        #10;
        d = 8'hBB;   

        #10;
        enable = 0; 

        #10;
        d = 8'hCC;   

        #30;

        $finish;
    end

    always @(posedge clk) begin
        $display("%4dns |   %b   |   %b    | %h | %h", $time, reset, enable, d, q);
    end

endmodule
