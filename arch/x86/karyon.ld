OUTPUT_FORMAT("elf64-x86-64", "elf64-x86-64", "elf64-x86-64")
OUTPUT_ARCH(i386:x86-64)
ENTRY(_entry)

_origin_virt = 0xFFFF800000000000;
_page_size = CONSTANT(COMMONPAGESIZE);
_word_size = 8;

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

	. = _origin_virt + SIZEOF_HEADERS;

	.text ALIGN(_page_size) :
	AT(ADDR(.text) - _origin_virt) {
		*(.text)
	} :text =0x90909090

	.stack ALIGN(_page_size) :
	AT(ADDR(.stack) - _origin_virt) {
		*(.stack)
	} :data

	.rodata ALIGN(_page_size) :
	AT(ADDR(.rodata) - _origin_virt) {
		*(.rodata)
	} :rodata

	.data ALIGN(_page_size) :
	AT(ADDR(.data) - _origin_virt) {
		*(.data)
	} :data

	.bss ALIGN(_word_size):
	AT(ADDR(.bss)  - _origin_virt) {
		*(.bss)
	} :data
}

PROVIDE(_text_virt = ADDR(.text));
PROVIDE(_text_phys = LOADADDR(.text));
PROVIDE(_text_size = SIZEOF(.text));

PROVIDE(_stack_virt = ADDR(.stack));
PROVIDE(_stack_phys = LOADADDR(.stack));
PROVIDE(_stack_size = SIZEOF(.stack));

PROVIDE(_rodata_virt = ADDR(.rodata));
PROVIDE(_rodata_phys = LOADADDR(.rodata));
PROVIDE(_rodata_size = SIZEOF(.rodata));

PROVIDE(_data_virt = ADDR(.data));
PROVIDE(_data_phys = LOADADDR(.data));
PROVIDE(_data_size = SIZEOF(.data));

PROVIDE(_bss_virt = ADDR(.bss));
PROVIDE(_bss_phys = LOADADDR(.bss));
PROVIDE(_bss_size = SIZEOF(.bss));

PROVIDE(_ptbl_phys = ptbl - _origin_virt);
