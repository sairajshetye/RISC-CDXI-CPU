package rv32i_types;

    
    typedef enum logic {
        rs1_out = 1'b0,
        pc_out  = 1'b1
    } alu_m1_sel_t;

    typedef enum logic {
        rs2_out = 1'b0,
        imm_out = 1'b1
    } alu_m2_sel_t;

    typedef enum logic {
        waiting = 1'b0,
        done = 1'b1
    } status_t;

    typedef enum logic [6:0] {
        op_b_lui       = 7'b0110111, // load upper immediate (U type)
        op_b_auipc     = 7'b0010111, // add upper immediate PC (U type)
        op_b_jal       = 7'b1101111, // jump and link (J type)
        op_b_jalr      = 7'b1100111, // jump and link register (I type)
        op_b_br        = 7'b1100011, // branch (B type)
        op_b_load      = 7'b0000011, // load (I type)
        op_b_store     = 7'b0100011, // store (S type)
        op_b_imm       = 7'b0010011, // arith ops with register/immediate operands (I type)
        op_b_reg       = 7'b0110011  // arith ops with register operands (R type)
    } rv32i_opcode;

    typedef struct packed {
            logic               commit;

            logic               load_ir;

            logic   [2:0]       funct3;
            logic   [6:0]       funct7;
            logic   [6:0]       opcode;

            logic   [31:0]      i_imm;
            logic   [31:0]      s_imm;
            logic   [31:0]      b_imm;
            logic   [31:0]      u_imm;
            logic   [31:0]      j_imm;
            logic   [31:0]      curr_imm;

            logic   [4:0]       rs1_s;
            logic   [4:0]       rs2_s;
            logic   [4:0]       rd_s;
            
            logic               regf_we;
            //logic   [31:0]      rs1_v;
            //logic   [31:0]      rs2_v;
            logic   [31:0]      rd_v;

            logic   [31:0]      a;
            logic   [31:0]      b;
            logic   [2:0]       aluop;
            logic   [2:0]       cmpop;

            logic               br_en;

            alu_m1_sel_t        alu_m1_sel;
            alu_m2_sel_t        alu_m2_sel;

            logic           valid_mem_instr;

            logic   [31:0]  dmem_addr;
            logic   [31:0]  old_dmem_addr;
            logic   [3:0]   dmem_rmask;
            logic   [3:0]   dmem_wmask;
            logic   [31:0]  dmem_wdata;
            logic   [31:0]  dmem_rdata;

            logic           i_use_rs1;
            logic           i_use_rs2;

            logic           is_load;
            logic           is_store;
    } ctrl_word_t;

    // typedef struct packed {
    //     logic   [31:0]      inst;
    //     logic   [31:0]      pc;
    //     logic   [31:0]      pc_next;
    //     logic   [63:0]      order;
    //     logic               valid;
    //     logic               rst;
    //     ctrl_word_t         ctrl_word;
    // } if_id_stage_reg_t;

    typedef struct packed {
        logic   [31:0]      inst;
        logic   [31:0]      pc;
        logic   [31:0]      pc_next;
        logic   [63:0]      order;
        logic               valid;
        logic               fetch_stall;
        logic   [1:0]       useless; // zero padding

        // alu_m1_sel_t        alu_m1_sel;

        // what else?

    } if_id_stage_reg_t;


    typedef struct packed {
        logic   [31:0]      inst;
        logic   [31:0]      pc;
        logic   [63:0]      order;
        logic   [31:0]      pc_next;
        logic               valid;
        logic               stall;

        alu_m1_sel_t        alu_m1_sel;

        logic   [2:0]   funct3;
        logic   [6:0]   funct7;
        logic   [6:0]   opcode;
        logic   [31:0]  i_imm;
        logic   [31:0]  s_imm;
        logic   [31:0]  b_imm;
        logic   [31:0]  u_imm;
        logic   [31:0]  j_imm;
        logic   [4:0]   rs1_s;
        logic           use_rs1;
        logic   [4:0]   rs2_s;
        logic           use_rs2;
        logic   [4:0]   rd_s;
        logic   [31:0]  rs1_v;
        logic   [31:0]  rs2_v;
        logic   [31:0]  rd_v;
        logic           regf_we;
        logic           is_store;
        logic           use_rd;
        // what else?

    } id_ex_stage_reg_t;


    typedef struct packed {
        logic valid;
        status_t status;
        rv32i_opcode opcode;
        logic [6:0] rd_paddr;
        logic [4:0] rd_addr;
        logic br_pred;
        logic br_result;
    } rob_entry_t;


endpackage : rv32i_types