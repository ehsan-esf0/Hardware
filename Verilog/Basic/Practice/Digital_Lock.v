module Digital_Lock(
    input  key,
    input  reset,
    input  clk,
    output reg lock
);

parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= S0;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        S0: next_state = (key == 1'b1) ? S1 : S0;
        S1: next_state = (key == 1'b0) ? S2 : S0;
        S2: next_state = (key == 1'b1) ? S3 : S0;
        S3: next_state = S0;
        default: next_state = S0;
    endcase
end


always @(*) begin
    lock = (state == S3);
end

endmodule

module Test_Digital_Lock;

reg key;
reg reset;
reg clk;
wire lock;

Digital_Lock uut (
    .key(key),
    .reset(reset),
    .clk(clk),
    .lock(lock)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    reset = 1; key = 0;
    #10 reset = 0;

    #10 key = 1;  
    #10 key = 1; 
    #10 key = 1;  
    #10 key = 0;  

    $display("lock = %b", lock);
    #20 $finish;
end

endmodule

