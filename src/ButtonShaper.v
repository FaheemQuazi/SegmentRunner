// ECE 5440
// Author: Faheem Quazi (1586686)
// Module: ButtonShaper
// Description: Generate Single-Cycle Pulse from digital input (button)

module ButtonShaper(Bin, Bout, Clk, Rst);
    // physical IO
    input Bin, Clk, Rst; // Bin = Active LOW / Rst = Active LOW
    output Bout;
    reg Bout;

    // FSM setup
    parameter INIT=0, PULSE=1, WAIT=2;
    reg [1:0] State, StateNext;

    // CombLogic
    always @(State, Bin) begin
        case (State)
            INIT: begin
                Bout = 1'b0;
                if (Bin == 1'b0)
                    StateNext = PULSE;
                else
                    StateNext = INIT;
            end
            PULSE: begin
                Bout = 1'b1;
                StateNext = WAIT;
            end
            WAIT: begin
                Bout = 1'b0;
                if (Bin == 1'b1)
                    StateNext = INIT;
                else
                    StateNext = WAIT; 
            end
        endcase
    end

    // StateReg
    always @(posedge Clk) begin
        if (Rst == 1'b0)
            State <= INIT;
        else
            State <= StateNext;
    end
endmodule
