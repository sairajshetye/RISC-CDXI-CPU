module rename_alloc
import rv32i_types::*;
(
    input id_ex_stage_reg_t id_ex, // comes from decode queue

    // inputs from RAT, FL, stalls?

    // output to ROB + dispatch, RAT

    output ra_dp_stage_reg_t ra_dp
);


    // 1. rename the rd of the input instruction
    // - dequeue the free list -> read from free list (comb read)
    // take the addr from the free list and put that into the RAT entry

    // 2. allocate the rob
    // enqueue into the rob
    // - set rob idx in the ra_dp 

    // 3. send to dispatch



endmodule : rename_alloc