#include <verilated.h>
#include <stdlib.h>
#include <time.h>
#include "Vfaulty_adder.h"

/*
 * TryCase
 * Randomly attempt to add two numbers, confirming the sum is correct.
 *
 * Inputs:
 *  - t: A pointer to a Vfaulty_adder object
 *
 * Return value: true when sum is correct, false otherwise.
 */
bool TryCase(Vfaulty_adder *t) {
	if (!t) return false;

	t->a = random();
	t->b = random();
	t->clk = 0;
	t->eval();
	t->clk = 1;
	t->eval();

	bool correct = t->a + t->b == t->s;

	printf("[%s] %u + %u = %u\n", correct ? "✅" : "❌", t->a, t->b, t->s);
	return correct;
}

/*
 * Init
 * Perform SystemVerilog-level initialization of DUT from testbench.
 *
 * Inputs:
 *  - t: A pointer to a Vfaulty_adder object
 *
 * Return value: None.
 */
void Init(Vfaulty_adder *t) {
	if (!t) return;
	t->a = 0;
	t->b = 0;
	t->clk = 0;
	t->reset = 1;
	t->eval();
	t->clk = 1;
	t->eval();

	t->reset = 0;
	t->clk = 0;
	t->eval();
	t->clk = 1;
	t->eval();
}

int main(int argc, char **argv) {
	printf("Starting...\n");
	Verilated::commandArgs(argc, argv);

	srand(time(NULL));
	Vfaulty_adder *top = new Vfaulty_adder();
	Init(top);

	while (!Verilated::gotFinish()) {
		if (!TryCase(top)) {
			exit(-1);
		}
	}
}