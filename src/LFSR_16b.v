module LFSR_16b(Q, Enable, Clk, Rst);
  input Enable, Clk, Rst;
  output [15:0] Q;

  reg [15:0] LFSR;
  wire feedback = LFSR[15];

  always @(posedge Clk) begin
    if (Rst == 1'b0) begin
      LFSR <= 16'hFFFF;
    end else if (Enable == 1'b1) begin
      LFSR[0] <= feedback;
      LFSR[1] <= LFSR[0];
      LFSR[2] <= LFSR[1] ^ feedback;
      LFSR[3] <= LFSR[2] ^ feedback;
      LFSR[4] <= LFSR[3];
      LFSR[5] <= LFSR[4] ^ feedback;
      LFSR[6] <= LFSR[5];
      LFSR[7] <= LFSR[6];
      LFSR[8] <= LFSR[7];
      LFSR[9] <= LFSR[8];
      LFSR[10] <= LFSR[9];
      LFSR[11] <= LFSR[10];
      LFSR[12] <= LFSR[11];
      LFSR[13] <= LFSR[12];
      LFSR[14] <= LFSR[13];
      LFSR[15] <= LFSR[14];
    end
  end

  assign Q = LFSR;
endmodule
