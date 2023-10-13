module payout(
    input   logic   [3:0]   id  [9:0]   ,
    input   logic   [3:0]   in  [9:0]   ,
    input   logic   [9:0]   en          ,
    output  logic           jackpot     ,
    output  logic   [3:0]   payout      
);

wire    [9:0]   same;
wire    [9:0]   consecutive;

generate
    genvar i;
    for (i = 0; i < 10; i=i+1) begin
        assign same[i] = (id[i][3:0] === in[i][3:0]) & (en[i]);
        assign consecutive[i] = (id[i] === in[i]) | (~en[i]);
    end
endgenerate

assign payout = same[0] + same[1] + same[2] + same[3] + same[4] + same[5] + same[6] + same[7] + same[8] + same[9];
assign jackpot = &consecutive;




endmodule