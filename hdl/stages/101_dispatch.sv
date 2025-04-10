module dispatch
import rv32i_types::*;
(
    input ra_dp_stage_reg_t ra_dp, // comes from decode queue

    // stalls ?
    input  logic            dispatch_stall_mult,
    input  logic            dispatch_stall_int,
    // input logic          dispatch_stall_mem,
    // input logic          dispatch_stall_branch,

    // output enq/load to RS
    output logic            load_funct_mult,
    output logic            load_funct_int,
    // output logic         load_funct_mem,
    // output logic         load_funct_branch,

    input logic [31:0]   rs1_rdata,
    input logic [31:0]   rs2_rdata,

    output dp_is_stage_reg_t dp_is,
    output logic             valid_output
);


    // 1. send a read request to the ARF and PRF
    // 2. choose which rs to go to -> set the load/enq to RS

    // in cpu choose where arf and prf goes to

    // set ready and data bits, since get data from register file in this stage
    always_comb begin
        if (ra_dp.use_rs1) begin
            dp_is.rs1_ready = '1;
            dp_is.rs1_data = rs1_rdata;
        end
        if (ra_dp.use_rs2) begin
            dp_is.rs2_ready = '1;
            dp_is.rs2_data = rs2_rdata;
        end
 
        if (dispatch_stall_mult || dispatch_stall_int) begin 
            valid_output = '0;
        end else begin
            valid_output = '1;
        end
    end

    // choose which reservation station to load with the 
    always_comb begin
        load_funct_mult = '0;
        load_funct_int = '0;
        unique case (ra_dp.opcode)
                op_b_lui    : begin
                    load_funct_mult = '0;
                    load_funct_int = '1;
                end
                op_b_auipc  : begin
                    load_funct_mult = '0;
                    load_funct_int = '1;
                end
                op_b_jal    : begin
                    load_funct_mult = '0;
                    load_funct_int = '0;
                end
                op_b_jalr   : begin
                    load_funct_mult = '0;
                    load_funct_int = '0;
                end
                op_b_br     : begin
                    load_funct_mult = '0;
                    load_funct_int = '0;
                end
                op_b_load   : begin
                    load_funct_mult = '0;
                    load_funct_int = '0;
                end
                op_b_store  : begin
                    load_funct_mult = '0;
                    load_funct_int = '0;
                end
                op_b_imm    : begin
                    load_funct_mult = '0;
                    load_funct_int = '0;
                end
                op_b_reg    : begin
                    // This is the opcode of the extension RV32M Multiply Instructions
                    if (ra_dp.funct7 == funct7_mult) begin 
                        load_funct_mult = '1;
                        load_funct_int = '0;
                    end else begin // otherwise normal register instructions
                        load_funct_mult = '0;
                        load_funct_int = '1;
                    end
                end
        endcase
    end

endmodule : dispatch