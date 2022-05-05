module Timer_rc(Enable, Clear, CfgValue, Tick, Clk, Rst);
    input Enable, Clear, Clk, Rst;
    input [9:0] CfgValue;
    output Tick;
    reg Tick;

    reg [9:0] Count;
    wire IntTick;
    Timer_1ms Internal(Enable, IntTick, Clk, Rst);

    always@(negedge Rst) begin
        Tick <= 0;
        Count <= 0;
    end

    always@(posedge IntTick) begin
        if (Count < CfgValue) begin
            Count <= Count + 1;
            Tick <= 1'b0;
        end else begin
            Count <= 1'b0;
            Tick <= 1'b1;
        end
    end

    always@(posedge Clear) begin
        Count <= 0;
    end

    always@(posedge Clk) begin
        if (Tick <= 1'b1) begin
            Tick <= 1'b0;
        end
    end
endmodule