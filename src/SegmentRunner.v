module SegmentRunner(SwPass, BtPass, BtGame, Disp5, Disp4, Disp3, Disp2, Disp1, Disp0, LEDPScore, LEDHScore, Clk, Rst);
    input [3:0] SwPass;
    input BtPass, BtGame, Clk, Rst;
    output [6:0] Disp5, Disp4, Disp3, Disp2, Disp1, Disp0;
    output LEDPScore, LEDHScore;

    wire AuthLoggedIn;
    wire [4:0] AuthPlayerID;
    assign AuthLoggedIn = 1'b1;
    assign AuthPlayerID = 5'b00001;

    // Shaped Inputs
    wire BTSPass, BTSGame;
    ButtonShaper BTSPPass(BtPass, BTSPass, Clk, Rst);
    ButtonShaper BTSPGame(BtGame, BTSGame, Clk, Rst);

    // Game Controller
    wire [13:0] GCGameScore;
    wire [5:0] GCFloorBits, GCCeilingBits;
    wire [3:0] GCGameState;
    wire GCPlayerPos, GCGameTick;
    GameController GCMain(AuthLoggedIn, BTSGame, GCFloorBits, GCCeilingBits, GCPlayerPos, GCGameTick, GCGameState, GCGameScore, Clk, Rst);

    // Score Tracking
    ScoreTracker ScoreBoard(Clk, Rst, GCGameState, AuthPlayerID, GCGameScore, LEDPScore, LEDHScore);

    // Display
    reg DispShowScore;
    always@(GCGameState) begin
        if (GCGameState == 4'd5) begin
            DispShowScore = 1'b1;
        end else begin
            DispShowScore = 1'b0;
        end
    end
    Decoder DisplayOuts(GCCeilingBits, GCFloorBits, GCPlayerPos, GCGameScore, DispShowScore, Disp5, Disp4, Disp3, Disp2, Disp1, Disp0);


endmodule