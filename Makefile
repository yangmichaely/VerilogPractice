# iverilog tells you to run icarus verilog
# -g2012 is the version to run
# -o fp.out tells you to output to fp.out
# .sv and .sv are the source files
# vvp runs simulation and the outputs are directed to real.out

run: 
	iverilog -g2012 -o hw8.out testbench.sv hw4.sv hw6.sv hw7.sv && vvp hw8.out > real.tmp

diff:
	diff hw4_expected_display.text hw4_out_display.text
#diff hw6q1_expected_display.text hw6q1_out_display.text
	diff hw6q2_expected_display.text hw6q2_out_display.text
	diff hw6q3_expected_display.text hw6q3_out_display.text
	diff hw6q4_expected_display.text hw6q4_out_display.text

sim:
	gtkwave dump_hw4.vcd && gtkwave dump_hw6q1.vcd

test: run diff

clean:
	rm -f *.out
	rm -f *.tmp
	rm -f *.vcd
	rm -f *.text

push:
	git add .
	git commit -m "hw8 testbench update"
	git push