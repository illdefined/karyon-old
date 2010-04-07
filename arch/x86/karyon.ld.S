#include <memory.h>

OUTPUT_FORMAT("elf64-x86-64", "elf64-x86-64", "elf64-x86-64")
OUTPUT_ARCH(i386:x86-64)
ENTRY(_entry)

PHDRS {
	multiboot PT_NOTE FLAGS(0);
	text      PT_LOAD FLAGS(5);
	rodata    PT_LOAD FLAGS(4);
	data      PT_LOAD FLAGS(6);
}

SECTIONS {
	.multiboot : {
		*(.multiboot)
	} :multiboot

	. = KERN_BASE + SIZEOF_HEADERS;

	.text ALIGN(PAGE_SIZE) :
	AT(ADDR(.text) - KERN_BASE) {
		*(.text)
	} :text =0x90909090

	.stack ALIGN(PAGE_SIZE) :
	AT(ADDR(.stack) - KERN_BASE) {
		*(.stack)
	} :data

	.rodata ALIGN(PAGE_SIZE) :
	AT(ADDR(.rodata) - KERN_BASE) {
		*(.rodata)
	} :rodata

	.data ALIGN(PAGE_SIZE) :
	AT(ADDR(.data) - KERN_BASE) {
		*(.data)
	} :data

	.bss ALIGN(WORD_SIZE):
	AT(ADDR(.bss)  - KERN_BASE) {
		*(.bss)
	} :data
}

PROVIDE(_text_page = LOADADDR(.text) / PAGE_SIZE);
PROVIDE(_text_size = ALIGN(SIZEOF(.text), PAGE_SIZE) / PAGE_SIZE);

PROVIDE(_stack_page = LOADADDR(.stack) / PAGE_SIZE);
PROVIDE(_stack_size = ALIGN(SIZEOF(.stack), PAGE_SIZE) / PAGE_SIZE);

PROVIDE(_rodata_page = LOADADDR(.rodata) / PAGE_SIZE);
PROVIDE(_rodata_size = ALIGN(SIZEOF(.rodata), PAGE_SIZE) / PAGE_SIZE);

PROVIDE(_data_page = LOADADDR(.data) / PAGE_SIZE);
PROVIDE(_data_size = ALIGN(ALIGN(SIZEOF(.data), WORD_SIZE) + SIZEOF(.bss), PAGE_SIZE) / PAGE_SIZE);

PROVIDE(_bss_org = LOADADDR(.bss));
PROVIDE(_bss_len = ALIGN(SIZEOF(.bss), WORD_SIZE));
