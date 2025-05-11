module br_writeback
import rv32i_types::*;
#(
            parameter               DEPTH     = 16,
            parameter               PTR_SIZE_WB  = $clog2(DEPTH),
            parameter               WIDTH     = 32,
            parameter               PTR_SIZE = 6,
            parameter               ROB_PTR_SIZE = 3

)(
    input dp_is_stage_reg_t inst_in_wb,
    input logic need_flush_fu,      //new
    //is_wb_stage_reg_t

    //output deq signal for pre_wb queue

    //output wb to prf
    output   logic                   prf_regf_we,

    //output wb to robert
    output   logic                   ld_status,
    output   status_t                status_out,
    output   logic [3:0]             rob_idx_ld, 
    output   logic                   ld_branch_res,
    output   branch_t                branch_res_out, 


    //output wb to res stations
    output   logic   [PTR_SIZE-1:0]           p_addr_out,     //to res station + prf

    output   logic   [WIDTH-1:0]        data_out,    //to all

    output rfvi_packet_t       rfvi_monitor_vals, 
    output logic [31:0]        br_pc_next,
    output logic                need_flush  //new
    //output logic [63:0]        order_out_wb

    //output  logic                       deq         //for pre-wb queue
);

    always_comb begin
        rfvi_monitor_vals = inst_in_wb.rfvi_monitor_vals;
        
        if (inst_in_wb.valid) begin
            //deq = '0;
            prf_regf_we = '0;

            //res stations & prf signals out
            p_addr_out = inst_in_wb.rd_paddr;
            data_out = inst_in_wb.rd_data;
            prf_regf_we = inst_in_wb.regf_we;   //we = '1 before

            //robert signals out
            status_out = done;
            ld_status = '1;
            rob_idx_ld = inst_in_wb.rob_idx;

            ld_branch_res = '1;
            branch_res_out = inst_in_wb.branch_taken;
            br_pc_next = inst_in_wb.pc_next;
            need_flush = need_flush_fu;     //new
            //order_out_wb = inst_in_wb.order;

            //confirm wb is done? then send deq signal to pre-wb queue
            //prf_regf_we = '0;
            //deq = '1;

        end else begin
            //deq = '0;
            prf_regf_we = '0;

            //res stations & prf signals out
            p_addr_out = '0; // 0 NOT 1!!!!!
            data_out = '0;
            prf_regf_we = '0;


            //robert signals out
            status_out = waiting;
            ld_status = '0;
            rob_idx_ld = '0;

            ld_branch_res = '0;
            branch_res_out = not_taken;
            br_pc_next = '0;
            need_flush = '0;        //new
            //order_out_wb = '0;

            //prf_regf_we = '0;
            //deq = '1;
        end

    end





endmodule : br_writeback