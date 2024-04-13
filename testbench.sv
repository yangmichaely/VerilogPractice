// MASTER TESTBENCH

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
        # 5 clk = !clk; // forever, toggle the clock every 5 ns
    end
end

initial begin
    $dumpfile ("dump_hw4.vcd");
    $dumpvars (0);
end

initial begin

    integer out_file, expected_file;
    out_file = $fopen("hw4_out_display.text");
    expected_file = $fopen("hw4_expected_display.text");
    
    

    
    // Test 1:
    test_num = 1;
    a        = 3'b101;
    b        = 3'b100;
    c        = 3'b001;
    expected    = 3'b100;
    #10
    
    // Test 2:
    test_num = 2;
    a       = 3'b010;
    b       = 3'b011;
    c       = 3'b000;
    expected = 3'b010;
    #10

    $fclose(out_file);
    $fclose(expected_file);

    // $finish;


end // initial

 // clock toggles after every 5 ns.
initial 
begin
    integer out_file, expected_file;
    out_file = $fopen("hw4_out_display.text");
    expected_file = $fopen("hw4_expected_display.text");
    // clk = 1'b0;
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

module hw6q1_tb();
// declarations

int test_num;
reg clk;
reg[31:0] numerator;
reg[31:0] denominator;
reg [31:0] quotient;
reg [31:0] remainder;
reg [31:0] expected_quotient;
reg [31:0] expected_remainder;
reg [8:0] cycle_counter = 0;

divider my_divider(.dividend(numerator), .divisor(denominator), .clk(clk), .quotient(quotient), .remainder(remainder));

initial
begin
    clk = 1'b0;
    forever begin
        # 5 clk = !clk; // forever, toggle the clock every 5 ns - so 1 clock cycle is 10 ms
    end
end

initial begin
    $dumpfile ("dump_hw6q1.vcd");
    $dumpvars (0);
end

initial begin
    

    // Test 1:
    numerator = 9;
    denominator = 2;
    expected_quotient = 4;
    expected_remainder = 1;


    // Test 2:
    numerator = 30;
    denominator = 4;
    expected_quotient = 7;
    expected_remainder = 2;
    #640 // wait 32 cycles

    $finish;

end // initial

 // clock toggles after every 5 ns.
initial 
begin
    integer out_file, expected_file, debug_file;
    out_file = $fopen("hw6q1_out_display.text");
    expected_file = $fopen("hw6q1_expected_display.text");
    debug_file = $fopen("dbg.text");
    // clk = 1'b0;
    forever begin
        @(posedge clk) begin
            cycle_counter <= cycle_counter + 1;
            $fwrite(debug_file, "cycle_counter = %b\n", cycle_counter); 
            if (cycle_counter == 31 || cycle_counter == 63) begin    
                $fwrite(out_file, "cycle_counter = %b\n", cycle_counter);
                $fwrite(expected_file, "cycle_counter = %b\n", cycle_counter);
                $display ("%t, quotient =  %b, remainder = %b, expected quotient = %b, expected remainder = %b", $time, quotient, remainder, expected_quotient, expected_remainder);
                $fwrite(out_file, "%t, quotient = %b\n, remainder = %b\n", $time, quotient, remainder);
                $fwrite(expected_file, "%t, quotient = %b\n, remainder = %b\n", $time, expected_quotient, expected_remainder);
            end
        end
    end
    $fclose(out_file);
    $fclose(expected_file);
    $fclose(debug_file);
end //initial  
endmodule

module hw6q2_tb();

// declarations
reg [31:0] val;
reg clk;

reg [31:0] fact;
reg overflow;
reg [31:0] expected_fact;
reg expected_overflow;
reg ready;
reg [8:0] cycle_counter = 0;


factorial my_fact(val, fact, clk, ready, overflow);

initial begin
    clk = 1'b0;
    forever begin
        # 5 clk = ~clk;
    end
end


initial begin
    $dumpfile ("dump_hw6q2.vcd");
    $dumpvars (0);
end

