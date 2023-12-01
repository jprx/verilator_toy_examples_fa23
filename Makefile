
.PHONY: all
all: faulty_adder simple_adder

faulty_adder: faulty_adder_tb.cc faulty_adder.sv Makefile
	@echo "SV faulty_adder.sv"
	@verilator --cc faulty_adder.sv --public-flat-rw -Wno-UNOPTFLAT -Wno-UNOPT -Wno-CASEINCOMPLETE -Wno-WIDTH --exe faulty_adder_tb.cc --build -j --top-module faulty_adder
	@mv obj_dir/Vfaulty_adder faulty_adder

simple_adder: simple_adder_tb.cc simple_adder.sv Makefile
	@echo "SV simple_adder.sv"
	@verilator --cc simple_adder.sv --public-flat-rw -Wno-UNOPTFLAT -Wno-UNOPT -Wno-CASEINCOMPLETE -Wno-WIDTH --exe simple_adder_tb.cc --build -j --top-module simple_adder
	@mv obj_dir/Vsimple_adder simple_adder

.PHONY: clean
clean:
	@echo "Cleaning Up!"
	@rm -rf obj_dir faulty_adder simple_adder