module OAB_top_tb;

logic           roll            ;
logic   [3:0]   bet             ;
logic           clk             ;
logic           rst             ;
logic   [3:0]   code    [9:0]   ;
logic           jackpot         ;


parameter CLK_T = 50;
parameter NUM_CODE = 1234567890;


//Generate a fixed number in BCD format
generate
    genvar i;
    for(i = 0;i < 10; i=i+1) begin
        assign code[i] = (NUM_CODE / (10**i)) % 10; 
    end
endgenerate

//Clock Generation
initial begin
    clk = 0;
    forever #CLK_T clk = ~clk;
end

//Test Setup
initial begin
    //Initial Situation
    roll    =   0;
    bet     =   0;
    rst     =   1;
    //Start Beting
    #(10*CLK_T);
    rst     =   0;
    bet     =   5;
    #(5*CLK_T);
    roll    =   1;



end

//Module Instantiation
OAB_top U0(
    .roll(roll),
    .bet(bet),
    .clk(clk),
    .rst(rst),
    .code(code),
    .jackpot(jackpot),
    .payout(payout)
);

//Force to stop after while
initial begin
    #(1000*CLK_T) $stop;
end

endmodule