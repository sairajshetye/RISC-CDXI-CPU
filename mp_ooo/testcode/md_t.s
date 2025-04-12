ooo_test.s:
.align 4
.section .text
.globl _start
    # This program will provide a simple test for
    # demonstrating OOO-ness

    # This test is NOT exhaustive
_start:

# initialize
li x1, -10
li x2, -20
li x5, 50
li x6, 61
li x8, -11
li x9, 3
li x11, 8
li x12, 4
li x14, 3
li x15, 1
li x16, 2
li x21, -1
li x22, -2048
# -2147483648 




# mul x3, x1, x2

# mulh x4, x5, x6

# #mulhsu x7, x8, x9

# mulhu x13, x2, x11

# div x17, x2, x1

# divu x18, x5, x16

# rem x19, x8, x11

# remu x20, x6, x14

#div by 0 tests
div x1, x15, x0

divu x2, x3, x0

rem x4, x12, x0

remu x5, x6, x0

# overflow/div 0 tests:
slli x23, x22, 15
slli x24, x23, 5
# div x25, x24, x21


# rem x27, x24, x21



nop
nop
nop
nop

halt:
    slti x0, x0, -256