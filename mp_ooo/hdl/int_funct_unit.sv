module ex_stage
import rv32i_types::*;
(
    input id_ex_stage_reg_t id_ex,
    input logic [31:0] rs1_v,
    input logic [31:0] rs2_v,
    //input logic [31:0] ex_mem_rd_v,
    //input logic [31:0] mem_wb_rd_v,
    output ex_mem_stage_reg_t ex_mem
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

    assign as =   signed'(a);
    assign bs =   signed'(b);
    assign au = unsigned'(a);
    assign bu = unsigned'(b);


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
    // branch stuff, dont need for this checkpoint, will be its own FU
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
            op_b_lui  : begin
                rd_v = id_ex.u_imm;
                rd_s_real = id_ex.rd_s;
                regf_we = 1'b1;
            end
            op_b_auipc: begin
                rd_v = id_ex.pc + id_ex.u_imm;
                rd_s_real = id_ex.rd_s;
                regf_we = 1'b1;
            end
            op_b_jal  : begin // uses rd, but not rs1 or rs2
                // NOT NEEDED YET
                regf_we = 1'b1;
                rd_v = id_ex.pc_next;
                rd_s_real = id_ex.rd_s;
                a = '0;
                b = '0;
                aluop = '0;
                cmpop = '0;
                pc_next = id_ex.pc + id_ex.j_imm;
                branch_taken = '1;
            end
            op_b_jalr : begin
                // NOT NEEDED YET
                regf_we = 1'b1;
                rd_v = id_ex.pc_next;
                rd_s_real = id_ex.rd_s;
                a = '0;
                b = '0;
                aluop = '0;
                cmpop = '0;
                pc_next = (rs1_v + id_ex.i_imm) & 32'hfffffffe;
                use_rs1 = '1;
                branch_taken = '1;
            end
            op_b_br   : begin
                // NOT NEEDED YET - CP3
                regf_we = 1'b0;
                aluop = '0;

                rd_v = '0;//id_ex.rd_v;
                a = rs1_v;
                b = rs2_v;            
                cmpop = id_ex.funct3;
                if (br_en) begin
                    pc_next = id_ex.pc + id_ex.b_imm;
                    branch_taken = '1;
                end else begin
                    pc_next = id_ex.pc_next;
                    branch_taken = '0;
                end
                use_rs1 = '1;
                use_rs2 = '1;
                rs2_s_real = id_ex.rs2_s;
            end
            op_b_load : begin
                // NOT NEEDED YET CP2 NEEDS IT - just want to calculate the addr
                regf_we = 1'b0;
                rd_v = id_ex.rd_v;
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
                // NOT NEEDED YET CP2 NEEDS IT
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
            op_b_imm  : begin
                a = rs1_v; // potential point of failure, make sure rs1_v is right
                b = id_ex.i_imm;
                rd_s_real = id_ex.rd_s;
                unique case (id_ex.funct3)
                    arith_f3_slt: begin
                        cmpop = branch_f3_blt;
                        rd_v = {31'd0, br_en};
                    end
                    arith_f3_sltu: begin
                        cmpop = branch_f3_bltu;
                        rd_v = {31'd0, br_en};
                    end
                    arith_f3_sr: begin
                        if (id_ex.funct7[5]) begin
                            aluop = alu_op_sra;
                        end else begin
                            aluop = alu_op_srl;
                        end
                        rd_v = aluout;
                    end
                    default: begin
                        aluop = id_ex.funct3;
                        rd_v = aluout;
                    end
                endcase
                regf_we = 1'b1;
                use_rs1 = '1; // added cp3
            end
            op_b_reg  : begin //needs rs2
                a = rs1_v; // potential point of failure, make sure rs1_v is right
                b = rs2_v;
                rs2_s_real = id_ex.rs2_s;
                rd_s_real = id_ex.rd_s;
                unique case (id_ex.funct3)
                    arith_f3_slt: begin
                        cmpop = branch_f3_blt;
                        rd_v = {31'd0, br_en};
                    end
                    arith_f3_sltu: begin
                        cmpop = branch_f3_bltu;
                        rd_v = {31'd0, br_en};
                    end
                    arith_f3_sr: begin
                        if (id_ex.funct7[5]) begin
                            aluop = alu_op_sra;
                        end else begin
                            aluop = alu_op_srl;
                        end
                        rd_v = aluout;
                    end
                    arith_f3_add: begin
                        if (id_ex.funct7[5]) begin
                            aluop = alu_op_sub;
                        end else begin
                            aluop = alu_op_add;
                        end
                        rd_v = aluout;
                    end
                    default: begin
                        aluop = id_ex.funct3;
                        rd_v = aluout;
                    end
                endcase
                regf_we = 1'b1;
                use_rs1 = '1; // added cp3
                use_rs2 = '1; // added cp3
            end
            default   : begin
                regf_we = 1'b0;
                rd_v = id_ex.rd_v;
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
        ex_mem.alu_m1_sel = id_ex.alu_m1_sel;
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
        ex_mem.rs1_v = use_rs1 ? rs1_v : '0; // reg file or forwarded
        ex_mem.use_rs1 = use_rs1;
        ex_mem.rs2_v = use_rs2 ? rs2_v : '0; // reg file or forwarded
        ex_mem.use_rs2 = use_rs2;
        ex_mem.rd_v = rd_v; // new
        ex_mem.regf_we = regf_we; // new
        ex_mem.dmem_addr = dmem_addr;
        ex_mem.dmem_addr_saved = dmem_addr_saved;
        ex_mem.dmem_rmask = dmem_rmask;
        ex_mem.dmem_wmask = dmem_wmask;
        ex_mem.dmem_wdata = dmem_wdata;
        ex_mem.dreq = dreq;
        ex_mem.dreq_load = dreq_load;
        ex_mem.use_rd = id_ex.use_rd;
        ex_mem.branch_taken = branch_taken;
    end
    
endmodule : ex_stage