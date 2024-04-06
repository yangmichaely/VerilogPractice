module hw4_tb();
// declarations

int test_num;
reg clk;
reg[2:0] a;
reg[2:0] b;
reg[2:0] c;
reg[2:0] expected;
reg [2:0] out;


find_max my_max(.a(a), .b(b), .c(c), .max(out));

initial
begin
    clk = 1'b0;
    forever begin
        # 1 clk = !clk; // forever, toggle the clock every ns
    end
end

initial begin
    $dumpfile ("./sim/dump_hw4.vcd");
    $dumpvars (0);
end

initial begin
    

    // repeat(5)@(posedge clk); // wait for 5 clocks
    
    // Test 1:
    test_num = 1;
    a        = 3'b101;
    b        = 3'b100;
    c        = 3'b001;
    expected    = 3'b101;
    repeat (1) @ (posedge clk);

    // Test 2:
    test_num = 2;
    a       = 3'b010;
    b       = 3'b011;
    c       = 3'b000;
    expected = 3'b011;
    repeat(1) @ (posedge clk);

    $finish;

end // initial

 // clock toggles after every 5 ns.
initial 
begin
    integer out_file, expected_file;
    out_file = $fopen("./vvp/hw4_out_display.text");
    expected_file = $fopen("./vvp/hw4_expected_display.text");
    clk = 1'b0;
    forever begin
        @(posedge clk) begin
            $display ("%t, out =  %b, expected = %b", $time, out, expected);
            $fwrite(out_file, "%t, out = %b\n", $time, out);
            $fwrite(expected_file, "%t, out = %b\n", $time, expected);
        end
    end
    $fclose(out_file);
    $fclose(expected_file);
end //initial  
endmodule