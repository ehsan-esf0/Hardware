module register_4bit(
    input [3:0] data_in,
    input clk,
    output reg [3:0] data_out
);

always @(posedge clk)
    data_out <= data_in;
    
endmodule

module test_register_4bit;

reg [3:0] data_in;
reg clk;
wire [3:0] data_out;

register_4bit reg_4bit(
    .data_in(data_in),
    .clk(clk),
    .data_out(data_out)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;  
end

initial begin
    data_in = 4'b0000;
    #10;
    data_in = 4'b0001;
    #10;
    data_in = 4'b1010;
    #10;
    data_in = 4'b1111;
    #10;
    $finish;
end

always @(posedge clk) begin
    #1 $display("Time = %0t | data_in = %b | data_out = %b", $time, data_in, data_out);
end


endmodule