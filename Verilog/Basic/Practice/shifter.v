module shifter (
    input clk,
    input rest,
    input [7:0] data_in,
    input shift_en,
    input shifter,
    output reg [7:0] data_out
);

//data_out = [7] [6] [5] [4] [3] [2] [1] [0]
//           MSB                            LSB

always @(posedge clk or posedge rest) begin
    if (rest) begin
        data_out <= 8'b00000000;
    end 
    else if (shift_en) begin
        if (shifter) begin // shift right
            data_out <= {data_out[0], data_out[7:1]};
            end
            else begin // shift left
            data_out <= {data_out[6:0], data_out[7]};
            end
    end
end

endmodule

module test_shifter;

reg clk;
reg rest;
reg [7:0] data_in;
reg shift_en;
reg shifter; // 0: left, 1: right
wire [7:0] data_out;

shifter uut (
    .clk(clk),
    .rest(rest),
    .data_in(data_in),
    .shift_en(shift_en),
    .shifter(shifter),
    .data_out(data_out)
);


initial begin
    clk = 0;
    forever #5 clk = ~clk;
end


initial begin
    $dumpfile("shifter.vcd");
    $dumpvars(0, test_shifter);
end


initial begin
    
    rest = 1;
    shift_en = 0;
    shifter = 0;
    data_in = 8'b11110000;
    #10;

    rest = 0;
    force uut.data_out = data_in; 
    #10;
    release uut.data_out;

    shift_en = 1;
    shifter = 0;
    #30;

    shifter = 1;
    #20;

    shift_en = 0;
    #10;
    $finish;
end


initial begin
    $monitor("Time=%0t | rest=%b | shifter=%b | shift_en=%b | data_out=%b", 
             $time, rest, shifter, shift_en, data_out);
end

endmodule
