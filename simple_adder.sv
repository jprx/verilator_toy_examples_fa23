
module simple_adder(
	input logic[31:0] a,
	input logic[31:0] b,
	output logic[31:0] s
);

	assign s = a + b;

endmodule : simple_adder
