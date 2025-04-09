module dispatch
import rv32i_types::*;
(
    input ra_dp_stage_reg_t ra_dp, // comes from decode queue

    // stalls ?

    // output enq/load to RS

    input  logic            dispatch_stall_mult,
    input  logic            dispatch_stall_int,
    

    output dp_is_stage_reg_t dp_is
);


    // 1. send a read request to the ARF and PRF
    // 2. choose which rs to go to -> set the load/enq to RS

    // in cpu choose where arf and prf goes to



endmodule : dispatch