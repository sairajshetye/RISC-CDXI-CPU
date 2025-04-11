module writeback
#(
            parameter               DEPTH     = 16,
            parameter               PTR_SIZE  = $clog2(DEPTH),
            parameter               WIDTH     = 32

)(
    input dp_is_stage_reg_t inst_in_wb
    //is_wb_stage_reg_t

    //output deq signal for pre_wb queue

    //output wb to prf

    //output wb to robert
    output logic     [PTR_SIZE-1:0]     rob_idx_out,   //to robert

    //output wb to res stations
    output   logic   [PTR_SIZE-1:0]     p_addr_out,     //to res station + prf

    output   logic   [WIDTH-1:0]        data_out,    //to all

    output  logic                       deq         //for pre-wb queue
);
//need new ports to prf & robert, change reservation station port?
//if we do a CDB need to output all info as one thing, then select parts the thing needs
//might be better to do individual ports

    logic wb_done;      //deq signal for pre_wb queue



//add 00 to MSB end of addr if phys reg isnt used

    always_comb begin
        p_addr_out = inst_in_wb.rd_paddr;
        data_out = inst_in_wb.rd_data;
        rob_idx_out = inst_in_wb.rob_idx;
        //prf_out?

        //confirm wb is done? then send deq signal to pre-wb queue
        deq = '0;

    end





endmodule : writeback