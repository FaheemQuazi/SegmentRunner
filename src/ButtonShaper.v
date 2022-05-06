// ECE 5440 - 14387 Advanced Digital Design, Dr. Yuhua Chen 
// Author: Arash Shariatzadeh, 0099
// ButtonShaper.v
// This module serves as the button shaper that converts the long low pulse when a button signal B_in is
// pressed to a single cycle high pulse B_out to be used as an input for other modules that require
// interface to the user in the form of push-buttons. Implemented via Two-Procedure FSM. 
module ButtonShaper (B_in, B_out, clk, rst);
    input B_in;
    output B_out;
    input clk, rst;
    reg B_out;

    parameter INIT = 0, PULSE = 1, WAIT = 2;
    reg[1:0] State, StateNext;
    // State Combinational Logic Procedure
    always@(State, B_in) begin
        case(State)
            INIT: begin
                B_out = 1'b0;
                if (B_in == 1'b0)
                    StateNext = PULSE;
                else
                StateNext = INIT;
                end
            PULSE: begin
                B_out = 1'b1;
                StateNext = WAIT;
            end
            WAIT: begin
                B_out = 1'b0;
                if (B_in == 1'b1)
                    StateNext = INIT;
                else
                    StateNext = WAIT;
            end
            default: begin
                B_out = 1'b0;
                StateNext = INIT;
            end
        endcase
    end
    // State Register (Sequential)
    always@(posedge clk) begin
        if (rst == 0)
            State <= INIT;
        else
            State <= StateNext;
    end
endmodule
