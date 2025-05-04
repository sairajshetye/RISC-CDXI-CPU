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

    logic iq_enq, dq_enq, rq_enq, fl_enq, rob_enq, wb_int_enq, wb_mult_enq, fl_enq_rob, decode_stall, lds_stall, lds_enq, lds_deq;
    logic iq_deq, dq_deq, rq_deq, fl_deq; 
    logic really_full_int, really_full_mult, really_full_br, really_full_mem;

    if_id_stage_reg_t if_id_reg_next, if_id_inst_out;
    id_ex_stage_reg_t id_ex_reg_next, id_ex_inst_out;
    ra_dp_stage_reg_t ra_dp_reg_next, ra_dp_inst_out;
    dp_is_stage_reg_t dp_is_inst_out, dp_is_out_mult, dp_is_out_int, dp_is_out_br, dp_is_out_mem, dp_lds_inst_out, inst_out_lds;
    dp_is_stage_reg_t int_to_wb, mult_to_wb, wb_reg_next, wb_int_out, wb_mult_out, wb_mem_out;
    dp_lds_stage_reg_t inst_out_lds_q;


    // WRITE BACKS
    dp_is_stage_reg_t   wb_inst_out         [4];
    logic               prf_we              [4]; 
    logic               ld_status           [4];
    status_t            status_n            [4];
    logic   [ROB_PTR_SIZE-1:0]       rob_idx_ld          [4];
    logic   [GLOBAL_PTR_SIZE-1:0]       p_addr_out_wb       [4];
    logic   [31:0]      wb_data_out         [4];
    rfvi_packet_t       rfvi_monitor_vals   [4];

    rob_entry_t rob_entry, rob_out;

    logic [255:0] cache_rdata;

    logic [31:0] cache_rdata_32;

    logic [255:0] lb_rdata;

    logic iq_valid_rdata, dq_valid_rdata, rq_valid_rdata, fl_valid_rdata, rob_valid_rdata, int_valid_rdata, mult_valid_rdata, valid_rdata_lds;
    logic iq_stall, dq_stall, rq_stall, fl_stall, rob_stall, int_wb_stall, mult_wb_stall, br_wb_stall, mem_wb_stall;
    logic iq_stall_next, dq_stall_next, rq_stall_next;

    //logic [31:0] rs1_v, rs2_v;
    logic [4:0] rs1_s, rs2_s;
    logic [GLOBAL_PTR_SIZE-1:0] prs1_s, prs2_s;

    logic [GLOBAL_PTR_SIZE-1:0] fl_data_in, p_addr_out; // free list

    logic [ROB_PTR_SIZE-1:0] rob_tail_idx, rob_head_idx;
    logic [GLOBAL_PTR_SIZE-1:0] rs1_paddr, rs2_paddr;

    logic [4:0] rat_rs1, rat_rs2;

    arf_reg_t ars1_v, ars2_v, ars1_v_comb, ars2_v_comb;
    prf_t     prs1_v, prs2_v, prs1_v_comb, prs2_v_comb;

    logic       rs1_renamed, rs2_renamed;
    logic       rename_we;
    logic       rs1_ready, rs2_ready;
    
    logic           rob_overflow;
   


    //logic big_valid;


    // cache port variables

    logic   [31:0]      ufp_addr    [2];
    logic   [3:0]       ufp_rmask   [2];
    logic   [3:0]       ufp_wmask   [2];
    logic   [255:0]     ufp_rdata_inst;
    logic   [31:0]      ufp_rdata_data;
    logic   [31:0]      ufp_wdata   [2];
    logic               ufp_resp    [2];

    logic   [31:0]      dfp_addr    [2];
    logic               dfp_read    [2];
    logic               dfp_write   [2];
    //logic   [255:0]     dfp_rdata   [2];
    logic   [255:0]     dfp_wdata   [2];
    //logic               dfp_resp    [2];


    logic   [31:0]  dfp_addr_com    [2];
    logic           dfp_read_com    [2];
    logic           dfp_write_com   [2];
    logic   [255:0] dfp_wdata_com   [2];
    logic   [255:0] dfp_rdata_com   [2];
    logic           dfp_resp_com    [2];

    logic   [31:0]  dfp_addr_arb;
    logic           dfp_read_arb;
    logic           dfp_write_arb;
    logic   [255:0] dfp_wdata_arb;
    
    logic           dfp_resp_arb;
    logic   [255:0] dfp_rdata_arb;
    
    
    // other arbiter variables

    logic [31:0] a_raddr;

    logic           aregf_we;
    logic [4:0]     ard_s;
    logic [GLOBAL_PTR_SIZE-1:0]     p_addr_ret;
    
    //logic [6:0]     commit_rs;
    prf_t           commit_prs;

    logic [31:0]    dmem_rdata_extended;

    

    // always_ff @ (posedge clk) begin
    //     if (rst) begin
    //         big_valid <= '0;
    //     end
    //     else if ()

    // end

    logic dispatch_stall_mult, dispatch_stall_int, dispatch_stall_br;

    logic load_station_mult, load_station_int, load_station_br, load_station_mem;
    logic funct_mult_busy, funct_int_busy, funct_br_busy, funct_mem_busy;
    logic funct_mult_done;

    logic [31:0] rs1_rdata, rs2_rdata;

    logic valid_output_mult, valid_output_int, valid_output_br, valid_output_mem;

    logic valid_rdata_mult, valid_rdata_int, valid_rdata_br, valid_rdata_mem;
    logic dones, done_stall;

    logic flush;

    branch_t branch_res_out;
    logic ld_branch_res;
    logic [31:0] br_pc_next;
    // logic [63:0] order_out_wb;
    logic [63:0] order_reg;


    logic   [GLOBAL_PTR_SIZE:0]    head_out;

    assign ufp_wdata[0] = '0;
    assign ufp_wmask[0] = '0;

    assign rs1_s = ra_dp_inst_out.rs1_s;
    assign rs2_s = ra_dp_inst_out.rs2_s;
    assign prs1_s = ra_dp_inst_out.rs1_paddr;
    assign prs2_s = ra_dp_inst_out.rs2_paddr;

    //assign wb_int_enq = int_to_wb.valid && !funct_int_busy;
    //assign wb_mult_enq = mult_to_wb.valid && funct_mult_done;
    

    always_comb begin
        if (|ufp_rmask[0] && ufp_resp[0]) begin
            cache_rdata = ufp_rdata_inst;
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
        end else if (flush) begin
            pc_next = rob_out.pc_next;
        end else if (!iq_stall && !if_id_reg_next.fetch_stall) begin // && !if_id_reg_next.fetch_stall
            pc_next = pc + 4;
        end else begin
            pc_next = pc;
        end
    end

    always_ff @(posedge clk) begin  //commit order
        
        if (rst) begin
            order_reg <= '0;
            
        //end else if (flush) begin
            //order_reg <= order_br + 1'b1;
        end else if (rob_valid_rdata) begin
            order_reg <= order_reg + 1;
        end 
    end


    always_ff @(posedge clk) begin
        if (rst) begin
            done_stall <= '0;
        end else begin
            done_stall <= dones;
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
        .flush(flush),
        .order_br(order_reg),

        // .dq_stall(dq_stall),
        .enq(iq_enq),
        // .deq(iq_deq),
        .imem_addr(ufp_addr[0]),
        .imem_rmask(ufp_rmask[0]),
        .imem_rdata(cache_rdata_32),
        .imem_resp(ufp_resp[0]),
        .pc(pc),
        .pc_next(pc_next),
        .if_id(if_id_reg_next),
        .done(dones)
    );

    inst_q #(
        .DEPTH      (Q_DEPTH)
    ) inst_q(
        .clk(clk),
        .rst(rst || flush),
        .enq(iq_enq),
        .deq(!dq_stall && !dq_stall_next),
        .inst_in(if_id_reg_next),
        .inst_out(if_id_inst_out),
        .valid_rdata(iq_valid_rdata),
        .iq_stall(iq_stall),
        .iq_stall_next(iq_stall_next)
    );

    id_stage id_stage_1 (
        .if_id(if_id_inst_out),
        //.rs1_v(rs1_v),
        //.rs2_v(rs2_v),
        // .rq_stall(rq_stall),
        .dq_stall(dq_stall),
        .enq(dq_enq),
        // .deq(dq_deq),
        // .rs1_s(rs1_s),
        // .rs2_s(rs2_s),
        .id_ex(id_ex_reg_next)
    );

    decode_q #(
        .DEPTH      (Q_DEPTH)
    ) decode_q(
        .clk(clk),
        .rst(rst || flush),
        .enq(dq_enq),
        // .deq(dq_deq && !(decode_stall | rob_stall)),
        .deq(!rq_stall && !rob_stall && !decode_stall && !rq_stall_next && !lds_stall && !fl_stall),
        .inst_in_d(id_ex_reg_next),
        .inst_out_d(id_ex_inst_out),
        .valid_rdata(dq_valid_rdata),
        .dq_stall(dq_stall),
        .dq_stall_next(dq_stall_next)
    );

    rename_alloc #(
        .PTR_SIZE     (GLOBAL_PTR_SIZE),
        .ROB_PTR_SIZE (ROB_PTR_SIZE)
    ) rename_alloc_1(
        .id_ex(id_ex_inst_out), // comes from decode queue
        // inputs from RAT, FL, stalls?
        .p_addr(p_addr_out), // FL
        .rob_idx(rob_tail_idx),
        .rob_overflow(rob_overflow),
        .fl_head(head_out),
        
        // from RAT
        .rs1_renamed(rs1_renamed), 
        .rs2_renamed(rs2_renamed),
        .rs1_paddr(rs1_paddr), 
        .rs2_paddr(rs2_paddr),
        // .res_stall(dispatch_stall_mult || dispatch_stall_int),
        // .rob_stall(rob_stall),
        .rq_stall(rq_stall),
        // output to ROB + dispatch, RAT
        .enq(rq_enq),
        // .deq(rq_deq),
        .rename_we(rename_we),
        .fl_deq(fl_deq),
        .rob_enq(rob_enq),
        // to RAT
        .rat_rs1(rat_rs1),
        .rat_rs2(rat_rs2),
        .rob_entry(rob_entry),
        .ra_dp(ra_dp_reg_next)
    );

    rename_q #(
        .DEPTH      (Q_DEPTH)
    ) rename_q(
        .clk(clk),
        .rst(rst || flush),
        .enq(rq_enq),
        // .deq(rq_deq),
        .deq(!dispatch_stall_mult && !dispatch_stall_int && !really_full_mult && !really_full_int && !really_full_br && !really_full_mem && !lds_stall), // && !really_full_mult && !really_full_int
        .inst_in_r(ra_dp_reg_next),
        .inst_out_r(ra_dp_inst_out),
        .valid_rdata(rq_valid_rdata),
        .rq_stall(rq_stall),
        .rq_stall_next(rq_stall_next)
    );


    dispatch #(
        .PTR_SIZE      (GLOBAL_PTR_SIZE)
    ) dispatch(
        .ra_dp(ra_dp_inst_out), // comes from rename queue, input

        .dispatch_stall_mult('0), // input
        .dispatch_stall_int('0), // input
        .dispatch_stall_br('0), // input
        //.dispatch_stall_mem('0), // input

        .load_station_mult(load_station_mult), // output
        .load_station_int(load_station_int), // output
        .load_station_br(load_station_br),
        .load_station_mem(load_station_mem),//output

        .rs1_rdata(rs1_rdata), // input from the register file arbiter
        .rs2_rdata(rs2_rdata), // input from the register file arbiter
        .rs1_ready(rs1_ready),
        .rs2_ready(rs2_ready),

        .data_paddr_0(p_addr_out_wb[0]),
        .data_paddr_1(p_addr_out_wb[1]),
        .data_paddr_2(p_addr_out_wb[2]), // input
        .data_paddr_3(p_addr_out_wb[3]),
        .data_in_0(wb_data_out[0]),
        .data_in_1(wb_data_out[1]),
        .data_in_2(wb_data_out[2]), // input
        .data_in_3(wb_data_out[3]),

        .dp_is(dp_is_inst_out), // output
        .valid_output_mult(valid_output_mult), // output
        .valid_output_int(valid_output_int), // output
        .valid_output_br(valid_output_br)

    );

    r_station_shift  #(
        .DEPTH      (R_STATION_MULT_DEPTH),
        .PTR_SIZE   (GLOBAL_PTR_SIZE)
    ) station_mult(
        .clk(clk), // input
        .rst(rst || flush), // input
        .funct_unit_busy(funct_mult_busy), // input
        .load_station(load_station_mult),
        .inst_in(dp_is_inst_out), // input
        .inst_out(dp_is_out_mult), // output
        .valid_rdata(valid_rdata_mult), // output
        .dispatch_stall(dispatch_stall_mult), // output
        .really_full(really_full_mult),
        .data_paddr_0(p_addr_out_wb[0]), // input
        .data_paddr_1(p_addr_out_wb[1]), // input
        .data_paddr_2(p_addr_out_wb[2]), // input
        .data_paddr_3(p_addr_out_wb[3]),
        .data_in_0(wb_data_out[0]), // input
        .data_in_1(wb_data_out[1]), // input
        .data_in_2(wb_data_out[2]), // input
        .data_in_3(wb_data_out[3])
    );

    r_station_shift  #(
        .DEPTH      (R_STATION_INT_DEPTH),
        .PTR_SIZE   (GLOBAL_PTR_SIZE)
    ) station_int(
        .clk(clk), // input
        .rst(rst || flush), // input
        .funct_unit_busy(funct_int_busy), // input
        .load_station(load_station_int),
        .inst_in(dp_is_inst_out), // input
        .inst_out(dp_is_out_int), // output
        .valid_rdata(valid_rdata_int), // output
        .dispatch_stall(dispatch_stall_int), // output
        .really_full(really_full_int),
        .data_paddr_0(p_addr_out_wb[0]), // input
        .data_paddr_1(p_addr_out_wb[1]), // input
        .data_paddr_2(p_addr_out_wb[2]), // input
        .data_paddr_3(p_addr_out_wb[3]),
        .data_in_0(wb_data_out[0]), // input
        .data_in_1(wb_data_out[1]), // input
        .data_in_2(wb_data_out[2]), // input
        .data_in_3(wb_data_out[3])
    );

    r_station_shift  #(
        .DEPTH      (R_STATION_BR_DEPTH),
        .PTR_SIZE   (GLOBAL_PTR_SIZE)
    ) station_br(
        .clk(clk), // input
        .rst(rst || flush), // input
        .funct_unit_busy(funct_br_busy), // input
        .load_station(load_station_br),
        .inst_in(dp_is_inst_out), // input
        .inst_out(dp_is_out_br), // output
        .valid_rdata(valid_rdata_br), // output
        .dispatch_stall(dispatch_stall_br), // output
        .really_full(really_full_br),
        .data_paddr_0(p_addr_out_wb[0]), // input
        .data_paddr_1(p_addr_out_wb[1]), // input
        .data_paddr_2(p_addr_out_wb[2]), // input
        .data_paddr_3(p_addr_out_wb[3]), // input
        .data_in_0(wb_data_out[0]), // input
        .data_in_1(wb_data_out[1]), // input
        .data_in_2(wb_data_out[2]), // input
        .data_in_3(wb_data_out[3]) // input
    );

    // load_store_unit ld_s_unit(
    //     .id_ex(dp_is_inst_out),
    //     //.funct_unit_busy(),
    //     .ex_mem(inst_out_lds)

    // );


    lds_q #(
        .DEPTH      (R_STATION_LDS_Q_DEPTH),
        .PTR_SIZE   (GLOBAL_PTR_SIZE)
    ) ld_store_q(
        .clk(clk),
        .rst(rst || flush),
        .enq(load_station_mem),
        .ready_deq(lds_deq),
        .inst_in_lds(dp_is_inst_out),
        .inst_out_lds(inst_out_lds),
        .valid_rdata(valid_rdata_lds),
        .lds_stall(lds_stall),
        .really_full(really_full_mem),

        .data_paddr_0(p_addr_out_wb[0]), // input
        .data_paddr_1(p_addr_out_wb[1]), // input
        .data_paddr_2(p_addr_out_wb[2]), // input
        .data_paddr_3(p_addr_out_wb[3]), // input
        .data_in_0(wb_data_out[0]), // input
        .data_in_1(wb_data_out[1]), // input
        .data_in_2(wb_data_out[2]), // input
        .data_in_3(wb_data_out[3]) // input
    );

    load_store_unit ld_s_unit(
        .id_ex(inst_out_lds),
        //.funct_unit_busy(),
        .ex_mem(inst_out_lds_q)

    );

    always_comb 
    begin
        unique case (inst_out_lds_q.funct3)
            load_f3_lb : dmem_rdata_extended = {{24{ufp_rdata_data[7 +8 *inst_out_lds_q.dmem_addr_saved[1:0]]}}, ufp_rdata_data[8 *inst_out_lds_q.dmem_addr_saved[1:0] +: 8 ]};
            load_f3_lbu: dmem_rdata_extended = {{24{1'b0}}                          , ufp_rdata_data[8 *inst_out_lds_q.dmem_addr_saved[1:0] +: 8 ]};
            load_f3_lh : dmem_rdata_extended = {{16{ufp_rdata_data[15+16*inst_out_lds_q.dmem_addr_saved[1]  ]}}, ufp_rdata_data[16*inst_out_lds_q.dmem_addr_saved[1]   +: 16]};
            load_f3_lhu: dmem_rdata_extended = {{16{1'b0}}                          , ufp_rdata_data[16*inst_out_lds_q.dmem_addr_saved[1]   +: 16]};
            load_f3_lw : dmem_rdata_extended = ufp_rdata_data;
            default    : dmem_rdata_extended = '0;
        endcase
    end


    always_comb begin
        lds_deq = '0;
        if (ufp_resp[1] && inst_out_lds_q.valid) begin
            //wb_inst_out[3] = inst_out_lds;
            wb_inst_out[3] = '0;
            prf_we[3] = inst_out_lds_q.regf_we;
            ld_status[3] = '1;
            status_n[3] = done;
            rob_idx_ld[3] = inst_out_lds_q.rob_idx;
            p_addr_out_wb[3] = inst_out_lds_q.rd_paddr;
            rfvi_monitor_vals[3] = inst_out_lds_q.rfvi_monitor_vals;
            lds_deq = '1;
            rfvi_monitor_vals[3].monitor_rd_wdata = dmem_rdata_extended; 
            rfvi_monitor_vals[3].monitor_mem_rdata = ufp_rdata_data;
            //rfvi_monitor_vals[3].monitor_rs2_rdata = inst_out_lds_q.rs2_data;
           // rfvi_monitor_vals[3].monitor_mem_wdata = inst_out_lds_q.dmem_wdata;
            wb_data_out[3] = dmem_rdata_extended;    //????
            ufp_addr[1] = '0;
            ufp_rmask[1] = '0;
            ufp_wmask[1] = '0;
            ufp_wdata[1] = '0;
            
        end else begin
            wb_inst_out[3] = '0;
            prf_we[3] = '0;
            ld_status[3] = '0;
            status_n[3] = waiting;
            rob_idx_ld[3] = '0;
            p_addr_out_wb[3] = '0;
            wb_data_out[3] = '0;
            rfvi_monitor_vals[3] = '0;

        
        if (rob_out.ld_store == '1 && !ufp_resp[1]) begin   //if rob commit is a ld store
            if (inst_out_lds_q.rob_idx == rob_head_idx) begin //if load or store at head of queue is the commit inst from the rob
                //trigger the memory
                ufp_addr[1] = inst_out_lds_q.dmem_addr;
                ufp_rmask[1] = inst_out_lds_q.dmem_rmask;
                ufp_wmask[1] = inst_out_lds_q.dmem_wmask;
                ufp_wdata[1] = inst_out_lds_q.dmem_wdata;
            end else begin
                ufp_addr[1] = '0;
                ufp_rmask[1] = '0;
                ufp_wmask[1] = '0;
                ufp_wdata[1] = '0;
            end
        end
        else begin
            ufp_addr[1] = '0;
            ufp_rmask[1] = '0;
            ufp_wmask[1] = '0;
            ufp_wdata[1] = '0;
        end

        //make this in ff to hold? idk
        
        end
    end

    // always_ff @(posedge clk) begin
    //     if (rst) begin
    //         lds_deq <= '0;
    //         ufp_addr[1] <= '0;
    //             ufp_rmask[1] <= '0;
    //             ufp_wmask[1] <= '0;
    //             ufp_wdata[1] <= '0;

    //             wb_inst_out[3] <= '0;
    //         prf_we[3] <= '0;
    //         ld_status[3] <= '0;
    //         status_n[3] <= waiting;
    //         rob_idx_ld[3] <= '0;
    //         p_addr_out_wb[3] <= '0;
    //         wb_data_out[3] <= '0;
    //         rfvi_monitor_vals[3] <= '0;
    //     end else begin

        

    //     if (rob_out.ld_store == '1) begin   //if rob commit is a ld store
    //         if (inst_out_lds_q.rob_idx == rob_head_idx) begin //if load or store at head of queue is the commit inst from the rob
    //             //trigger the memory
    //             ufp_addr[1] <= inst_out_lds_q.dmem_addr;
    //             ufp_rmask[1] <= inst_out_lds_q.dmem_rmask;
    //             ufp_wmask[1] <= inst_out_lds_q.dmem_wmask;
    //             ufp_wdata[1] <= inst_out_lds_q.dmem_wdata;
    //         end 
    //     end

    //     //make this in ff to hold? idk
    //     if (ufp_resp[1] && inst_out_lds_q.valid) begin
    //         //wb_inst_out[3] = inst_out_lds;
    //         wb_inst_out[3] <= '0;
    //         prf_we[3] <= inst_out_lds_q.regf_we;
    //         ld_status[3] <= '1;
    //         status_n[3] <= done;
    //         rob_idx_ld[3] <= inst_out_lds_q.rob_idx;
    //         p_addr_out_wb[3] <= inst_out_lds_q.rd_paddr;
    //         rfvi_monitor_vals[3] <= inst_out_lds_q.rfvi_monitor_vals;
    //         lds_deq <= '1;

    //         wb_data_out[3] <= ufp_rdata_data;    //????
    //         rfvi_monitor_vals[3].monitor_rd_wdata <= ufp_rdata_data; 
    //         rfvi_monitor_vals[3].monitor_mem_rdata <= ufp_rdata_data;

            

    //     end

    // end
    // end


    multiply_divide_unit funct_mult(
        .clk(clk),
        .rst(!rst ),    //add flush somehow
        .rs_out(dp_is_out_mult),
        //.pre_wb_mult_stall(mult_wb_stall),
        //.rs1_v(),
        //.rs2_v(),
        .funct_unit_busy(funct_mult_busy),
        .out_inst(wb_inst_out[1]),
        .funct_mult_done(funct_mult_done)
    );

    integer_unit funct_int(
        .id_ex(dp_is_out_int),
        //.pre_wb_int_stall(int_wb_stall),
        //.rs1_v(),
        //.rs2_v(),
        .funct_unit_busy(funct_int_busy),
        .ex_mem(wb_inst_out[0])
    );

    branch_unit funct_br (
        .id_ex(dp_is_out_br),
        //.rs1_v(),
        //.rs2_v(),
        .funct_unit_busy(funct_br_busy),
        .ex_mem(wb_inst_out[2])

    );

 /*    load_store_unit funct_mem (
        .id_ex(dp_is_out_mem),
        .pre_wb_int_stall(mem_wb_stall),
        //.rs1_v(),
        //.rs2_v(),
        .funct_unit_busy(funct_mem_busy),
        .ex_mem(wb_inst_out[3])

    ); */




    writeback #(
        .PTR_SIZE   (GLOBAL_PTR_SIZE),
        .ROB_PTR_SIZE (ROB_PTR_SIZE)
    ) wb_int(
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

    writeback #(
        .PTR_SIZE   (GLOBAL_PTR_SIZE),
        .ROB_PTR_SIZE (ROB_PTR_SIZE)
    ) wb_mult(
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

    br_writeback #(
        .PTR_SIZE   (GLOBAL_PTR_SIZE),
        .ROB_PTR_SIZE (ROB_PTR_SIZE)
    ) wb_br(
        .inst_in_wb(wb_inst_out[2]), // d
        .prf_regf_we(prf_we[2]), // d
        .ld_status(ld_status[2]), // d
        .status_out(status_n[2]), // d
        .rob_idx_ld(rob_idx_ld[2]), // d
        .ld_branch_res(ld_branch_res),
        .branch_res_out(branch_res_out),
        .p_addr_out(p_addr_out_wb[2]),
        .data_out(wb_data_out[2]),
        .rfvi_monitor_vals(rfvi_monitor_vals[2]),
        .br_pc_next(br_pc_next)
        //.order_out_wb(order_out_wb)
        //.deq(wb_deq)
    );

    /* writeback wb_mem (
        .inst_in_wb(wb_inst_out[3]), // d
        .prf_regf_we(prf_we[3]), // d
        .ld_status(ld_status[3]), // d
        .status_out(status_n[3]), // d
        .rob_idx_ld(rob_idx_ld[3]), // d
        .p_addr_out(p_addr_out_wb[3]),
        .data_out(wb_data_out[3]),
        .rfvi_monitor_vals(rfvi_monitor_vals[3])
        //.deq(wb_deq)
    ); */



     robert #(
        .DEPTH      (ROB_DEPTH),
        .PTR_SIZE   (GLOBAL_PTR_SIZE)
    ) robert(
        .clk(clk),
        .rst(rst || flush),
        .enq(rob_enq),
        //.lds_deq(lds_deq),
        .ld_status_0(ld_status[0]),
        .ld_status_1(ld_status[1]),
        .ld_status_2(ld_status[2]),
        .ld_status_3(ld_status[3]),
    
        .status_in_0(status_n[0]), // '0
        .status_in_1(status_n[1]),
        .status_in_2(status_n[2]),
        .status_in_3(status_n[3]),
        .ld_branch_res(branch_res_out),
        .rob_idx_ld_0(rob_idx_ld[0]),
        .rob_idx_ld_1(rob_idx_ld[1]),
        .rob_idx_ld_2(rob_idx_ld[2]),
        .rob_idx_ld_3(rob_idx_ld[3]),
        .rfvi_monitor_vals_0(rfvi_monitor_vals[0]),
        .rfvi_monitor_vals_1(rfvi_monitor_vals[1]),
        .rfvi_monitor_vals_2(rfvi_monitor_vals[2]),
        .rfvi_monitor_vals_3(rfvi_monitor_vals[3]),
        .branch_res_in(branch_res_out), 
        .br_pc_next(br_pc_next),
        //.order_out_wb(order_out_wb),
        .rob_in(rob_entry),
        .rob_idx_in(rob_idx_ld[2]),
        .rob_out(rob_out),
        .valid_rdata(rob_valid_rdata),  //use to ld comnmit order
        .alloc_stall(rob_stall),
        .decode_stall(decode_stall),
        .deq(fl_enq_rob),
        .rob_tail_idx(rob_tail_idx),
        .rob_head_idx(rob_head_idx),
        .rob_overflow(rob_overflow),
        .aregf_we(aregf_we),
        .ard_s(ard_s),
        .p_addr_ret(p_addr_ret),
        .flush(flush)   //output
    );


    free_list #(
        .DEPTH      (FREE_LIST_PRF_DEPTH),
        .PTR_SIZE   (GLOBAL_PTR_SIZE)
    ) free_list(
        .clk(clk),
        .rst(rst),
        .enq(fl_enq),
        .deq(fl_deq), //!rq_stall && !rob_stall
        .flush(flush),
        .fl_head(rob_out.fl_head),
        .p_addr_in(fl_data_in), // rob_out.rd_paddr
        .p_addr_out(p_addr_out),
        .valid_rdata(fl_valid_rdata),
        .fl_stall(fl_stall),
        .head_out(head_out)
    );

    rat_arf2 #(
        .PTR_SIZE   (GLOBAL_PTR_SIZE)
    ) rat_arf_1(
        .clk(clk),
        .rst(rst),
        .flush(flush),
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
        //.ars1_v(ars1_v), 
        //.ars2_v(ars2_v),
        .ars1_v_comb(ars1_v_comb), 
        .ars2_v_comb(ars2_v_comb)

    );

    prf #(
        .DEPTH      (FREE_LIST_PRF_DEPTH)
    ) prf(
        .clk(clk),
        .rst(rst),
        .flush(flush),
        .regf_we_0(prf_we[0]),
        .regf_we_1(prf_we[1]),
        .regf_we_2(prf_we[2]),
        .regf_we_3(prf_we[3]),
        .rd_v_0(wb_data_out[0]),
        .rd_v_1(wb_data_out[1]),
        .rd_v_2(wb_data_out[2]),
        .rd_v_3(wb_data_out[3]),
        .aregf_we(aregf_we),
        .rs1_s(prs1_s), 
        .rs2_s(prs2_s), 
        .rd_s_0(p_addr_out_wb[0]),
        .rd_s_1(p_addr_out_wb[1]),
        .rd_s_2(p_addr_out_wb[2]),
        .rd_s_3(p_addr_out_wb[3]),
        .commit_rs(p_addr_ret),
        .prs1_v(prs1_v), 
        .prs2_v(prs2_v),
        .prs1_v_comb(prs1_v_comb),
        .prs2_v_comb(prs2_v_comb),
        .free_we(fl_enq),
        .rd_s_free(fl_data_in),
        .commit_prs(commit_prs)
    );
    
    always_comb begin

        // queued a read in rename allocate
        // rs1, rs2

        // check both arf and prf -> which one
        if (ra_dp_inst_out.use_prs1 && prs1_v_comb.valid ) begin // using phys address and already there
            rs1_rdata = prs1_v_comb.value;
            rs1_ready = '1;
        end
        else if (ra_dp_inst_out.use_prs1 && !prs1_v_comb.valid) begin // using phys address and not there
            rs1_rdata = '0;
            rs1_ready = '0;
        end
        // changes nothing!
        // else if (ra_dp_inst_out.use_prs1 && !prs1_v.valid && (p_addr_out_wb == ra_dp_inst_out.rs1_paddr) ) begin // using phys address and not there
        //     rs1_rdata = wb_data_out;
        //     rs1_ready = '1;
        // end
        else if (!ra_dp_inst_out.use_prs1 && ra_dp_inst_out.use_rs1) begin // ROB? JUST TAKE ARCH
            rs1_rdata = ars1_v_comb.value;
            rs1_ready = '1;
        end
        else begin // WHAT IS THIS
            rs1_rdata = '0;
            rs1_ready = '0;
        end

        if (ra_dp_inst_out.use_prs2 && prs2_v_comb.valid ) begin // using phys address and already there
            rs2_rdata = prs2_v_comb.value;
            rs2_ready = '1;
        end
        else if (ra_dp_inst_out.use_prs2 && !prs2_v_comb.valid) begin // using phys address and not there
            rs2_rdata = '0;
            rs2_ready = '0;
        end
        // else if (ra_dp_inst_out.use_prs2 && !prs2_v.valid && (p_addr_out_wb == ra_dp_inst_out.rs2_paddr) ) begin // using phys address and not there
        //     rs2_rdata = wb_data_out;
        //     rs2_ready = '1;
        // end
        else if (!ra_dp_inst_out.use_prs2 && ra_dp_inst_out.use_rs2) begin // ROB? JUST TAKE ARCH
            rs2_rdata = ars2_v_comb.value;
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
        .flush(flush),
        .bmem_raddr(bmem_raddr), // input
        .bmem_rdata(bmem_rdata), // input
        .bmem_rvalid(bmem_rvalid), // input
        .cache_read(dfp_read_arb), // input

        .a_raddr(a_raddr), // does cache need?
        .a_rdata(dfp_rdata_arb), // to cache
        .a_resp(dfp_resp_arb), // to cache (resp)
        .bmem_read(bmem_read),

        .cache_addr(dfp_addr_arb), // input
        .cache_wdata(dfp_wdata_arb), // input
        .cache_write(dfp_write_arb), // input

        .bmem_addr(bmem_addr),
        .bmem_wdata(bmem_wdata),
        .bmem_write(bmem_write),

        .bmem_ready(bmem_ready) // input
    );

    /*
        logic   [31:0]  dfp_addr_com    [2];
        logic           dfp_read_com    [2];
        logic           dfp_write_com   [2];
        logic   [255:0] dfp_wdata_com   [2];
        logic   [255:0] dfp_rdata_com   [2];
        logic           dfp_resp_com    [2];
    */
    assign dfp_addr_com[0] = dfp_addr[0];
    assign dfp_read_com[0] = dfp_read[0];
    assign dfp_write_com[0] = dfp_write[0];
    assign dfp_wdata_com[0] = dfp_wdata[0];

    assign dfp_addr_com[1] = dfp_addr[1];
    assign dfp_read_com[1] = dfp_read[1];
    assign dfp_write_com[1] = dfp_write[1];
    assign dfp_wdata_com[1] = dfp_wdata[1];


    arbiter2 arbiter2(
        .clk(clk),
        .rst(rst || flush),
        .dfp_addr(dfp_addr_com),
        .dfp_read(dfp_read_com),
        .dfp_write(dfp_write_com),
        .dfp_wdata(dfp_wdata_com),
        .dfp_addr_arb(dfp_addr_arb), // out
        .dfp_read_arb(dfp_read_arb), // out
        .dfp_write_arb(dfp_write_arb), // out
        .dfp_wdata_arb(dfp_wdata_arb), // out
        .dfp_resp_arb(dfp_resp_arb),
        .dfp_rdata_arb(dfp_rdata_arb),
        .dfp_rdata_cache(dfp_rdata_com), // out
        .dfp_resp_cache(dfp_resp_com) // out
    );

    cache_mod icache(
        .clk(clk), // input
        .rst(rst), // input
        .flush(flush),
        .ufp_addr(ufp_addr[0]), // input
        .ufp_rmask(ufp_rmask[0]), // input
        .ufp_wmask(ufp_wmask[0]), // input
        .ufp_rdata(ufp_rdata_inst),
        .ufp_wdata(ufp_wdata[0]), // input
        .ufp_resp(ufp_resp[0]),

        // memory side signals, dfp -> downward facing port
        .dfp_addr(dfp_addr[0]),
        .dfp_read(dfp_read[0]),
        .dfp_write(dfp_write[0]),
        .dfp_rdata(dfp_rdata_com[0]), // input
        .dfp_wdata(dfp_wdata[0]),
        .dfp_resp(dfp_resp_com[0]) // input
    );

    // tie to 0 
    // always_comb begin
    //     ufp_addr[1] = '0;
    //     ufp_rmask[1] = '0;
    //     ufp_wmask[1] = '0;
    //     ufp_wdata[1] = '0;
    // end

    cache dcache(
        .clk(clk), // input
        .rst(rst), // input

        .ufp_addr(ufp_addr[1]), // input
        .ufp_rmask(ufp_rmask[1]), // input
        .ufp_wmask(ufp_wmask[1]), // input
        .ufp_rdata(ufp_rdata_data),
        .ufp_wdata(ufp_wdata[1]), // input
        .ufp_resp(ufp_resp[1]),

        // memory side signals, dfp -> downward facing port
        .dfp_addr(dfp_addr[1]),
        .dfp_read(dfp_read[1]),
        .dfp_write(dfp_write[1]),
        .dfp_rdata(dfp_rdata_com[1]), // input
        .dfp_wdata(dfp_wdata[1]),
        .dfp_resp(dfp_resp_com[1]) // input
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
    assign monitor_mem_addr  = rob_out.rfvi_monitor_vals.monitor_mem_addr;
    assign monitor_mem_rmask = rob_out.rfvi_monitor_vals.monitor_mem_rmask;
    assign monitor_mem_wmask = rob_out.rfvi_monitor_vals.monitor_mem_wmask;
    assign monitor_mem_rdata = rob_out.rfvi_monitor_vals.monitor_mem_rdata;
    assign monitor_mem_wdata = rob_out.rfvi_monitor_vals.monitor_mem_wdata;
    

endmodule : cpu