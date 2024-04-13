module hw6q1_tb();

reg clk;
int test_num;
reg[31:0] dividend;
reg[31:0] divisor;
reg[31:0] expected_quotient;
reg[31:0] expected_remainder;
reg[31:0] quotient;
reg[31:0] remainder;

divider divide(.dividend(dividend), .divisor(divisor), .quotient(quotient), .remainder(remainder), .clk(clk));

initial begin
    clk = 1'b0;
    forever begin
        # 1 clk = ~clk;
    end
end

initial begin
    $dumpfile("./sim/hw6q1.vcd");
    $dumpvars(0, hw6q1_tb);
end

initial begin
    //repeat(5) @(posedge clk);

    test_num = 1;
    dividend                = 32'd81;
    divisor                 = 32'd9;
    expected_quotient       = 32'd0;
    expected_remainder      = 32'd0;
    repeat(70) @(posedge clk);

    $finish;
end

initial begin
    integer out_file, expected_file;
    out_file = $fopen("./vvp/hw6q1_out_display.text");
    expected_file = $fopen("./vvp/hw6q1_expected_display.text");
    clk = 1'b0;
    forever begin
        @(posedge clk) begin
            $display ("%t, quotient =  %d, remainder =  %d, expected quotient = %d, expected remainder = %d, ", $time, quotient, remainder, expected_quotient, expected_remainder);
            $fwrite(out_file, "%t, quotient = %d, remainder = %d\n", $time, quotient, remainder);
            $fwrite(expected_file, "%d, quotient = %d, remainder = %d\n", $time, expected_quotient, expected_remainder);
        end
    end
    $fclose(out_file);
    $fclose(expected_file);
end
endmodule