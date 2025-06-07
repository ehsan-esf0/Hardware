module Multiplexer (
    input [1:0] sel,
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] out
);

always @(*) begin
    case (sel)
        2'b00 : out = a;
        2'b01 : out = b;
        2'b10 : out = c;
        2'b11 : out = d;
        default : out = 8'b00000000;
    endcase
end
    
endmodule

`timescale 1ns / 1ps

module Multiplexer_tb;


    reg [1:0] sel;
    reg [7:0] a, b, c, d;


    wire [7:0] out;


    Multiplexer uut (
        .sel(sel),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .out(out)
    );

    initial begin

        a = 8'hAA; // 10101010
        b = 8'hBB; // 10111011
        c = 8'hCC; // 11001100
        d = 8'hDD; // 11011101

        $display("Time | sel | out");
        $display("---------------");

        sel = 2'b00; #10;
        $display("%4dns | %b  | %h", $time, sel, out);

        sel = 2'b01; #10;
        $display("%4dns | %b  | %h", $time, sel, out);

        sel = 2'b10; #10;
        $display("%4dns | %b  | %h", $time, sel, out);

        sel = 2'b11; #10;
        $display("%4dns | %b  | %h", $time, sel, out);

        $finish;
    end

endmodule
