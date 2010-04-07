#define __ASSEMBLY__
#include <memory.h>

	.section .stack, "wa", @nobits
	.align WORD_SIZE
	.global stack
stack:
	.space PAGE_SIZE
