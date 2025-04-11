module writeback
import rv32i_types::*;
#(
            parameter               DEPTH     = 16,
            parameter               PTR_SIZE  = $clog2(DEPTH),
            parameter               WIDTH     = 32

)(
    input dp_is_stage_reg_t inst_in_wb,
    //is_wb_stage_reg_t

    //output deq signal for pre_wb queue

    //output wb to prf
    output   logic                   prf_regf_we,

    //output wb to robert
    output   logic                   ld_status,
    output   status_t                status_out,
    output   logic [3:0]             rob_idx_ld, 


    //output wb to res stations
    output   logic   [6:0]           p_addr_out,     //to res station + prf

    output   logic   [WIDTH-1:0]        data_out    //to all

    //output  logic                       deq         //for pre-wb queue
);

    always_comb begin
        if (inst_in_wb.valid) begin
            //deq = '0;
            prf_regf_we = '0;

            //res stations & prf signals out
            p_addr_out = inst_in_wb.rd_paddr;
            data_out = inst_in_wb.rd_data;
            prf_regf_we = '1;

            //robert signals out
            status_out = done;
            ld_status = '1;
            rob_idx_ld = inst_in_wb.rob_idx;

            //confirm wb is done? then send deq signal to pre-wb queue
            //prf_regf_we = '0;
            //deq = '1;

        end else begin
            //deq = '0;
            prf_regf_we = '0;

            //res stations & prf signals out
            p_addr_out = '0;
            data_out = '0;
            prf_regf_we = '0;


            //robert signals out
            status_out = waiting;
            ld_status = '0;
            rob_idx_ld = '0;

            //prf_regf_we = '0;
            //deq = '1;
        end

    end





endmodule : writeback