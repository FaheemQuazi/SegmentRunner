module SurfaceGen(TransitionTick, TransitionDiff, Floor, Ceiling, MoveTick, Rst);
    input TransitionTick, MoveTick, Rst;
    input [3:0] TransitionDiff;
    output [5:0] Floor, Ceiling;

    // Shift Registers for FLoor and Ceiling
    reg FloorIn, CeilIn, SRRst;
    reg [5:0] CeilRstVal, FloorRstVal;
    ShiftReg_6b FloorSR(FloorIn, MoveTick, Floor, SRRst, FloorRstVal);
    ShiftReg_6b CeilSR(CeilIn, MoveTick, Ceiling, SRRst, CeilRstVal);

    // State Machine
    reg [3:0] State;
    reg [3:0] Count;
    reg LastPos; // 0 = floor, 1 = ceil
    parameter NONE=0, TRANSITIONSTART=1, TRANSITION=2, TRANSITIONFIN=3;

    // Resent Handling
    always@(negedge Rst) begin
        FloorRstVal <= 6'b111111;
        CeilRstVal <= 6'b000000;
        FloorIn <= 1'b1;
        CeilIn <= 1'b0;
        LastPos <= 1'b0;
        SRRst <= 1'b0;
        Count <= 0;
        State <= NONE;
    end


    always@(posedge MoveTick) begin
        case (State)
            NONE: begin
                SRRst <= 1'b1;
            end
            TRANSITIONSTART: begin
                if (FloorIn == 1'b1) begin
                    LastPos <= 0;
                end else begin
                    LastPos <= 1;
                end
                FloorIn <= 1;
                CeilIn <= 1;
                Count <= 0;
                State <= TRANSITION;
            end
            TRANSITION: begin
                if (Count < TransitionDiff - 1) begin
                    Count <= Count + 1;
                end else begin
                    if (LastPos <= 1'b0) begin
                        CeilIn <= 1;
                        FloorIn <= 0;
                    end else begin
                        CeilIn <= 0;
                        FloorIn <= 1;
                    end
                    State <= TRANSITIONFIN;
                end
            end
            TRANSITIONFIN: begin
                // one move cycle delay 
                State <= NONE;
            end
            default: begin
                SRRst <= 1'b1;
                State <= NONE;
            end
        endcase
    end

    always@(posedge TransitionTick) begin
        if (State == NONE) State <= TRANSITIONSTART;
    end

endmodule