module load_store_unit
import rv32i_types::*;
(
    input dp_is_stage_reg_t id_ex,
    //input logic [31:0] rs1_v,
    //input logic [31:0] rs2_v,
    //input logic [31:0] ex_mem_rd_v,
    //input logic [31:0] mem_wb_rd_v,
    //output logic funct_unit_busy,
    output dp_lds_stage_reg_t ex_mem
    //input mem_wb_stage_reg_t mem_wb, wb
);
    

    logic   [31:0]  a;
    logic   [31:0]  b;

    logic   [2:0]   aluop;
    logic   [2:0]   cmpop;

    logic   [31:0]  aluout;
    logic   [31:0]  pc_next;
    logic           br_en;

    logic   [4:0]   rs2_s_real;
    logic   [4:0]   rd_s_real;

    
    logic   [31:0]  rd_v, rs1_temp, rs2_temp;
    logic           regf_we;
    logic           use_rs1, use_rs2;

    logic   [31:0]  dmem_addr;
    logic   [31:0]  dmem_addr_saved;
    logic   [3:0]   dmem_rmask;
    logic   [3:0]   dmem_wmask;
    logic   [31:0]  dmem_wdata;
    logic           dreq;
    logic           dreq_load;
    logic           branch_taken;

    logic signed   [31:0] as;
    logic signed   [31:0] bs;
    logic unsigned [31:0] au;
    logic unsigned [31:0] bu;
    logic [31:0] rs1_v, rs2_v;

    assign as =   signed'(a);
    assign bs =   signed'(b);
    assign au = unsigned'(a);
    assign bu = unsigned'(b);
    assign rs1_v = id_ex.rs1_data;
    assign rs2_v = id_ex.rs2_data;

    always_comb begin
        unique case (aluop)
            alu_op_add: aluout = au +   bu;
            alu_op_sll: aluout = au <<  bu[4:0]; // changed from 3:0 made 4:0
            alu_op_sra: aluout = unsigned'(as >>> bu[4:0]); // changed from 3:0 made 4:0
            alu_op_sub: aluout = au -   bu;
            alu_op_xor: aluout = au ^   bu;
            alu_op_srl: aluout = au >>  bu[4:0]; // changed from 3:0 made 4:0
            alu_op_or : aluout = au |   bu;
            alu_op_and: aluout = au &   bu;
            default   : aluout = 'x;
        endcase
    end

    always_comb begin
        unique case (cmpop)
            branch_f3_beq : br_en = (au == bu);
            branch_f3_bne : br_en = (au != bu);
            branch_f3_blt : br_en = (as <  bs);
            branch_f3_bge : br_en = (as >=  bs); // changed added =
            branch_f3_bltu: br_en = (au <  bu);
            branch_f3_bgeu: br_en = (au >=  bu); // changed added =
            default       : br_en = 1'bx;
        endcase
    end
    
    always_comb
    begin
        a          = 'x;
        b          = 'x;
        aluop      = 'x;
        cmpop      = 'x;
        dmem_addr  = 'x;
        dmem_rmask = '0;
        dmem_wmask = '0;
        dmem_wdata = 'x;
        dreq       = '0;
        dreq_load  = '0;
        rs2_s_real = '0;
        regf_we    = '0;
        rd_s_real  = '0;
        dmem_addr_saved = '0;
        use_rs1    = '0;
        use_rs2    = '0;
        rs1_temp   = rs1_v;
        pc_next    = id_ex.pc_next;
        branch_taken = '0;
        unique case (id_ex.opcode)
            op_b_load : begin
                // NOT NEEDED YET 
                regf_we = 1'b0;
                rd_v = id_ex.rd_data;
                rd_s_real = id_ex.rd_s;
                a = rs1_v;
                b = id_ex.i_imm;
                aluop = '0; // 0 for add
                cmpop = '0;
                dmem_addr = aluout; // add rs1_v + id_ex.i_imm
                dmem_addr_saved = aluout;
                unique case (id_ex.funct3)
                    load_f3_lb, load_f3_lbu: dmem_rmask = 4'b0001 << dmem_addr[1:0];
                    load_f3_lh, load_f3_lhu: dmem_rmask = 4'b0011 << dmem_addr[1:0];
                    load_f3_lw             : dmem_rmask = 4'b1111;
                    default                : dmem_rmask = 'x;
                endcase
                dreq = '1;
                dreq_load = '1;
                dmem_addr[1:0] = 2'd0; // align
                use_rs1 = '1; // IS THIS RIGHT
            end
            op_b_store: begin // uses rs2
                // NOT NEEDED YET 
                regf_we = 1'b0;
                rd_v = '0;//id_ex.rd_v;
                rd_s_real = '0;
                a = rs1_v;
                b = id_ex.s_imm;
                aluop = '0; // 0 for add
                cmpop = '0;
                dmem_addr = aluout;
                dmem_addr_saved = aluout;
                rs2_s_real = id_ex.rs2_s;
                unique case (id_ex.funct3)
                    store_f3_sb: dmem_wmask = 4'b0001 << dmem_addr[1:0];
                    store_f3_sh: dmem_wmask = 4'b0011 << dmem_addr[1:0];
                    store_f3_sw: dmem_wmask = 4'b1111;
                    default    : dmem_wmask = 'x;
                endcase
                unique case (id_ex.funct3)
                    store_f3_sb: dmem_wdata[8 *dmem_addr[1:0] +: 8 ] = rs2_v[7 :0];
                    store_f3_sh: dmem_wdata[16*dmem_addr[1]   +: 16] = rs2_v[15:0];
                    store_f3_sw: dmem_wdata = rs2_v;
                    default    : dmem_wdata = 'x;
                endcase
                dreq = '1;
                dmem_addr[1:0] = 2'd0; // align
                use_rs1 = '1; // IS THIS RIGHT
                use_rs2 = '1; // IS THIS RIGHT
            end

            default   : begin
                regf_we = 1'b0;
                rd_v = id_ex.rd_data;
                a = '0;
                b = '0;
                aluop = '0;
                cmpop = '0;
                rs2_s_real = '0;
                rd_s_real = '0;
            end
        endcase
    end





    always_comb
    begin
        ex_mem.inst = id_ex.inst;
        ex_mem.pc = id_ex.pc;
        ex_mem.pc_next = pc_next;//id_ex.pc_next;
        ex_mem.order = id_ex.order;
        //ex_mem.alu_m1_sel = id_ex.alu_m1_sel;
        ex_mem.valid = id_ex.valid;
        ex_mem.stall = id_ex.stall;

        ex_mem.funct3 = id_ex.funct3;
        ex_mem.funct7 = id_ex.funct7;
        ex_mem.opcode = id_ex.opcode;
        ex_mem.i_imm = id_ex.i_imm;
        ex_mem.s_imm = id_ex.s_imm;
        ex_mem.b_imm = id_ex.b_imm;
        ex_mem.u_imm = id_ex.u_imm;
        ex_mem.j_imm = id_ex.j_imm;
        ex_mem.rs1_s = use_rs1 ? id_ex.rs1_s : '0; // CHANGE THIS!!! - store still uses it but cannot use rs1
        ex_mem.rs2_s = rs2_s_real;
        ex_mem.rd_s = rd_s_real;
        ex_mem.rs1_data = use_rs1 ? id_ex.rs1_data : '0; // reg file or forwarded
        ex_mem.use_rs1 = use_rs1;
        ex_mem.rs2_data = use_rs2 ? id_ex.rs2_data : '0; // reg file or forwarded
        ex_mem.use_rs2 = use_rs2;
        ex_mem.rd_data = rd_v; // new
        ex_mem.regf_we = regf_we; // new -> phys
        ex_mem.is_store = id_ex.is_store; 
        ex_mem.is_load = id_ex.is_load;
        ex_mem.is_br = '0;
        ex_mem.head = '0;
        ex_mem.dmem_addr = dmem_addr;
        ex_mem.dmem_addr_saved = dmem_addr_saved;
        ex_mem.dmem_rmask = dmem_rmask;
        ex_mem.dmem_wmask = dmem_wmask;
        ex_mem.dmem_wdata = dmem_wdata;
        ex_mem.dreq = dreq;
        ex_mem.dreq_load = dreq_load;
        ex_mem.use_rd = id_ex.use_rd;
        ex_mem.branch_taken = id_ex.branch_taken;
        ex_mem.use_prs1 = id_ex.use_prs1;
        ex_mem.rs1_paddr = id_ex.rs1_paddr;
        ex_mem.rs1_ready = id_ex.rs1_ready;

        ex_mem.use_prs2 = id_ex.use_prs2;
        ex_mem.rs2_paddr = id_ex.rs2_paddr;
        ex_mem.rs2_ready = id_ex.rs2_ready;

        ex_mem.rd_paddr = id_ex.rd_paddr;


        ex_mem.rob_idx = id_ex.rob_idx;

        ex_mem.rob_overflow = id_ex.rob_overflow;

        // ex_mem.useless = id_ex.useless;


        //funct_unit_busy = '0;   //CHANGE

        ex_mem.rfvi_monitor_vals = id_ex.rfvi_monitor_vals;
        ex_mem.rfvi_monitor_vals.monitor_rs1_rdata = use_rs1 ? id_ex.rs1_data : '0;
        ex_mem.rfvi_monitor_vals.monitor_rs2_rdata = use_rs2 ? id_ex.rs2_data : '0;
        ex_mem.rfvi_monitor_vals.monitor_regf_we = regf_we;
        ex_mem.rfvi_monitor_vals.monitor_rd_wdata = rd_v;
        ex_mem.rfvi_monitor_vals.monitor_mem_addr = dmem_addr;
        ex_mem.rfvi_monitor_vals.monitor_mem_rmask = dmem_rmask;
        ex_mem.rfvi_monitor_vals.monitor_mem_wmask = dmem_wmask;
        ex_mem.rfvi_monitor_vals.monitor_mem_wdata = dmem_wdata;


    end
    
endmodule : load_store_unit