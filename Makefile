run:
	iverilog -g2012 -o ./vvp/hw8.out ./test/testbench_hw7.sv ./hdl/hw4.sv ./hdl/hw6.sv ./hdl/hw7.sv && vvp ./vvp/hw8.out > ./vvp/real.tmp

diff:
	diff ./vvp/hw4_expected_display.text ./vvp/hw4_out_display.text
	diff ./vvp/hw6q1_expected_display.text ./vvp/hw6q1_out_display.text

sim:
	gtkwave ./sim/dumpfile.vcd

test: run diff

clean:
	rm -f ./vvp/*.out 
	rm -f ./sim/*.vcd
	rm -f ./*.vcd
	rm -f ./vvp/*.tmp
	rm -f ./vvp/*.text