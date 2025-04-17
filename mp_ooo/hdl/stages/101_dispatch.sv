module dispatch
import rv32i_types::*;
(
    input ra_dp_stage_reg_t ra_dp, // comes from decode queue

    // stalls ?
    input  logic            dispatch_stall_mult,
    input  logic            dispatch_stall_int,
    input logic             dispatch_stall_br,
    //input logic             dispatch_stall_mem,

    // output enq/load to RS
    output logic            load_station_mult,
    output logic            load_station_int,
    output logic            load_station_br,
    //output logic            load_station_mem,

    input logic [31:0]   rs1_rdata,
    input logic [31:0]   rs2_rdata,
    input logic          rs1_ready, rs2_ready,

    // FORWARD FROM THE BUS
    input logic [6:0]    data_paddr_0,
    input logic [31:0]   data_in_0,
    input logic [6:0]    data_paddr_1,
    input logic [31:0]   data_in_1,
    input logic [6:0]    data_paddr_2,
    input logic [31:0]   data_in_2,
    // input logic [6:0]    data_paddr_3,
    // input logic [31:0]   data_in_3,


    output dp_is_stage_reg_t dp_is,
    output logic             valid_output_mult,
    output logic             valid_output_int,
    output logic             valid_output_br
);


    // 1. send a read request to the ARF and PRF
    // 2. choose which rs to go to -> set the load/enq to RS

    // in cpu choose where arf and prf goes to
    // set ready and data bits, since get data from register file in this stage
    always_comb begin
        dp_is.inst = ra_dp.inst;
        dp_is.pc = ra_dp.pc;
        dp_is.order = ra_dp.order;
        dp_is.pc_next = ra_dp.pc_next;
        dp_is.valid = ra_dp.valid;
        dp_is.stall = ra_dp.stall;
        
        dp_is.funct3 = ra_dp.funct3;
        dp_is.funct7 = ra_dp.funct7;
        dp_is.opcode = ra_dp.opcode;
        dp_is.i_imm = ra_dp.i_imm;
        dp_is.s_imm = ra_dp.s_imm;
        dp_is.b_imm = ra_dp.b_imm;
        dp_is.u_imm = ra_dp.u_imm;
        dp_is.j_imm = ra_dp.j_imm;
        dp_is.rs1_s = ra_dp.rs1_s;
        dp_is.use_rs1 = ra_dp.use_rs1;
        dp_is.rs2_s = ra_dp.rs2_s;
        dp_is.use_rs2 = ra_dp.use_rs2;
        dp_is.rd_s = ra_dp.rd_s;

        dp_is.regf_we = ra_dp.regf_we;
        dp_is.is_store = ra_dp.is_store;
        dp_is.use_rd = ra_dp.use_rd;
        dp_is.branch_taken = not_taken;        //for br

        dp_is.use_prs1 = ra_dp.use_prs1;
        dp_is.rs1_paddr = ra_dp.rs1_paddr;
        dp_is.rs1_ready = '0;
        dp_is.rs1_data = '0;

        dp_is.use_prs2 = ra_dp.use_prs2;
        dp_is.rs2_paddr = ra_dp.rs2_paddr;
        dp_is.rs2_ready = '0;
        dp_is.rs2_data = '0;

        dp_is.rd_paddr = ra_dp.rd_paddr;
        dp_is.rd_data = '0;

        dp_is.rob_idx = ra_dp.rob_idx;
        dp_is.rob_overflow = ra_dp.rob_overflow;
        
        // dp_is.useless = '0;
        if (ra_dp.use_rs1) begin
            dp_is.rs1_ready = rs1_ready;
            dp_is.rs1_data = rs1_rdata;
        end
        if (ra_dp.use_rs2) begin
            dp_is.rs2_ready = rs2_ready;
            dp_is.rs2_data = rs2_rdata;
        end

        // FORWARDING
        if (!dp_is.rs1_ready && ra_dp.use_rs1 && ra_dp.rs1_paddr == data_paddr_0) begin
            dp_is.rs1_ready = '1;
            dp_is.rs1_data = data_in_0;
        end 
        else if (!dp_is.rs1_ready && ra_dp.use_rs1 && ra_dp.rs1_paddr == data_paddr_1) begin
            dp_is.rs1_ready = '1;
            dp_is.rs1_data = data_in_1;
        end
        else if (!dp_is.rs1_ready && ra_dp.use_rs1 && ra_dp.rs1_paddr == data_paddr_2) begin
            dp_is.rs1_ready = '1;
            dp_is.rs1_data = data_in_2;
        end
        // else if (!dp_is.rs1_ready && ra_dp.use_rs1 && ra_dp.rs1_paddr == data_paddr_3) begin
        //     dp_is.rs1_ready = '1;
        //     dp_is.rs1_data = data_in_3;
        // end

        if (!dp_is.rs2_ready && ra_dp.use_rs2 && ra_dp.rs2_paddr == data_paddr_0) begin
            dp_is.rs2_ready = '1;
            dp_is.rs2_data = data_in_0;
        end
        else if (!dp_is.rs2_ready && ra_dp.use_rs2 && ra_dp.rs2_paddr == data_paddr_1) begin
            dp_is.rs2_ready = '1;
            dp_is.rs2_data = data_in_1;
        end
        else if (!dp_is.rs2_ready && ra_dp.use_rs2 && ra_dp.rs2_paddr == data_paddr_2) begin
            dp_is.rs2_ready = '1;
            dp_is.rs2_data = data_in_2;
        end
        // else if (!dp_is.rs2_ready && ra_dp.use_rs2 && ra_dp.rs2_paddr == data_paddr_3) begin
        //     dp_is.rs2_ready = '1;
        //     dp_is.rs2_data = data_in_3;
        // end
        
 
        if (dispatch_stall_mult) begin 
            valid_output_mult = '0;
        end else begin
            valid_output_mult = '1;
        end

        if (dispatch_stall_int) begin 
            valid_output_int = '0;
        end else begin
            valid_output_int = '1;
        end
        if (dispatch_stall_br) begin
            valid_output_br = '0;
        end else begin
            valid_output_br = '1;
        end

        dp_is.rfvi_monitor_vals = ra_dp.rfvi_monitor_vals;

    end

    // choose which reservation station to load with the 
    always_comb begin
        load_station_mult = '0;
        load_station_int = '0;
        //load_station_mem = '0;
        load_station_br = '0;
        unique case (ra_dp.opcode)
                op_b_lui    : begin
                    load_station_mult = '0;
                    load_station_int = '1;
                end
                op_b_auipc  : begin
                    load_station_mult = '0;
                    load_station_int = '1;
                end
                op_b_jal    : begin
                    load_station_mult = '0;
                    load_station_int = '0;
                    load_station_br = '1;
                end
                op_b_jalr   : begin
                    load_station_mult = '0;
                    load_station_int = '0;
                    load_station_br = '1;
                end
                op_b_br     : begin
                    load_station_mult = '0;
                    load_station_int = '0;
                    load_station_br = '1;
                end
                op_b_load   : begin
                    load_station_mult = '0;
                    load_station_int = '0;
                end
                op_b_store  : begin
                    load_station_mult = '0;
                    load_station_int = '0;
                end
                op_b_imm    : begin
                    load_station_mult = '0;
                    load_station_int = '1;
                end
                op_b_reg    : begin
                    // This is the opcode of the extension RV32M Multiply Instructions
                    if (ra_dp.funct7 == funct7_mult) begin 
                        load_station_mult = '1;
                        load_station_int = '0;
                    end else begin // otherwise normal register instructions
                        load_station_mult = '0;
                        load_station_int = '1;
                    end
                end
                default     : begin
                    load_station_mult = '0;
                    load_station_int = '0;
                end
        endcase
    end

endmodule : dispatch