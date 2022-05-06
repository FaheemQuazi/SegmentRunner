module GameController(LoggedIn, GameButton, FloorBits, CeilingBits, PlayerPos, GameTick, GameState, GameScore, Clk, Rst);
    input LoggedIn, GameButton, Clk, Rst;
    output [5:0] FloorBits, CeilingBits;
    output PlayerPos, GameTick;
    output [13:0] GameScore;
    reg PlayerPos;
    reg [13:0] GameScore;

    reg [3:0] SG_TransitionDiff;
    reg SG_TransitionTick;

    reg TR_Enable, TR_Clear;
    reg [9:0] TR_CfgValue;

    wire GTick;
    Timer_rc TR_Game(TR_Enable, TR_Clear, TR_CfgValue, GTick, Clk, Rst);
    SurfaceGen SG_Game(SG_TransitionTick, SG_TransitionDiff, FloorBits, CeilingBits, GTick, Clk, Rst);

    // RNG
    reg [15:0] RNG_Thresh;
    reg RNG_Enable;
    wire [15:0] RNG_Q;
    LFSR_16b Raaaandom(RNG_Q, RNG_Enable, Clk, Rst);

    // FSM
    output [3:0] GameState;
    reg [3:0] GameState;
    parameter LOGGEDOUT=4'd0, GAMEWAIT=4'd1, GAMESTART=4'd2, GAMEPLAY=4'd3, GAMEJUMP=4'd4, GAMEEND=4'd5;

    always@(posedge Clk) begin
        if (Rst == 1'b0) begin
            PlayerPos <= 0;
            GameScore <= 14'd0;
            SG_TransitionDiff <= 4'd4;
            SG_TransitionTick <= 1'b0;
            TR_Enable <= 1'b0;
            TR_Clear <= 1'b0;
            TR_CfgValue <= 10'd300;
            RNG_Thresh <= 16'b1000000010000000; // approx 25% 
            RNG_Enable <= 1'b1;
            GameState <= LOGGEDOUT;
        end else begin
            if (LoggedIn == 1'b0) begin
                GameState <= LOGGEDOUT;
            end
            case (GameState)
                LOGGEDOUT: begin
                    // sit idle
                    SG_TransitionDiff <= 4'd4;
                    SG_TransitionTick <= 1'b0;
                    TR_Enable <= 1'b0;
                    TR_Clear <= 1'b0;
                    TR_CfgValue <= 10'd300;
                    if (LoggedIn == 1'b1) begin
                        GameState <= GAMEWAIT;
                    end
                end
                GAMEWAIT: begin
                    TR_Clear <= 1'b1;
                    if (GameButton == 1'b1) begin
                        GameState <= GAMESTART;
                    end
                end
                GAMESTART: begin
                    GameScore <= 14'd0;
                    TR_Enable <= 1'b1;
                    TR_Clear <= 1'b0;
                    PlayerPos <= 1'b0;
                    RNG_Thresh <= 16'b1000000010000000;
                    GameState <= GAMEPLAY;
                end
                GAMEPLAY: begin
                    if (GTick == 1'b1) begin
                        if (GameScore < 14'd9999) begin // cap score at 9999
                            GameScore <= GameScore + 14'd1;
                        end
                        if (RNG_Q > RNG_Thresh) begin
                            SG_TransitionTick <= 1'b1;
                            RNG_Thresh <= 16'b1000000010000000;

                            if (TR_CfgValue > 1) begin
                                TR_CfgValue <= TR_CfgValue - 10'd1;
                            end
                        end else begin
                            SG_TransitionTick <= 1'b0;
                            RNG_Thresh <= RNG_Thresh - 16'd1;
                        end
                    end else begin
                        SG_TransitionTick <= 1'b0;
                    end
                    if (GameButton == 1'b1) begin
                        GameState <= GAMEJUMP;
                    end
                end
                GAMEJUMP: begin
                    if (PlayerPos == 1'b0 && CeilingBits[4] == 1'b0) begin
                        GameState <= GAMEEND;
                    end else if (PlayerPos == 1'b1 && FloorBits[4] == 1'b0) begin
                        GameState <= GAMEEND;
                    end else begin
                        GameState <= GAMEPLAY;
                        PlayerPos <= ~PlayerPos;
                    end
                end
                GAMEEND: begin
                    TR_Enable <= 1'b0;
                    if (GameButton == 1'b1) begin
                        GameState <= GAMEWAIT;
                    end
                end
                default: begin
                    GameState <= LOGGEDOUT;
                end
            endcase
        end
    end

    assign GameTick = GTick;
endmodule