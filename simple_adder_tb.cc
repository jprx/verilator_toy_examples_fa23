#include <verilated.h>
#include <stdlib.h>
#include <time.h>
#include "Vsimple_adder.h"

/*
 * TryCase
 * Randomly attempt to add two numbers, confirming the sum is correct.
 *
 * Inputs:
 *  - t: A pointer to a Vsimple_adder object
 *
 * Return value: true when sum is correct, false otherwise.
 */
bool TryCase(Vsimple_adder *t) {
	if (!t) return false;

	t->a = random();
	t->b = random();
	t->eval();

	bool correct = t->a + t->b == t->s;

	printf("[%s] 0x%X + 0x%X = 0x%X\n", correct ? "✅" : "❌", t->a, t->b, t->s);
	return correct;
}

/*
 * Init
 * Perform SystemVerilog-level initialization of DUT from testbench.
 *
 * Inputs:
 *  - t: A pointer to a Vsimple_adder object
 *
 * Return value: None.
 */
void Init(Vsimple_adder *t) {
	if (!t) return;
	t->a = 0;
	t->b = 0;
	t->eval();
}

int main(int argc, char **argv) {
	printf("Starting...\n");
	Verilated::commandArgs(argc, argv);

	srand(time(NULL));
	Vsimple_adder *top = new Vsimple_adder();
	Init(top);

	while (!Verilated::gotFinish()) {
		TryCase(top);
	}
}