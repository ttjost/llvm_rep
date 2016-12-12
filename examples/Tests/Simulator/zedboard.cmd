MEMORY
{
    ram (RWX) : ORIGIN = 0x00000000, LENGTH = 0x3FFFFF
}

__STACK_START = 0x8000000;

SECTIONS {
    .text : {
        _start.o(.text)
        *(.text)
        *(.rodata)
        *(.init)
        *(.fini)
    } > ram

    .data : {
        *(.data)
            . = ALIGN (4);
    } > ram

    .bss : {
        __BSS_START = .;
        *(.bss)
        *(COMMON)
            . = ALIGN (4);
        __BSS_END = .;
    } > ram
}

__BSS_LEN = (__BSS_END - __BSS_START);

