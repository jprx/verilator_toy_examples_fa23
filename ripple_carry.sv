
module ripple_carry(
	input logic[31:0] a,
	input logic[31:0] b,
	output logic[31:0] s
);

	assign s = a + b;

endmodule : ripple_carry
