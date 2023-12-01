#include <verilated.h>
#include <stdlib.h>
#include <time.h>
#include "Vripple_carry.h"

/*
 * TryCase
 * Randomly attempt to add two numbers, confirming the sum is correct.
 *
 * Inputs:
 *  - t: A pointer to a Vripple_carry object
 *
 * Return value: true when sum is correct, false otherwise.
 */
bool TryCase(Vripple_carry *t) {
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
 *  - t: A pointer to a Vripple_carry object
 *
 * Return value: None.
 */
void Init(Vripple_carry *t) {
	if (!t) return;
	t->a = 0;
	t->b = 0;
	t->eval();
}

int main(int argc, char **argv) {
	printf("Starting...\n");
	Verilated::commandArgs(argc, argv);

	srand(time(NULL));
	Vripple_carry *top = new Vripple_carry();
	Init(top);

	while (!Verilated::gotFinish()) {
		if (!TryCase(top)) {
			exit(-1);
		}
	}
}