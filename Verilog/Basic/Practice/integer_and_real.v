module test_module;

integer a, b , i;

initial begin
    a = 100000;
    b = -545252;
    $display("a = %d , b = %d ", a, b);

 
    for (i = 0 ; i < 10 ; i++ ) begin
        $display("i = %d" , i );
    end
end

endmodule



