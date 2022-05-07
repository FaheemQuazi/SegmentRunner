`timescale 1ns/100ps
module tb_surfacegen();
    reg TransitionTick, MoveTick, Clk, Rst;
    reg  [3:0] TransitionDiff;
    wire [5:0] Floor, Ceiling;

    SurfaceGen DUT_SR(TransitionTick, TransitionDiff, Floor, Ceiling, MoveTick, Clk, Rst);

    always begin
        Clk = 0;
        #1;
        Clk = 1;
        #1;
    end

    always begin
        MoveTick = 0; 
        #10;
        MoveTick = 1;
        #10;
    end

    initial begin
        Rst = 1; TransitionTick = 0; TransitionDiff = 4'd3; MoveTick = 0;
        @(posedge Clk);
        @(posedge Clk);
        #2 Rst = 0;
        @(posedge Clk);
        #2 Rst = 1;
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        #1 TransitionTick = 1;
        @(posedge Clk);
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
        @(posedge Clk);
        #1 TransitionTick = 0;
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);

    end

endmodule




