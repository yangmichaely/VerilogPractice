module find_max(
    input wire [2:0] a, 
    input wire [2:0] b, 
    input wire [2:0] c, 
    output wire [2:0] max
);
    reg [2:0] maxVal;
    reg [2:0] ans;
    assign maxVal = (a > b) ? ((a > c) ? a : c) : ((b > c) ? b : c);
    always @* begin
        case(maxVal)
            a: ans = 3'b100;
            b: ans = 3'b010;
            c: ans = 3'b001;
        endcase
    end
    assign max = ans;
endmodule