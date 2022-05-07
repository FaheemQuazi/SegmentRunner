module SegmentRunner(SwPass, BtPass, BtGame, BtLogOut, Disp5, Disp4, Disp3, Disp2, Disp1, Disp0, LEDPScore, LEDHScore, LEDLoggedIn, LEDLoggedOut, LEDMatchedID, LEDGameTick, Clk, Rst);
    input [3:0] SwPass;
    input BtPass, BtGame, BtLogOut, Clk, Rst;
    output [6:0] Disp5, Disp4, Disp3, Disp2, Disp1, Disp0;
    output LEDPScore, LEDHScore, LEDLoggedIn, LEDLoggedOut, LEDMatchedID, LEDGameTick;

    // Shaped Inputs
    wire BTSPass, BTSGame, BTSLogOut;
    ButtonShaper BTSPPass(BtPass, BTSPass, Clk, Rst);
    ButtonShaper BTSPGame(BtGame, BTSGame, Clk, Rst);
    ButtonShaper BTSPLogOut(BtLogOut, BTSLogOut, Clk, Rst);

    // Authenticator
    wire AuthLoggedIn, AuthLoggedOut, AuthIsGuest, AuthMatchedID;
    wire [4:0] AuthPlayerID;
    Authenticator ModAuth(Clk, Rst, SwPass, BTSPass, BTSLogOut, AuthLoggedOut, AuthLoggedIn, AuthIsGuest, AuthPlayerID, AuthMatchedID);
    assign LEDLoggedIn = AuthLoggedIn;
    assign LEDLoggedOut = AuthLoggedOut;
    assign LEDMatchedID = AuthMatchedID;

    // Game Controller
    wire [13:0] GCGameScore;
    wire [5:0] GCFloorBits, GCCeilingBits;
    wire [3:0] GCGameState;
    wire GCPlayerPos, GCGameTick;
    GameController GCMain(AuthLoggedIn, BTSGame, GCFloorBits, GCCeilingBits, GCPlayerPos, GCGameTick, GCGameState, GCGameScore, Clk, Rst);
    assign LEDGameTick = GCGameTick;

    // Score Tracking
    ScoreTracker ScoreBoard(Clk, Rst, GCGameState, AuthPlayerID, AuthIsGuest, GCGameScore, LEDPScore, LEDHScore);

    // Display
    reg DispShowScore;
    always@(GCGameState) begin
        if (GCGameState == 4'd5) begin
            DispShowScore = 1'b1;
        end else begin
            DispShowScore = 1'b0;
        end
    end
    Decoder DisplayOuts(Clk, AuthLoggedIn, GCCeilingBits, GCFloorBits, GCPlayerPos, GCGameScore, DispShowScore, Disp5, Disp4, Disp3, Disp2, Disp1, Disp0);


endmodule