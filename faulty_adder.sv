
module faulty_adder(
	input logic[31:0] a,
	input logic[31:0] b,
	output logic[31:0] s,

	input logic reset,
	input logic clk
);

	logic[31:0] internal_counter;

	always_ff @ (posedge clk) begin
		if (reset)
			internal_counter <= 32'h0000_0000;
		else
			internal_counter <= internal_counter + 1;
	end

	always_comb begin
		s = a + b;
		if (internal_counter == 32'h100) begin
			s = 32'hDEAD_BEEF;
		end
	end

endmodule : faulty_adder
