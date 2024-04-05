module find_max(
    input wire [2:0] a, 
    input wire [2:0] b, 
    input wire [2:0] c, 
    output wire [2:0] max
);

wire [2:0] max1;
max1 = (a > b) ? a : b;
assign max = (max1 > c) ? max1 : c;