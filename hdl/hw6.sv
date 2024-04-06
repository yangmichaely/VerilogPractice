module divider(
    input wire[31:0] dividend,
    input wire[31:0] divisor,
    input clk,
    output wire[31:0] quotient,
    output wire[31:0] remainder
);

endmodule

module factorial(
    input wire [31:0] val,
    output wire[31:0] factorial,
    output ready,
    output overflow
);

endmodule

module average(
    input wire [31:0] in,
    input clk,
    output wire [31:0] avg,
    output ready,
    output overflow
);

endmodule

module stream(
    input wire [31:0] first_stream,
    input wire [31:0] second_stream,
    input clk,
    output wire[31:0] running_sum
);

endmodule