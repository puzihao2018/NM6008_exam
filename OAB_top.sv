module OAB_top(
    input   logic           roll            ,
    input   logic   [3:0]   bet             ,
    input   logic           clk             ,
    input   logic           rst             ,
    input   logic   [3:0]   code    [9:0]   ,
    output  logic           jackpot         ,
    output  logic   [3:0]   payout
);

parameter N_RNG = 10;

wire    [9:0]   en              ;
wire    [3:0]   r_num   [9:0]   ;

//Odd Select Instantiation
Odd_Selector U1(
    .roll(roll),
    .bet(bet),
    .en(en)
);


//RNG Generator: Generate 10 RNG Instants at once
generate
    genvar seed, i;
    for(i = 0; i < N_RNG; i = i + 1) begin
        RNG #(  
            .seed(i+10),
            .N(31)
        ) U2 (
            .clk(clk),
            .rst(rst),
            .roll(roll),
            .en(en),
            .out(r_num[i])
        );
    end
endgenerate

//Payout Logic
payout U3(
    .id(code),
    .in(r_num),
    .en(en),
    .jackpot(jackpot),
    .payout(payout)
);

endmodule
