module comparator (
    input [3:0] in_data_1,
    input [3:0] in_data_2,
    output result
);


assign result = (in_data_1 == in_data_2);

endmodule

module test_comparator;

reg [3:0] in_data_1;
reg [3:0] in_data_2;
wire result;

comparator uut (
    .in_data_1(in_data_1),
    .in_data_2(in_data_2),
    .result(result)
);

initial begin
    #5
    in_data_1 = 4'b0001;
    in_data_2 = 4'b0011;

    $display("input 1 = %b | input 2 = %b | result = %b", in_data_1 , in_data_2 , result);

    $finish;
end

endmodule