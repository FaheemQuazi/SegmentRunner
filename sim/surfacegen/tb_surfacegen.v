`timescale 1ns/100ps
module tb_surfacegen();
    reg TransitionTick, MoveTick, Rst;
    reg  [3:0] TransitionDiff;
    wire [5:0] Floor, Ceiling;

    SurfaceGen DUT_SR(TransitionTick, TransitionDiff, Floor, Ceiling, MoveTick, Rst);

    always begin
        MoveTick = 0; 
        #2 ;
        MoveTick = 1;
        #2 ;
    end

    initial begin
        Rst = 1; TransitionTick = 0; TransitionDiff = 4'd3; MoveTick = 0;
        @(posedge MoveTick);
        @(posedge MoveTick);
        #2 Rst = 0;
        @(posedge MoveTick);
        #2 Rst = 1; MoveTick = 1;
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        #1 TransitionTick = 1;
        @(posedge MoveTick);
        #1 TransitionTick = 0;
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        #1 TransitionTick = 1;
        @(posedge MoveTick);
        #1 TransitionTick = 0;
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);
        @(posedge MoveTick);

    end

endmodule




