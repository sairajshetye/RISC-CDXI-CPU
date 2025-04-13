module cpu
import rv32i_types::*;
(
    input   logic               clk,
    input   logic               rst,

    output  logic   [31:0]      bmem_addr,
    output  logic               bmem_read,
    output  logic               bmem_write,
    output  logic   [63:0]      bmem_wdata,
    input   logic               bmem_ready,

    input   logic   [31:0]      bmem_raddr,
    input   logic   [63:0]      bmem_rdata,
    input   logic               bmem_rvalid
);

    logic [31:0] pc;
    logic [31:0] pc_next;

    logic iq_enq, dq_enq, rq_enq, fl_enq, rob_enq, wb_int_enq, wb_mult_enq, fl_enq_rob, decode_stall;
    logic iq_deq, dq_deq, rq_deq, fl_deq, wb_int_deq, wb_mult_deq;

    if_id_stage_reg_t if_id_reg_next, if_id_inst_out;
    id_ex_stage_reg_t id_ex_reg_next, id_ex_inst_out;
    ra_dp_stage_reg_t ra_dp_reg_next, ra_dp_inst_out;
    dp_is_stage_reg_t dp_is_inst_out, dp_is_out_mult, dp_is_out_int;
    dp_is_stage_reg_t int_to_wb, mult_to_wb, wb_reg_next, wb_int_out, wb_mult_out;


    // WRITE BACKS
    dp_is_stage_reg_t   wb_inst_out         [2];
    logic               prf_we              [2]; 
    logic               ld_status           [2];
    status_t            status_n            [2];
    logic   [3:0]       rob_idx_ld          [2];
    logic   [6:0]       p_addr_out_wb       [2];
    logic   [31:0]      wb_data_out         [2];
    rfvi_packet_t       rfvi_monitor_vals   [2];

    rob_entry_t rob_entry, rob_out;

    logic [255:0] cache_rdata;

    logic [31:0] cache_rdata_32;

    logic [255:0] lb_rdata;

    logic iq_valid_rdata, dq_valid_rdata, rq_valid_rdata, fl_valid_rdata, rob_valid_rdata, int_valid_rdata, mult_valid_rdata;
    logic iq_stall, dq_stall, rq_stall, fl_stall, rob_stall, int_wb_stall, mult_wb_stall;

    //logic [31:0] rs1_v, rs2_v;
    logic [4:0] rs1_s, rs2_s;
    logic [6:0] prs1_s, prs2_s;

    logic [6:0] fl_data_in, p_addr_out; // free list

    logic [3:0] rob_tail_idx;
    logic [6:0] rs1_paddr, rs2_paddr;

    logic [4:0] rat_rs1, rat_rs2;

    arf_reg_t ars1_v, ars2_v;
    prf_t     prs1_v, prs2_v;

    logic       rs1_renamed, rs2_renamed;
    logic       rename_we;
    logic       rs1_ready, rs2_ready;
    
    logic           rob_overflow;
   


    //logic big_valid;


    // cache port variables

    logic   [31:0]  ufp_addr;
    logic   [3:0]   ufp_rmask;
    logic   [3:0]   ufp_wmask;
    logic   [255:0]  ufp_rdata;
    logic   [31:0]  ufp_wdata;
    logic           ufp_resp;

    logic   [31:0]  dfp_addr;
    logic           dfp_read;
    logic           dfp_write;
    logic   [255:0] dfp_rdata;
    logic   [255:0] dfp_wdata;
    logic           dfp_resp;
    
    // other arbiter variables

    logic [31:0] a_raddr;

    logic           aregf_we;
    logic [4:0]     ard_s;
    logic [6:0]     p_addr_ret;
    
    //logic [6:0]     commit_rs;
    prf_t           commit_prs;

    

    // always_ff @ (posedge clk) begin
    //     if (rst) begin
    //         big_valid <= '0;
    //     end
    //     else if ()

    // end

    logic dispatch_stall_mult, dispatch_stall_int;

    logic load_station_mult, load_station_int;
    logic funct_mult_busy, funct_int_busy, funct_mult_done;

    logic [31:0] rs1_rdata, rs2_rdata;

    logic valid_output_mult, valid_output_int;

    logic valid_rdata_mult, valid_rdata_int;

    assign ufp_wdata = '0;
    assign ufp_wmask = '0;

    assign rs1_s = ra_dp_reg_next.rs1_s;
    assign rs2_s = ra_dp_reg_next.rs2_s;
    assign prs1_s = ra_dp_reg_next.rs1_paddr;
    assign prs2_s = ra_dp_reg_next.rs2_paddr;

    assign wb_int_enq = int_to_wb.valid && !funct_int_busy;
    assign wb_mult_enq = mult_to_wb.valid && funct_mult_done;
    

    always_comb begin
        if (|ufp_rmask && ufp_resp) begin
            cache_rdata = ufp_rdata;
        end else begin
            cache_rdata = '0;
        end

        for (integer unsigned i = 0; i < 4; i++) begin
            // ufp_addr[4:0] = offset
            cache_rdata_32[unsigned'(i)*8+:8] = cache_rdata[((pc[4:0]*8)+(unsigned'(i)*8))+:8]; 
        end
    end

    always_comb begin
        if (rst) begin
            pc_next = 32'hAAAAA000;
        end else if (!iq_stall && !if_id_reg_next.fetch_stall) begin // && !if_id_reg_next.fetch_stall
            pc_next = pc + 4;
        end else begin
            pc_next = pc;
        end
    end

    pcreg pcreg(
        .clk(clk),
        .rst(rst),
        .pc(pc),
        .pc_next(pc_next)
    );

    if_stage if_stage_1 (
        .clk(clk),
        .rst(rst),
        .iq_stall(iq_stall),
        .dq_stall(dq_stall),
        .enq(iq_enq),
        .deq(iq_deq),
        .imem_addr(ufp_addr),
        .imem_rmask(ufp_rmask),
        .imem_rdata(cache_rdata_32),
        .imem_resp(ufp_resp),
        .pc(pc),
        .pc_next(pc_next),
        .if_id(if_id_reg_next)
    );

    inst_q #(
        .DEPTH      (8)
    ) inst_q(
        .clk(clk),
        .rst(rst),
        .enq(iq_enq),
        .deq(iq_deq),
        .inst_in(if_id_reg_next),
        .inst_out(if_id_inst_out),
        .valid_rdata(iq_valid_rdata),
        .iq_stall(iq_stall)
    );

    id_stage id_stage_1 (
        .if_id(if_id_inst_out),
        //.rs1_v(rs1_v),
        //.rs2_v(rs2_v),
        .rq_stall(rq_stall),
        .enq(dq_enq),
        .deq(dq_deq),
        // .rs1_s(rs1_s),
        // .rs2_s(rs2_s),
        .id_ex(id_ex_reg_next)
    );

    decode_q #(
        .DEPTH      (8)
    ) decode_q(
        .clk(clk),
        .rst(rst),
        .enq(dq_enq),
        .deq(dq_deq && !(decode_stall | rob_stall)),
        .inst_in_d(id_ex_reg_next),
        .inst_out_d(id_ex_inst_out),
        .valid_rdata(dq_valid_rdata),
        .dq_stall(dq_stall)
    );

    rename_alloc rename_alloc_1 (
        .id_ex(id_ex_inst_out), // comes from decode queue
        // inputs from RAT, FL, stalls?
        .p_addr(p_addr_out), // FL
        .rob_idx(rob_tail_idx),
        .rob_overflow(rob_overflow),
        
        // from RAT
        .rs1_renamed(rs1_renamed), 
        .rs2_renamed(rs2_renamed),
        .rs1_paddr(rs1_paddr), 
        .rs2_paddr(rs2_paddr),
        .res_stall(dispatch_stall_mult || dispatch_stall_int),
        .rob_stall(rob_stall),
        // output to ROB + dispatch, RAT
        .enq(rq_enq),
        .deq(rq_deq),
        .rename_we(rename_we),
        .fl_deq(fl_deq),
        .rob_enq(rob_enq),
        // to RAT
        .rat_rs1(rat_rs1),
        .rat_rs2(rat_rs2),
        .rob_entry(rob_entry),
        .ra_dp(ra_dp_reg_next)
    );

    rat_arf rat_arf_1 (
        .clk(clk),
        .rst(rst),
        .regf_we(aregf_we),
        .rd_v(commit_prs.value),
        .rs1_s(rs1_s), 
        .rs2_s(rs2_s), 
        .rd_s(ard_s),
        .rename_we(rename_we),
        .rd_rename(ra_dp_reg_next.rd_s),
        .p_addr(ra_dp_reg_next.rd_paddr), // speculative (rat)
        .p_addr_ret(p_addr_ret), // rrf
        .rat_rs1(rat_rs1), 
        .rat_rs2(rat_rs2),
        .rs1_renamed(rs1_renamed), 
        .rs2_renamed(rs2_renamed),
        .rs1_paddr(rs1_paddr), 
        .rs2_paddr(rs2_paddr),
        .fl_enq(fl_enq),
        .fl_data_in(fl_data_in),
        .ars1_v(ars1_v), 
        .ars2_v(ars2_v)
    );

    prf prf (
        .clk(clk),
        .rst(rst),
        .regf_we_0(prf_we[0]),
        .regf_we_1(prf_we[1]),
        .rd_v_0(wb_data_out[0]),
        .rd_v_1(wb_data_out[1]),
        .rs1_s(prs1_s), 
        .rs2_s(prs2_s), 
        .rd_s_0(p_addr_out_wb[0]),
        .rd_s_1(p_addr_out_wb[1]),
        .commit_rs(p_addr_ret),
        .prs1_v(prs1_v), 
        .prs2_v(prs2_v),
        .free_we(fl_enq),
        .rd_s_free(fl_data_in),
        .commit_prs(commit_prs)
    );

    rename_q #(
        .DEPTH      (8)
    ) rename_q(
        .clk(clk),
        .rst(rst),
        .enq(rq_enq),
        .deq(rq_deq),
        .inst_in_r(ra_dp_reg_next),
        .inst_out_r(ra_dp_inst_out),
        .valid_rdata(rq_valid_rdata),
        .rq_stall(rq_stall)
    );

    dispatch dispatch(
        .ra_dp(ra_dp_inst_out), // comes from rename queue, input

        .dispatch_stall_mult('0), // input
        .dispatch_stall_int('0), // input

        .load_station_mult(load_station_mult), // output
        .load_station_int(load_station_int), // output

        .rs1_rdata(rs1_rdata), // input from the register file arbiter
        .rs2_rdata(rs2_rdata), // input from the register file arbiter
        .rs1_ready(rs1_ready),
        .rs2_ready(rs2_ready),

        .data_paddr_0(p_addr_out_wb[0]),
        .data_paddr_1(p_addr_out_wb[1]),
        .data_in_0(wb_data_out[0]),
        .data_in_1(wb_data_out[1]),

        .dp_is(dp_is_inst_out), // output
        .valid_output_mult(valid_output_mult), // output
        .valid_output_int(valid_output_int) // output
    );

    r_station station_mult(
        .clk(clk), // input
        .rst(rst), // input
        .funct_unit_busy(funct_mult_busy), // input
        .load_station(load_station_mult),
        .inst_in(dp_is_inst_out), // input
        .inst_out(dp_is_out_mult), // output
        .valid_rdata(valid_rdata_mult), // output
        .dispatch_stall(dispatch_stall_mult), // output
        .data_paddr_0(p_addr_out_wb[0]), // input
        .data_paddr_1(p_addr_out_wb[1]), // input
        .data_in_0(wb_data_out[0]), // input
        .data_in_1(wb_data_out[1]) // input
    );

    r_station station_int(
        .clk(clk), // input
        .rst(rst), // input
        .funct_unit_busy(funct_int_busy), // input
        .load_station(load_station_int),
        .inst_in(dp_is_inst_out), // input
        .inst_out(dp_is_out_int), // output
        .valid_rdata(valid_rdata_int), // output
        .dispatch_stall(dispatch_stall_int), // output
        .data_paddr_0(p_addr_out_wb[0]), // input
        .data_paddr_1(p_addr_out_wb[1]), // input
        .data_in_0(wb_data_out[0]), // input
        .data_in_1(wb_data_out[1]) // input
    );

    // r_station_new station_mult(
    //     .clk(clk), // input
    //     .rst(rst), // input
    //     .funct_unit_busy(funct_mult_busy), // input
    //     .load_station(load_station_mult),
    //     .inst_in(dp_is_inst_out), // input
    //     .inst_out(dp_is_out_mult), // output
    //     .valid_rdata(valid_rdata_mult), // output
    //     .rename_q_stall(dispatch_stall_mult), // output
    //     .data_paddr(p_addr_out_wb), // input
    //     .data_in(wb_data_out) // input
    // );

    // r_station_new station_int(
    //     .clk(clk), // input
    //     .rst(rst), // input
    //     .funct_unit_busy(funct_int_busy), // input
    //     .load_station(load_station_int),
    //     .inst_in(dp_is_inst_out), // input
    //     .inst_out(dp_is_out_int), // output
    //     .valid_rdata(valid_rdata_int), // output
    //     .rename_q_stall(dispatch_stall_int), // output
    //     .data_paddr(p_addr_out_wb), // input
    //     .data_in(wb_data_out) // input
    // );

    multiply_divide_unit funct_mult(
        .clk(clk),
        .rst(!rst),
        .rs_out(dp_is_out_mult),
        .pre_wb_mult_stall(mult_wb_stall),
        //.rs1_v(),
        //.rs2_v(),
        .funct_unit_busy(funct_mult_busy),
        .out_inst(mult_to_wb),
        .funct_mult_done(funct_mult_done)
    );

    integer_unit funct_int(
        .id_ex(dp_is_out_int),
        .pre_wb_int_stall(int_wb_stall),
        //.rs1_v(),
        //.rs2_v(),
        .funct_unit_busy(funct_int_busy),
        .ex_mem(int_to_wb)
    );

    pre_wb_q #(
        .DEPTH      (8)
    ) int_fu_q (
        .clk(clk),
        .rst(rst),
        .enq(wb_int_enq),
        .ready_deq(wb_int_deq),
        .inst_in_wb(int_to_wb),
        .inst_out_wb(wb_inst_out[0]),
        .valid_rdata(int_valid_rdata),
        .wb_stall(int_wb_stall)
    );
    pre_wb_q #(
        .DEPTH      (8)
    ) mult_fu_q (
        .clk(clk),
        .rst(rst),
        .enq(wb_mult_enq),
        .ready_deq(wb_mult_deq),
        .inst_in_wb(mult_to_wb),
        .inst_out_wb(wb_inst_out[1]),
        .valid_rdata(mult_valid_rdata),
        .wb_stall(mult_wb_stall)
    );

    always_comb begin
        wb_int_deq = '1;
        wb_mult_deq = '1;

        // if (wb_int_enq && wb_mult_enq) begin // both same
        //     if (int_to_wb.rob_idx < mult_to_wb.rob_idx) begin
        //         wb_int_deq = '1;
        //         wb_mult_deq = '0;
        //     end 
        //     else begin
        //         wb_int_deq = '0;
        //         wb_mult_deq = '1;
        //     end
        // end
        // else if (wb_int_enq && !wb_mult_enq) begin
        //     wb_int_deq = '1;
        //     wb_mult_deq = '0;
        // end
        // else if (wb_mult_enq && !wb_int_enq) begin
        //     wb_int_deq = '0;
        //     wb_mult_deq = '1;
        // end
        

        // if (wb_int_out.valid && !wb_mult_out.valid) begin
        //     wb_inst_out = wb_int_out;
        //     //wb_int_deq = '1;

        // end else if (!wb_int_out.valid && wb_mult_out.valid) begin
        //     wb_inst_out = wb_mult_out;
        //     //wb_mult_deq = '1;

        // end 
        // // else if (wb_int_out.valid && wb_mult_out.valid) begin
        // //     if (wb_int_out.rob_idx > wb_mult_out.rob_idx) begin
        // //         wb_inst_out = wb_int_out;
        // //         //wb_int_deq = '1;

        // //     end else begin
        // //         wb_inst_out = wb_mult_out;
        // //         //wb_mult_deq = '1;
        // //     end
        // else begin
        //     wb_inst_out = '0;
       // end
    end

    // pre_wb_q #(
    //     .DEPTH      (8)
    // ) combine_wb_q (
    //     .clk(clk),
    //     .rst(rst),
    //     .enq(wb_int_enq),
    //     .ready_deq(wb_int_deq),
    //     .inst_in_wb(int_to_wb),
    //     .inst_out_wb(wb_int_out),
    //     .valid_rdata(int_valid_rdata),
    //     .wb_stall(int_wb_stall)
    // );


    writeback wb_int (
        .inst_in_wb(wb_inst_out[0]), // in
        .prf_regf_we(prf_we[0]), // out
        .ld_status(ld_status[0]), // out
        .status_out(status_n[0]), // out
        .rob_idx_ld(rob_idx_ld[0]), // out
        .p_addr_out(p_addr_out_wb[0]), // out
        .data_out(wb_data_out[0]), // out
        .rfvi_monitor_vals(rfvi_monitor_vals[0]) // out
        //.deq(wb_deq)
    );

    writeback wb_mult (
        .inst_in_wb(wb_inst_out[1]), // d
        .prf_regf_we(prf_we[1]), // d
        .ld_status(ld_status[1]), // d
        .status_out(status_n[1]), // d
        .rob_idx_ld(rob_idx_ld[1]), // d
        .p_addr_out(p_addr_out_wb[1]),
        .data_out(wb_data_out[1]),
        .rfvi_monitor_vals(rfvi_monitor_vals[1])
        //.deq(wb_deq)
    );


    free_list #(
        .DEPTH      (128)
    ) free_list(
        .clk(clk),
        .rst(rst),
        .enq(fl_enq),
        .deq(fl_deq),
        .p_addr_in(fl_data_in), // rob_out.rd_paddr
        .p_addr_out(p_addr_out),
        .valid_rdata(fl_valid_rdata),
        .rename_stall(fl_stall)
    );

    robert #(
        .DEPTH      (16)
    ) robert(
        .clk(clk),
        .rst(rst),
        .enq(rob_enq),
        .ld_status_0(ld_status[0]),
        .ld_status_1(ld_status[1]),
        .status_in_0(status_n[0]), // '0
        .status_in_1(status_n[1]),
        .ld_branch_res('0),
        .rob_idx_ld_0(rob_idx_ld[0]),
        .rob_idx_ld_1(rob_idx_ld[1]),
        .rfvi_monitor_vals_0(rfvi_monitor_vals[0]),
        .rfvi_monitor_vals_1(rfvi_monitor_vals[1]),
        .branch_res_in(not_taken), // '0
        .rob_in(rob_entry),
        .rob_idx_in('0),
        .rob_out(rob_out),
        .valid_rdata(rob_valid_rdata),
        .alloc_stall(rob_stall),
        .decode_stall(decode_stall),
        .deq(fl_enq_rob),
        .rob_tail_idx(rob_tail_idx),
        .rob_overflow(rob_overflow),
        .aregf_we(aregf_we),
        .ard_s(ard_s),
        .p_addr_ret(p_addr_ret)
    );
    
    always_comb begin

        // queued a read in rename allocate
        // rs1, rs2

        // check both arf and prf -> which one
        if (ra_dp_inst_out.use_prs1 && prs1_v.valid) begin // using phys address and already there
            rs1_rdata = prs1_v.value;
            rs1_ready = '1;
        end
        else if (ra_dp_inst_out.use_prs1 && !prs1_v.valid) begin // using phys address and not there
            rs1_rdata = '0;
            rs1_ready = '0;
        end
        // changes nothing!
        // else if (ra_dp_inst_out.use_prs1 && !prs1_v.valid && (p_addr_out_wb == ra_dp_inst_out.rs1_paddr) ) begin // using phys address and not there
        //     rs1_rdata = wb_data_out;
        //     rs1_ready = '1;
        // end
        else if (!ra_dp_inst_out.use_prs1 && ra_dp_inst_out.use_rs1) begin // ROB? JUST TAKE ARCH
            rs1_rdata = ars1_v.value;
            rs1_ready = '1;
        end
        else begin // WHAT IS THIS
            rs1_rdata = '0;
            rs1_ready = '0;
        end

        if (ra_dp_inst_out.use_prs2 && prs2_v.valid) begin // using phys address and already there
            rs2_rdata = prs2_v.value;
            rs2_ready = '1;
        end
        else if (ra_dp_inst_out.use_prs2 && !prs2_v.valid) begin // using phys address and not there
            rs2_rdata = '0;
            rs2_ready = '0;
        end
        // else if (ra_dp_inst_out.use_prs2 && !prs2_v.valid && (p_addr_out_wb == ra_dp_inst_out.rs2_paddr) ) begin // using phys address and not there
        //     rs2_rdata = wb_data_out;
        //     rs2_ready = '1;
        // end
        else if (!ra_dp_inst_out.use_prs2 && ra_dp_inst_out.use_rs2) begin // ROB? JUST TAKE ARCH
            rs2_rdata = ars2_v.value;
            rs2_ready = '1;
        end
        else begin // WHAT IS THIS
            rs2_rdata = '0;
            rs2_ready = '0;
        end

    end

    arbiter arbiter(
        .clk(clk), // input
        .rst(rst), // input

        .bmem_raddr(bmem_raddr), // input
        .bmem_rdata(bmem_rdata), // input
        .bmem_rvalid(bmem_rvalid), // input
        .cache_read(dfp_read), // input

        .a_raddr(a_raddr), // does cache need?
        .a_rdata(dfp_rdata), // to cache
        .a_resp(dfp_resp), // to cache (resp)
        .bmem_read(bmem_read),

        .cache_addr(dfp_addr), // input
        .cache_wdata(dfp_wdata), // input
        .cache_write(dfp_write), // input

        .bmem_addr(bmem_addr),
        .bmem_wdata(bmem_wdata),
        .bmem_write(bmem_write),

        .bmem_ready(bmem_ready) // input
    );

    cache_mod icache(
        .clk(clk), // input
        .rst(rst), // input

        .ufp_addr(ufp_addr), // input
        .ufp_rmask(ufp_rmask), // input
        .ufp_wmask(ufp_wmask), // input
        .ufp_rdata(ufp_rdata),
        .ufp_wdata(ufp_wdata), // input
        .ufp_resp(ufp_resp),

        // memory side signals, dfp -> downward facing port
        .dfp_addr(dfp_addr),
        .dfp_read(dfp_read),
        .dfp_write(dfp_write),
        .dfp_rdata(dfp_rdata), // input
        .dfp_wdata(dfp_wdata),
        .dfp_resp(dfp_resp) // input
    );

    logic           monitor_valid;
    logic   [63:0]  monitor_order;
    logic   [31:0]  monitor_inst;
    logic   [4:0]   monitor_rs1_addr;
    logic   [4:0]   monitor_rs2_addr;
    logic   [31:0]  monitor_rs1_rdata;
    logic   [31:0]  monitor_rs2_rdata;
    logic           monitor_regf_we;
    logic   [4:0]   monitor_rd_addr;
    logic   [31:0]  monitor_rd_wdata;
    logic   [31:0]  monitor_pc_rdata;
    logic   [31:0]  monitor_pc_wdata;
    logic   [31:0]  monitor_mem_addr;
    logic   [3:0]   monitor_mem_rmask;
    logic   [3:0]   monitor_mem_wmask;
    logic   [31:0]  monitor_mem_rdata;
    logic   [31:0]  monitor_mem_wdata;
    
    assign monitor_valid     = rob_out.rfvi_monitor_vals.monitor_valid;
    assign monitor_order     = rob_out.rfvi_monitor_vals.monitor_order;
    assign monitor_inst      = rob_out.rfvi_monitor_vals.monitor_inst;
    assign monitor_rs1_addr  = rob_out.rfvi_monitor_vals.monitor_rs1_addr;
    assign monitor_rs2_addr  = rob_out.rfvi_monitor_vals.monitor_rs2_addr;
    assign monitor_rs1_rdata = rob_out.rfvi_monitor_vals.monitor_rs1_rdata;
    assign monitor_rs2_rdata = rob_out.rfvi_monitor_vals.monitor_rs2_rdata;
    assign monitor_rd_addr   = rob_out.rfvi_monitor_vals.monitor_rd_addr;
    assign monitor_rd_wdata  = rob_out.rfvi_monitor_vals.monitor_rd_wdata;
    assign monitor_pc_rdata  = rob_out.rfvi_monitor_vals.monitor_pc_rdata;
    assign monitor_pc_wdata  = rob_out.rfvi_monitor_vals.monitor_pc_wdata;
    assign monitor_mem_addr  = '0;
    assign monitor_mem_rmask = '0;
    assign monitor_mem_wmask = '0;
    assign monitor_mem_rdata = '0;
    assign monitor_mem_wdata = '0;
    

endmodule : cpu