initial begin



    integer out_file, expected_file;
    out_file = $fopen("hw6q2_out_display.text");
    expected_file = $fopen("hw6q2_expected_display.text");
    
    

    
    // Test 1:
    val = 5;
    expected_fact = 120;
    expected_overflow = 0;
    #100
    
    // Test 2:
    val = 50;
    expected_fact = 0;
    expected_overflow = 1;
    #100

    $fclose(out_file);
    $fclose(expected_file);



end // initial

 // clock toggles after every 5 ns.
initial 
begin
    integer out_file, expected_file, debug_file;
    out_file = $fopen("hw6q2_out_display.text");
    expected_file = $fopen("hw6q2_expected_display.text");
    debug_file = $fopen("dbg.text");
    // clk = 1'b0;
    forever begin
        @(posedge clk) begin
            cycle_counter <= cycle_counter + 1;
            $fwrite(debug_file, "cycle_counter = %b\n", cycle_counter); 
            if (ready == 1) begin    
                $fwrite(out_file, "cycle_counter = %b\n", cycle_counter);
                $fwrite(expected_file, "cycle_counter = %b\n", cycle_counter);
                $display ("%t, factorial =  %b, overflow = %b, expected factorial = %b, expected overflow = %b", $time, fact, overflow, expected_fact, expected_overflow);

                $fwrite(out_file, "%t, input = %b\n", $time, val);
                $fwrite(expected_file, "%t, input = %b\n", $time, val);
                $fwrite(out_file, "%t, factorial = %b\n, overflow = %b\n", $time, fact, overflow);
                $fwrite(expected_file, "%t, factorial = %b\n, overflow = %b\n", $time, expected_fact, expected_overflow);
            end
        end
    end
    $fclose(out_file);
    $fclose(expected_file);
    $fclose(debug_file);
end //initial  
endmodule

module hw6q3tb();

reg [31:0] in;
// keep store inputs ahead of time for testing
reg [31:0] input_1;
reg [31:0] input_2;
reg [31:0] input_3;
reg [31:0] input_4;
reg [31:0] input_5;
reg [31:0] input_6;

reg clk = 0;
reg ready;

reg [31:0] avg;
reg overflow;
reg [31:0] expected_avg = 0;
reg expected_overflow = 0;

reg [8:0] cycle_counter = 0;

average my_avg(in, clk, avg, ready, overflow);


initial begin
    clk = 1'b0;
    forever begin
        # 5 clk = ~clk;
    end
end


initial begin
    $dumpfile ("dump_hw6q3.vcd");
    $dumpvars (0);
end

initial begin


    integer out_file, expected_file;
    out_file = $fopen("hw6q3_out_display.text");
    expected_file = $fopen("hw6q3_expected_display.text");
    
    in = 0;

    
    // Test 1:
    input_1 = 2;
    input_2 = 4;
    input_3 = 6;
    input_4 = 8;
    input_5 = 10;
    input_6 = 12;
    #10
    in = input_1;
    #10
    in = input_2;
    #10
    in = input_3;
    #10
    in = input_4;
    #10
    in = input_5;
    #10
    in = input_6;
    expected_avg = 7;
    expected_overflow = 0;
    #10
    
    // Test 2:
    input_1 = {1'b1, 31'b0};
    input_2 = {1'b1, 31'b0};
    input_3 = {1'b1, 31'b0};
    input_4 = {1'b1, 31'b0};
    input_5 = {1'b1, 31'b0};
    input_6 = {1'b1, 31'b0};
    in = input_1;
    #10
    in = input_2;
    #10
    in = input_3;
    #10
    in = input_4;
    #10
    in = input_5;
    #10
    in = input_6;
    expected_avg = 0;
    expected_overflow = 1;
    #10

    $fclose(out_file);
    $fclose(expected_file);

end


 // clock toggles after every 5 ns.
