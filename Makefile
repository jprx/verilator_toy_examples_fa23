
toy: tb.cc top.sv Makefile
	@echo "SV top.sv"
	@verilator --cc top.sv --public-flat-rw -Wno-UNOPTFLAT -Wno-UNOPT -Wno-CASEINCOMPLETE -Wno-WIDTH --exe tb.cc --build -j
	@mv obj_dir/Vtop toy

.PHONY: clean
clean:
	rm -rf obj_dir toy