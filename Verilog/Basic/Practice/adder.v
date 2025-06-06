module adder (
    input [7:0] a, b,
    output [7:0] sum, 
    output carry_out
);

assign {carry_out, sum} = a + b;
  
endmodule

module test_adder;
reg [7:0] a, b;
wire [7:0] sum;
wire carry_out;

adder myadder (
    .a(a),
    .b(b),
    .sum(sum), 
    .carry_out(carry_out)
);

initial begin
    a = 8'h10;
    b = 8'h20;
    #10;
    a = 8'h30;
    b = 8'h40;
    #10;
    a = 8'h50;
    b = 8'h60;
    #10;
    a = 8'h70;
    b = 8'h80;
    #10;
    a = 8'h90;
    b = 8'hA0;
    #10;
    a = 8'hB0;
    #10
    a = 8'd10;
    b = 8'd10;
    #10;
end

initial begin
    $monitor("a = %d, b = %d, sum = %d, carry_out = %b", a, b, sum, carry_out);
end


endmodule

