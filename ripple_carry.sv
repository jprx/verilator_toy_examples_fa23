
/*
 * ripple_carry
 * A ripple carry adder implementing 32-bit addition for two inputs a & b.
 *
 * Inputs:
 *  - a: A 32 bit packed SV array defining a 32-bit integer to be added to b.
 *  - b: A 32 bit packed SV array defining a 32-bit integer to be added to a.
 *
 * Outputs:
 *  - s: A 32 bit packed SV array defining a 32-bit integer representing a + b.
 */
module ripple_carry(
	input logic[31:0] a,
	input logic[31:0] b,
	output logic[31:0] s
);

	// The internal carry bus used for forwarding carry values between full adders
	logic[31:0] internal_carries;

	// We can either set the 0th internal carry (the first one) to 0 here like this,
	// or inside of the generate block (as will also be seen later on)
	assign internal_carries[0] = 0;

	// A generate loop allows us to programatically place modules very quickly using for-loop like syntax
	// `genvar` denotes the loop variable used for the generate block
	genvar i;
	generate
		// We want to create 32 full_adders, one for each bit of the output:
		for (i = 0; i < 32; i++) begin
			// Create a new full_adder module, hooking up the inputs based on the genvar i
			full_adder adder0(
				// Forward a and b directly at bit i into the i-th full adder
				.a(a[i]),
				.b(b[i]),

				// Connect the carry in bits to the internal carry bus
				.cin((i == 0) ? 0 : internal_carries[i-1]), // Redundantly 0 initialize the 0th cin bit

				// Hook the sum bit directly from the i-th full adder to the i-th sum output bit for this module
				.s(s[i]),

				// And lastly, connect the internal carry bus to the output of this full adder too
				.cout(internal_carries[i])
			);
		end
	endgenerate

endmodule : ripple_carry

/*
 * full_adder
 * Inputs:
 *  - a: A single bit input to be added to b
 *  - b: A single bit input to be added to a
 *  - cin: A carry in bit allowing full adders to be chained together.
 *         Should be set to 0 for the first full adder in a chain.
 *
 * Outputs:
 *  - s: The sum bit that should be directly connected as the output of this full adder
 *  - cout: A carry out bit that should be forwarded to the cin of the next full adder
 *          in the ripple carry chain.
 */
module full_adder(
	input logic a,
	input logic b,
	input logic cin,

	output logic s,
	output logic cout
);

	/*
	 * a | b | cin || cout | s
	 * --+---+-----++------+--
	 * 0 | 0 | 0   || 0    | 0
	 * 0 | 0 | 1   || 0    | 1
	 * 0 | 1 | 0   || 0    | 1
	 * 0 | 1 | 1   || 1    | 0
	 * 1 | 0 | 0   || 0    | 1
	 * 1 | 0 | 1   || 1    | 0
	 * 1 | 1 | 0   || 1    | 0
	 * 1 | 1 | 1   || 1    | 1
	 */

	assign s = a ^ b ^ cin;
	assign cout = (a & b) | (a & cin) | (b & cin);

endmodule : full_adder
