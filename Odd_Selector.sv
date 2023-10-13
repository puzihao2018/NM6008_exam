module Odd_Selector(
    input   wire            roll,
    input   wire    [3:0]   bet,
    output  reg     [9:0]   en
);

always @(posedge roll) begin
        case(bet)
        0:  en <= 10'b00000_00000;
        1:  en <= 10'b00000_00001;
        2:  en <= 10'b00000_00011;
        3:  en <= 10'b00000_00111;
        4:  en <= 10'b00000_01111;
        5:  en <= 10'b00000_11111;
        6:  en <= 10'b00001_11111;
        7:  en <= 10'b00011_11111;
        8:  en <= 10'b00111_11111;
        9:  en <= 10'b01111_11111;
        10: en <= 10'b11111_11111;
        default:    en <= 10'b0;
    endcase
end

endmodule

