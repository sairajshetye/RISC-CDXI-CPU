.section .text
.globl _start
_start:
    addi x1, x0, 4
    nop             # nops in between to prevent hazard
    nop
    nop
    nop
    nop
    auipc x2, 0 # pc into register 2
    nop
    nop
    nop
    nop
    nop
    lui x31, 908765
    nop
    nop
    nop
    nop
    nop
    lw x3, 4(x2) # load inst into x3 using addr in x2 
    lh x4, 0(x2) # load inst into x3 using addr in x2 
    lhu x5, 4(x2) # load inst into x3 using addr in x2 
    lb x5, 0(x2) # load inst into x3 using addr in x2 
    lbu x6, 4(x2) # load inst into x3 using addr in x2 
    nop
    nop
    nop
    nop
    nop
    sh x2, 4(x31)
    sb x0, 8(x31)
    sw x0, 0(x31)
    nop
    nop
    nop
    nop
    nop
    

    slti x0, x0, -256 # this is the magic instruction to end the simulation
    nop               # preventing fetching illegal instructions
    nop
    nop
    nop
    nop