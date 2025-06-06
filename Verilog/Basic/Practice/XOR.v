module XOR (
    input a, b ,
    output c
);

assign c = a ^ b;

endmodule

module testXOR;

    reg a; 
    reg b;
    wire c;

    XOR xor1 (
        .a(a),
        .b(b),
        .c(c)
    );

    initial begin
        $monitor("Time = %0t : a = %b, b = %b, c = %b", $time, a, b, c);
        a = 1'b0;
        b = 1'b0;
        #10;
        a = 1'b1;
        b = 1'b0;
        #10;
        a = 1'b0;
        b = 1'b1;
        #10;
        a = 1'b1;
        b = 1'b1;
        #10;
        $finish;
    end


endmodule