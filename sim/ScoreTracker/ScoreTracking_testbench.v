`timescale 1 ns/100 ps
module ScoreTracking_testbench( );
    reg clk, rst;
    reg [1:0] playerID;
    reg [3:0] score_req;
    reg [13:0] Score;
    wire personal_winner, global_winner;
    
    always
      begin
        clk = 1'b0;
        #10;
        clk = 1'b1;
        #10;
      end
    
    ScoreTracker GameScoring_DUT(clk, rst, score_req, playerID, Score, personal_winner, global_winner);
    
    initial
      begin
        rst = 1'b1;
        score_req = 0;
        playerID = 2'b00;
        Score = 8'b00000000;
        @(posedge clk);
        @(posedge clk);
        #5 rst = 1'b0;
        @(posedge clk);
        @(posedge clk);
        #5 rst = 1'b1;
        @(posedge clk);
        @(posedge clk);
        #5 Score = 100; playerID = 2'b01;
        @(posedge clk);
        #5 score_req = 5;
        @(posedge clk);
        @(posedge clk);
        #5 score_req = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        #5 Score = 88; playerID = 2'b01;
        @(posedge clk);
        #5 score_req = 5;
        @(posedge clk);
        #5 score_req = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        #5 Score = 102; playerID = 2'b10;
        @(posedge clk);
        #5 score_req = 5;
        @(posedge clk);
        #5 score_req = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);    
      end

endmodule
