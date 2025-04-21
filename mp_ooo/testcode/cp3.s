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

# need to have offset label, doesn't work otherwise

jal x7, mixed 
jal x5, mixed

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


    li x1, 10         # x1 = 10
    li x2, 10         # x2 = 10
    li x3, 5          # x3 = 5
    li x4, 15         # x4 = 15
    li x5, 0          # x5 = 0 (used for storing return addresses)
    li x6, 100        # x6 = address placeholder

    #########################
    # Branch Tests
    #########################

    beq x1, x2, label_beq_pass   # should branch
    nop                          # should be skipped
label_beq_pass:
    bne x1, x3, label_bne_pass   # should branch
    nop
label_bne_pass:
    blt x3, x1, label_blt_pass   # 5 < 10, should branch
    nop
label_blt_pass:
    bge x1, x3, label_bge_pass   # 10 >= 5, should branch
    nop
label_bge_pass:
    bltu x3, x1, label_bltu_pass # 5 < 10 unsigned
    nop
label_bltu_pass:
    bgeu x1, x3, label_bgeu_pass # 10 >= 5 unsigned
    nop
label_bgeu_pass:

    #########################
    # JAL Test
    #########################
    jal x5, label_jal_target     # x5 = return address
    nop                          # skipped due to jump
label_jal_target:
    # x5 holds return address here

    #########################
    # JALR Test
    #########################
    la x7, label_jalr_target     # load address of label into x7
    jalr x5, 0(x7)               # jump to label_jalr_target
    nop                          # skipped
label_jalr_target:
    # x5 holds return address

    #########################
    # End
    #########################
    nop                          # placeholder
    nop

and x1, x1, x0

label:
    addi x1, x1, 1
    blt x1, x2, label


end:
    slti x0, x0, -256

    
