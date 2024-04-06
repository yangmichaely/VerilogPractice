module find_max(
    input wire [2:0] a, 
    input wire [2:0] b, 
    input wire [2:0] c, 
    output wire [2:0] max
);
    assign max = (a > b) ? ((a > c) ? a : c) : ((b > c) ? b : c);
endmodule