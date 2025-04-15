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


#JALR




halt:
    slti x0, x0, -256