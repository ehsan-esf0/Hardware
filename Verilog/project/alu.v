`timescale 1ns / 1ps

module alu (
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire [2:0] op,
    output reg  [3:0] result,
    output reg        carry_out,
    output wire       zero
);

    reg [4:0] ext_result; // 5-bit register to capture arithmetic carry/borrow

    always @(*) begin
        carry_out  = 1'b0;
        ext_result = 5'b0;
        result     = 4'b0;

        case (op)
            3'b000: begin // Addition
                ext_result = {1'b0, a} + {1'b0, b};
                result     = ext_result[3:0];
                carry_out  = ext_result[4];
            end
            3'b001: begin // Subtraction
                ext_result = {1'b0, a} - {1'b0, b};
                result     = ext_result[3:0];
                carry_out  = ext_result[4]; // Borrow
            end
            3'b010: result = a & b;          // Bitwise AND
            3'b011: result = a | b;          // Bitwise OR
            3'b100: result = a ^ b;          // Bitwise XOR
            3'b101: result = a << 1;         // Shift Left
            3'b110: result = a >> 1;         // Shift Right
            3'b111: result = a;              // Pass-through
            default: begin
                result    = 4'b0000;
                carry_out = 1'b0;
            end
        endcase
    end

    // Flag logic
    assign zero = (result == 4'b0000);

endmodule