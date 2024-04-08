module hw6q2_tb();

reg clk;
int test_num;
reg[31:0] val;
reg[31:0] factorial;
reg ready;
reg overflow;
reg[31:0] expected_factorial;
reg expected_ready;
reg expected_overflow;

factorial factorialer(.val(val), .clk(clk), .factorial(factorial), .ready(ready), .overflow(overflow));

initial begin
    clk = 1'b0;
    forever begin
        # 1 clk = ~clk;
    end
end

initial begin
    $dumpfile("./sim/hw6q2.vcd");
    $dumpvars(0, hw6q2_tb);
end

initial begin
    //repeat(5) @(posedge clk);

    test_num = 1;
    val                = 32'd16;
    expected_factorial       = 32'd24;
    expected_ready      = 1'b1;
    expected_overflow      = 32'd1;
    repeat(70) @(posedge clk);

    $finish;
end

initial begin
    integer out_file, expected_file;
    out_file = $fopen("./vvp/hw6q2_out_display.text");
    expected_file = $fopen("./vvp/hw6q2_expected_display.text");
    clk = 1'b0;
    forever begin
        @(posedge clk) begin
            $display ("%t, factorial =  %d, ready bit =  %d, overflow bit = %d, expected factorial = %d, expected ready = %d, expected bit = %d", $time, factorial, ready, overflow, expected_factorial, expected_ready, expected_overflow);
            $fwrite(out_file, "%t, factorial = %d, ready bit = %d, overflow bit = %d\n", $time, factorial, ready, overflow);
            $fwrite(expected_file, "%t, expected factorial = %d, expected_ready = %d, expected overflow = %d\n", $time, expected_factorial, expected_ready, expected_overflow);
        end
    end
    $fclose(out_file);
    $fclose(expected_file);
end
endmodule