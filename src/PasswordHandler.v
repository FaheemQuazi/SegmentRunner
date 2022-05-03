// This module checks the password entered against the one of an authorized user in ROM. The password must match the ID of the user trying to access the game.
// ID functions are handled separately by the IDHandler module. The user will have 3 attempts to input their password, otherwise, they will have to provide their address.
// Inputs:
    // PasswordSwitch, PasswordButton, MatchedID, PlayerAddress_from_ID, LogoutCommand_from_GC, 
// Outputs:
    // LoggedOut, LoggedIn, IsGuest_to_GC, PlayerAddress_to_GC

module PasswordHandler(clk, rst, PasswordSwitch, PasswordButton, MatchedID, PlayerAddress_from_ID,
                       LogoutCommand_from_GC, IsGuest_from_ID, LoggedOut, LoggedIn, isGuest_to_GC, Logout_to_ID, PlayerAddress_to_GC);
    input[3:0] PasswordSwitch;
    input PasswordButton, MatchedID;
    input[2:0] PlayerAddress_from_ID;
    input LogoutCommand_from_GC;
    input isGuest_from_ID;
    output LoggedOut, LoggedIn, isGuest_to_GC, Logout_to_ID;
    reg LoggedOut, LoggedIn, isGuest_to_GC, Logout_to_ID;
    output[2:0] PlayerAddress_to_GC;
    reg[2:0] PlayerAddress_to_GC;

    reg[23:0] UserEnteredPassword;

    parameter STANDBY = 0, DIGIT1 = 1, DIGIT2 = 2, DIGIT3 = 3,
              DIGIT4 = 4, DIGIT5 = 5, DIGIT6 = 6, FETCH_ROM = 7,
              WAIT = 8, CATCH_ROM = 9, COMPARE = 10, PASSED = 11;

    reg [3:0] State;
    reg[1:0] WaitCnt;
    reg[2:0] ROM_Address;
    reg [1:0] WrongPasswordCnt;
    reg[23:0] Password_Stored;
    wire[23:0] Password_from_ROM;

    PasswordROM_24 PasswordROM(ROM_Address, clk, Password_from_ROM);

    always@(posedge clk) begin
        if(rst == 1'b0) begin
            LoggedOut <= 1'b1;
            LoggedIn <= 1'b0;
            IsGuest_to_GC <= 1'b0;
            PlayerAddress_to_GC <= 0;
            State <= STANDBY;
        end
        else begin
            case(State)
            STANDBY: begin
                LoggedOut <= 1'b1;
                LoggedIn <= 1'b0;
                Logout_to_ID = 1'b0; // reset logout pulse
                if(MatchedID == 1'b1) begin
                    if(isGuest_from_ID == 1'b1) begin
                        State <= PASSED; // Guest skips password entry
                    end
                    else begin
                        State <= DIGIT1;
                    end
                end
            end
            DIGIT1: begin
                if(PasswordButton == 1'b1) begin
                    UserEnteredPassword[23:20] <= PasswordSwitch;
                    State <= DIGIT2;
                end
            end
            DIGIT2: begin
                if(PasswordButton == 1'b1) begin
                    UserEnteredPassword[19:16] <= PasswordSwitch;
                    State <= DIGIT3;
                end
            end
            DIGIT3: begin
                if(PasswordButton == 1'b1) begin
                    UserEnteredPassword[15:12] <= PasswordSwitch;
                    State <= DIGIT3;
                end
            end
            DIGIT4: begin
                if(PasswordButton == 1'b1) begin
                    UserEnteredPassword[11:8] <= PasswordSwitch;
                    State <= DIGIT4;
                end
            end
            DIGIT5: begin
                if(PasswordButton == 1'b1) begin
                    UserEnteredPassword[7:4] <= PasswordSwitch;
                    State <= DIGIT6;
                end
            end
            DIGIT6: begin
                if(PasswordButton == 1'b1) begin
                    UserEnteredPassword[3:0] <= PasswordSwitch;
                    State <= FETCH_ROM;
                end
            end
            FETCH_ROM: begin
                ROM_Address <= PlayerAddress_from_ID;
            end
            WAIT: begin
                if(WaitCnt == 2) begin
                    State <= CATCH_ROM;
                end
                WaitCnt <= WaitCnt + 1;
            end
            CATCH_ROM: begin
                WaitCnt <= 0;
                Password_Stored <= Password_from_ROM;
                State <= COMPARE;
            end
            COMPARE: begin
                if (WrongPasswordCnt == 3) begin // three wrong attempts trigger change in ID
                    Logout_to_ID = 1'b1;
                    State <= STANDBY;
                end
                if (Password_Stored == UserEnteredPassword) begin
                    State <= CHECK_GUEST;
                end
                else begin
                    WrongPasswordCnt = WrongPasswordCnt + 1;
                    State = DIGIT1;
                end
            end
            PASSED: begin
                LoggedOut <= 1'b0;
                LoggedIn <= 1'b1;
                isGuest_to_GC <= isGuest_from_ID;
                if(LogoutCommand_from_GC == 1'b1) begin
                    LoggedIn <= 1'b0;
                    LoggedOut <= 1'b1;
                    Logout_to_ID <= 1'b1; // set logout pulse
                    State <= STANDBY;
                end
            end
            default: begin
                State <= STANDBY;
            end
            endcase
        end
    end
endmodule

