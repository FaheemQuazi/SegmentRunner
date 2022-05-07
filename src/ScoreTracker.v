// Author: Zain Bhatti, 0374
// Score Tracking module
// Module for keeping track of player scores and high score
module ScoreTracker(clk, rst, score_req, playerID, isGuest, Score, personal_winner, global_winner);
    input clk, rst;
    input isGuest;
    input [4:0] playerID;
    input [3:0] score_req;
    input [13:0] Score;
    output personal_winner, global_winner;
    reg personal_winner, global_winner;

    parameter RAMINIT = 0, WAITSCORE = 1, RAMFETCH = 2, RAMFETCH1 = 3, RAMFETCH2 = 4, RAMCATCH = 5, COMPARE = 6, RAMWRITE = 7, GLOBALCHECK = 8, WAITGAME = 9;

    reg [13:0] Player_score, Global_score, RAM_Data;
    reg [3:0] State;
    reg [4:0] Player_ID;
    reg [1:0] WinningPlayer;
    reg [1:0] counter;
    reg resetflag;

    reg read_write;
    reg [4:0] RAM_addr;
    reg [13:0] RAM_out;

    wire [13:0] RAM_in;

    RAM_SCORE GAME_SCORES(RAM_addr, clk, RAM_out, read_write, RAM_in);

    always @(posedge clk) begin
        if (rst == 1'b0) begin
            Global_score <= 14'b00000000000000;
            WinningPlayer <= 2'b00;
            personal_winner <= 1'b0;
            global_winner <= 1'b0;
            counter <= 2'b00;
            read_write <= 1'b0;
            RAM_addr <= 5'b00000;
            RAM_out <= 14'b00000000000000;
            State <= RAMINIT;
          end
        else
          begin
            case (State)
              RAMINIT: begin
                  read_write <= 1'b1;
                  RAM_addr <= {3'b000, counter};
                  RAM_out <= 14'b00000000000000;
                  counter <= counter + 1;
                  if (counter == 2'b11) begin
                      read_write <= 1'b0;
                      State <= WAITSCORE;
                    end
                end
              WAITSCORE: begin
                  if (score_req == 5) begin
                      if (isGuest == 1'b1) begin
                          State <= WAITGAME;
                        end
                      else
                        begin
                          Player_score <= Score;
                          Player_ID <= playerID;
                          State <= RAMFETCH;
                        end
                    end
                  else
                    begin
                      State <= WAITSCORE;
                    end
                end
              RAMFETCH: begin
                  RAM_addr <= Player_ID;
                  read_write <= 1'b0;
                  State <= RAMFETCH1;
                end
              RAMFETCH1: begin
                  State <= RAMFETCH2;
                end
              RAMFETCH2: begin
                  State <= RAMCATCH;
                end
              RAMCATCH: begin
                  RAM_Data <= RAM_in;
                  State <= COMPARE;
                end
              COMPARE: begin
                  if (Player_score > RAM_Data) begin
                      RAM_out <= Player_score;
                      personal_winner <= 1'b1;
                      State <= RAMWRITE;
                    end
                  else
                    begin
                      personal_winner <= 1'b0;
                      State <= GLOBALCHECK;
                    end
                end
              RAMWRITE: begin
                  read_write <= 1'b1;
                  State <= GLOBALCHECK;
                end
              GLOBALCHECK: begin
                  if (Player_score > Global_score) begin
                      Global_score <= Player_score;
                      WinningPlayer <= Player_ID;
                      global_winner <= 1'b1;
                    end
                  else
                    begin
                      global_winner <= 1'b0;
                    end
                  State <= WAITGAME;
                end
              WAITGAME: begin
                  read_write <= 1'b0;
                  if (score_req != 5) begin
                      personal_winner <= 1'b0;
                      global_winner <= 1'b0;
                      State <= WAITSCORE;
                    end
                  else
                    begin
                      State <= WAITGAME;
                    end
                end
              default: begin
                  RAM_addr <= 5'b00000;
                  personal_winner <= 1'b0;
                  global_winner <= 1'b0;
                  Player_score <= 14'b00000000000000;
                  read_write <= 1'b0;
                  State <= WAITSCORE;
                end
            endcase
        end
      end
endmodule