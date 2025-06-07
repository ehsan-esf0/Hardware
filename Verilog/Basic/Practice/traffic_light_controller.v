module traffic_light_controller (
    input clk,
    input reset,
    output reg red,
    output reg green,
    output reg yellow
);

    parameter RED    = 2'b00;
    parameter GREEN  = 2'b01;
    parameter YELLOW = 2'b10;

    reg [1:0] state, next_state;


    reg [3:0] timer; 

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= RED;
            timer <= 0;
        end else begin
            state <= next_state;
            if (timer == 4'd9)
                timer <= 0;
            else
                timer <= timer + 1;
        end
    end

    always @(*) begin
        case (state)
            RED: if (timer == 4'd9) next_state = GREEN; else next_state = RED;
            GREEN: if (timer == 4'd9) next_state = YELLOW; else next_state = GREEN;
            YELLOW: if (timer == 4'd9) next_state = RED; else next_state = YELLOW;
            default: next_state = RED;
        endcase
    end

    always @(*) begin
        red = 0; green = 0; yellow = 0;
        case(state)
            RED: red = 1;
            GREEN: green = 1;
            YELLOW: yellow = 1;
        endcase
    end

endmodule
