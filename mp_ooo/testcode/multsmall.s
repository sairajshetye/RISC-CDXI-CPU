.section .text
.globl _start
_start:
    li x8, 10
    li x26, 20
    li x2, 50
    li x17, 60
    li x30, 21
    li x17, 28
    li x11, 8
    li x12, 4
    li x14, 3
    li x15, 1
    divu x17, x2, x8
    mulh x15, x21, x22
    rem x18, x16, x7
    mulhu x16, x1, x30
    mulh x25, x19, x29
    mulh x28, x7, x27
    rem x24, x26, x24
    mul x25, x16, x28
    mul x25, x17, x24
    # mulhsu x31, x12, x21
    # divu x31, x20, x30
    # div x3, x18, x23
    # remu x6, x23, x28
    # mulhu x9, x16, x5
    # rem x2, x12, x18
    # mul x10, x15, x4
    # mulhsu x5, x14, x1
    # remu x12, x24, x13
    # divu x4, x5, x8
    # divu x10, x10, x5

    slti x0, x0, -256
    
    nop
    nop
    nop
    nop
    nop