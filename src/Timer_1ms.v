module Timer_1ms(Enable, Tick, Clk, Rst);
    input Clk, Rst, Enable;
    output Tick;
    reg Tick;

    wire [15:0] LFSR;
    reg LFSR_Rst;
    LFSR_16b cntr(LFSR, Enable, Clk, LFSR_Rst);

    always @(posedge Clk) begin
        if (Rst == 1'b0) begin
            LFSR_Rst <= 1'b0;
            Tick <= 1'b0;
        end else begin
            if (Enable == 1'b1) begin
                if (LFSR == 16'hDB6C) begin
                    Tick <= 1'b1;
                    LFSR_Rst <= 1'b0;
                end else begin
                    Tick <= 1'b0;
                    LFSR_Rst <= 1'b1;
                end
            end else begin
                Tick <= 1'b0;
                LFSR_Rst <= 1'b1;
            end
        end
    end
endmodule
