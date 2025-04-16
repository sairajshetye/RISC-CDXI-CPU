.section .text
.globl _start
_start:
li x1, 10
li x2, 20
li x5, 50
li x6, 60
li x8, 21
li x9, 28
li x11, 8
li x12, 4
li x14, 3
li x15, 1



#AUIPC
auipc x4, 0
auipc x5, 400


#BR 


#JAL
jal x7, mixed # need to have offset label, doesn't work otherwise

#JALR




mixed:
xori x12, x13, -61
    and x6, x0, x0
    srli x17, x1, 17
    sra x26, x26, x1
    andi x16, x2, 267
    andi x20, x24, 209
    xori x18, x1, 652
    addi x6, x30, -1417
    or x29, x19, x13
    andi x5, x11, -1077
    div x15, x14, x13
    lui x22, 991385
    lui x15, 446636
    lui x27, 477714
    xor x17, x27, x22
    lui x31, 478462


halt:
    slti x0, x0, -256

    
