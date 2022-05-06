`timescale 1ns/100ps
module tb_gamecontroller();
    reg LoggedIn, GameButton, Clk, Rst;
    wire [5:0] FloorBits, CeilingBits;
    wire PlayerPos, GameTick;
    wire [13:0] GameScore;
    wire [3:0] GameState;

    always begin // 2ns
        Clk = 1'b0;
        #1;
        Clk = 1'b1;
        #1;
    end

    GameController DUT_GC(LoggedIn, GameButton, FloorBits, CeilingBits, PlayerPos, GameTick, GameState, GameScore, Clk, Rst);

    initial begin
        LoggedIn = 1'b0; GameButton = 1'b0; Rst = 1'b1;
        @(posedge Clk);
        #1 Rst = 0;
        @(posedge Clk);
        #1 Rst = 1;
        @(posedge Clk);
        @(posedge Clk); LoggedIn = 1'b1; 
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk);
        @(posedge Clk); GameButton = 1'b1;
        @(posedge Clk); GameButton = 1'b0;
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
        @(posedge Clk); GameButton = 1'b1;
        @(posedge Clk); GameButton = 1'b0;
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

