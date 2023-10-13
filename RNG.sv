module RNG(
    input   wire            clk,
    input   wire            rst,
    input   wire            roll,
    input   wire            en,
    output  wire    [3:0]   out
);


parameter seed = 10;
parameter N = 31;       //PRBS Sequence Length
reg         [3:0]   out_lock;

//PRBS31 Pseudo Random Sequence Generator
reg     [N-1:0]  prbs;
wire            prbs_bit;
always @(posedge clk or posedge rst) begin
    if(rst) prbs <= seed;
    else    prbs <= {prbs[N-2:0],prbs_bit};
end

generate
    case(N)
        7:  assign prbs_bit = ~(prbs[6]^prbs[5]);
        9:  assign prbs_bit = ~(prbs[8]^prbs[5]);
        31: assign prbs_bit = ~(prbs[30]^prbs[27]);
    endcase
endgenerate


//Output Logic
always @(posedge roll or posedge rst) begin
    if(rst) out_lock <= 0;
    else    out_lock <= prbs[3:0];
end

assign out = en?out_lock%10:0;

endmodule
