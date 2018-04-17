#include <test_vector.h>

#define PULSE (uint16_t)((float)0.5*32768)

uint16_t test_vector[TEST_VECTOR_SIZE] =
{
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
	PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0,
 PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0, PULSE, PULSE, PULSE, PULSE, PULSE, 0, 0, 0, 0, 0
};