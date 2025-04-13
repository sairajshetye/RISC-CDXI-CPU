.section .text
.globl _start
_start:
    divu x17, x2, x8
    mulh x15, x21, x22
    rem x18, x16, x7
    mulhu x16, x1, x30
    mulh x25, x19, x29
    mulh x28, x7, x27
    rem x24, x26, x24
    mul x25, x16, x28
    slti x0, x0, -256
    nop
    nop
    nop
    nop
    nop