initial 
begin
    integer out_file, expected_file, debug_file;
    out_file = $fopen("hw6q3_out_display.text");
    expected_file = $fopen("hw6q3_expected_display.text");
    debug_file = $fopen("dbg.text");
    // clk = 1'b0;
    forever begin
        @(posedge clk) begin
            cycle_counter <= cycle_counter + 1;
            $fwrite(debug_file, "cycle_counter = %d\n", cycle_counter); 
            if (ready == 1) begin    
                $fwrite(out_file, "cycle_counter = %d\n", cycle_counter);
                $fwrite(expected_file, "cycle_counter = %d\n", cycle_counter);
                $display ("%t, avg =  %b, overflow = %b, expected avg = %b, expected overflow = %b", $time, avg, overflow, expected_avg, expected_overflow);

                $fwrite(out_file, "%t, input_1 = \t%d\n", $time, input_1);
                $fwrite(out_file, "%t, input_2 = \t%d\n", $time, input_2);
                $fwrite(out_file, "%t, input_3 = \t%d\n", $time, input_3);
                $fwrite(out_file, "%t, input_4 = \t%d\n", $time, input_4);
                $fwrite(out_file, "%t, input_5 = \t%d\n", $time, input_5);
                $fwrite(out_file, "%t, input_6 = \t%d\n", $time, input_6);
                $fwrite(out_file, "%t, average = \t%d\n", $time, avg);
                $fwrite(out_file, "%t, overflow = \t%d\n", $time, overflow);

                $fwrite(expected_file, "%t, input_1 = \t%d\n", $time, input_1);
                $fwrite(expected_file, "%t, input_2 = \t%d\n", $time, input_2);
                $fwrite(expected_file, "%t, input_3 = \t%d\n", $time, input_3);
                $fwrite(expected_file, "%t, input_4 = \t%d\n", $time, input_4);
                $fwrite(expected_file, "%t, input_5 = \t%d\n", $time, input_5);
                $fwrite(expected_file, "%t, input_6 = \t%d\n", $time, input_6);
                $fwrite(expected_file, "%t, average = \t%d\n", $time, expected_avg);
                $fwrite(expected_file, "%t, overflow = \t%d\n", $time, expected_overflow);
            end
        end
    end
    $fclose(out_file);
    $fclose(expected_file);
    $fclose(debug_file);
end //initial  


endmodule

module hw6q4tb();

reg [31:0] stream_1;
reg [31:0] stream_2;

reg [31:0] expected_sum;

reg clk = 0;

reg [31:0] running_sum;

stream my_stream(stream_1, stream_2, clk, running_sum);

initial begin
    clk = 1'b0;
    forever begin
        # 5 clk = ~clk;
    end
end


initial begin
    $dumpfile ("dump_hw6q4.vcd");
    $dumpvars (0);
end

initial begin


    integer out_file, expected_file;
    out_file = $fopen("hw6q4_out_display.text");
    expected_file = $fopen("hw6q4_expected_display.text");
        
    // Test 1:
    stream_1 = 2;
    stream_2 = 4;
    expected_sum = 6;
    #10
    stream_1 = 3;
    stream_2 = 5;
    expected_sum = 14;
    #10
    stream_1 = 4;
    stream_2 = 6;
    expected_sum = 24;
    #10
    stream_1 = 0;
    stream_2 = 0; // so expected matches actual


    $fclose(out_file);
    $fclose(expected_file);

end


 // clock toggles after every 5 ns.
initial 
begin
    integer out_file, expected_file, debug_file;
    out_file = $fopen("hw6q4_out_display.text");
    expected_file = $fopen("hw6q4_expected_display.text");
    debug_file = $fopen("dbg.text");
    // clk = 1'b0;
    forever begin
        @(posedge clk) begin
                $display ("%t, sum =  %b, expected sum = %b", $time, running_sum, expected_sum);
                
                $fwrite(out_file, "%t, stream1 = \t%d\n", $time, stream_1);
                $fwrite(out_file, "%t, stream2 = \t%d\n", $time, stream_2);
                $fwrite(out_file, "%t, sum = \t%d\n", $time, running_sum);

                $fwrite(expected_file, "%t, stream1 = \t%d\n", $time, stream_1);
                $fwrite(expected_file, "%t, stream2 = \t%d\n", $time, stream_2);
                $fwrite(expected_file, "%t, sum = \t%d\n", $time, expected_sum);
        end
    end
    $fclose(out_file);
    $fclose(expected_file);
    $fclose(debug_file);
end //initial  


endmodule