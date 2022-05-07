module Timer_rc(Enable, Clear, CfgValue, Tick, Clk, Rst);
    input Enable, Clear, Clk, Rst;
    input [9:0] CfgValue;
    output Tick;
    reg Tick;

    reg [9:0] Count;
    wire IntTick;
    Timer_1ms Internal(Enable, IntTick, Clk, Rst);

    always@(posedge Clk) begin
        if (Rst == 1'b0) begin
            Tick <= 0;
            Count <= 0;
        end else if (Clear == 1'b1) begin
            Count <= 0;
        end else if (IntTick == 1'b1) begin
            if (Count < CfgValue) begin
                Count <= Count + 1;
                Tick <= 1'b0;
            end else begin
                Count <= 1'b0;
                Tick <= 1'b1;
            end
        end else if (Tick <= 1'b1) begin
            Tick <= 1'b0;
        end 
    end
endmodule