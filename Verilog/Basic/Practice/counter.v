module counter(
    input clk,
    input rst,
    output reg [7:0] count
);

always @ (posedge clk or posedge rst) begin
    if (rst)
        count <= 8'b0;
    else
        count <= count + 1'b1;
end

endmodule

module test_counter;
    
reg clk;
reg rst;
wire [7:0] count;

counter c1(
    .clk(clk), 
    .rst(rst), 
    .count(count)
);

initial begin
    clk = 0;
    forever #1 clk = ~clk;
end

initial begin
    rst = 1'b1;  
    #5 
    rst = 1'b0; 
    #20
    rst = 1'b1;
    #10
    rst = 1'b0;
    #50 
    $finish;  
end

initial begin
    $monitor("Time = %0t | rst = %b | count = %d", $time, rst, count);
end

endmodule