// This module authenticates the user based on their 4-digit ID. A set of authorized users are stored in a separate ROM. If the ID matches, the user will be 
// prompted to enter their password in the next module (PasswordHandler.v).
// Inputs:
    // PasswordSwitch, Password Button, LogoutCommand
// Outputs:
    // MatchedID, PlayerAddress, isGuest

module IDHandler(clk, rst, PasswordSwitch, PasswordButton, LogoutCommand, MatchedID, PlayerAddress, isGuest);
    input clk, rst;
    input[3:0] PasswordSwitch;
    input PasswordButton, LogoutCommand;
    output MatchedID;
    output[4:0] PlayerAddress;
    output isGuest;
    reg isGuest;

    parameter DIGIT1 = 0, DIGIT2 = 1, DIGIT3 = 2,
        DIGIT4 = 3, FETCH_ROM = 4, WAIT = 5, CATCH_ROM = 6,
        COMPARE = 7, CHECK_GUEST = 8, ID_MATCH = 9;
    
    reg MatchedID;
    reg [4:0] PlayerAddress;
    reg[3:0] State;
    reg[1:0] WaitCnt;
    reg [15:0] UserEnteredID;

    

    reg [4:0] ROM_Address;
    reg[15:0] PlayerID_Stored;

    wire[15:0] PlayerID_from_ROM;

    PlayerIDROM_16 PlayerID_ROM(ROM_Address, clk, PlayerID_from_ROM); 
    
    always @(posedge clk) begin
        if (rst == 1'b0) begin
            ROM_Address <= 0;
            MatchedID <= 1'b0;
            PlayerAddress <= 0;
            State <= DIGIT1;
            isGuest <= 0;
        end
        case(State)
        DIGIT1: begin
            if(PasswordButton == 1'b1) begin
                UserEnteredID[15:12] <= PasswordSwitch;
                State <= DIGIT2;
            end
            //ROM_Address <= 0;
        end
        DIGIT2: begin
            if(PasswordButton == 1'b1) begin
                UserEnteredID[11:8] <= PasswordSwitch;
                State <= DIGIT3;
            end
        end
        DIGIT3: begin
            if(PasswordButton == 1'b1) begin
                UserEnteredID[7:4] <= PasswordSwitch;
                State <= DIGIT4;
            end
        end
        DIGIT4: begin
            if(PasswordButton == 1'b1) begin
                UserEnteredID[3:0] <= PasswordSwitch;
                State <= FETCH_ROM;
            end
        end
        FETCH_ROM: begin
            if(ROM_Address != 0) begin // 0 address is already loaded to ROM, prevents unnecesary wait on startup
                State <= WAIT;
            end
            else begin
                State <= CATCH_ROM;
            end
        end
        WAIT: begin
            if(WaitCnt == 2) begin
                State <= CATCH_ROM;
            end
            WaitCnt <= WaitCnt + 1;
        end
        CATCH_ROM: begin
            WaitCnt <= 0;
            PlayerID_Stored <= PlayerID_from_ROM;
            State <= COMPARE;
        end
        COMPARE: begin
            if(PlayerID_Stored == UserEnteredID) begin
                State <= CHECK_GUEST;
            end
            else begin
                if(PlayerID_Stored == 16'hFFFF) begin
                    State <= DIGIT1;
                    ROM_Address <= 0;
                end
                else begin
                    ROM_Address <= ROM_Address + 1;
                    State <= FETCH_ROM;
                end
            end
        end
        CHECK_GUEST: begin
            if (PlayerID_Stored == 16'h8888) begin
                isGuest <= 1'b1;
                State <= ID_MATCH;
            end
            else begin
                isGuest <= 1'b0;
                State <= ID_MATCH;
            end
        end
        ID_MATCH: begin
            MatchedID <= 1'b1;
            PlayerAddress <= ROM_Address;
            if(LogoutCommand == 1'b1) begin
                MatchedID <= 1'b0;
                PlayerAddress <= 0;
                ROM_Address <= 0;
                State <= DIGIT1;
            end
        end
        endcase
    end
endmodule
