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

    typedef enum logic {
        not_taken = 1'b0,
        taken = 1'b1
    } branch_t;


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
        logic           monitor_valid; //
        logic   [63:0]  monitor_order; //
        logic   [31:0]  monitor_inst; //
        logic   [4:0]   monitor_rs1_addr; //
        logic   [4:0]   monitor_rs2_addr; //
        logic   [31:0]  monitor_rs1_rdata; //
        logic   [31:0]  monitor_rs2_rdata; //
        logic           monitor_regf_we; //
        logic   [4:0]   monitor_rd_addr; //
        logic   [31:0]  monitor_rd_wdata; //
        logic   [31:0]  monitor_pc_rdata; //
        logic   [31:0]  monitor_pc_wdata; //
        logic   [31:0]  monitor_mem_addr; //
        logic   [3:0]   monitor_mem_rmask; //
        logic   [3:0]   monitor_mem_wmask; //
        logic   [31:0]  monitor_mem_rdata; //
        logic   [31:0]  monitor_mem_wdata; //
        logic           monitor_useless; //
    } rfvi_packet_t;

    typedef struct packed {
        logic   [31:0]      inst;
        logic   [31:0]      pc;
        logic   [31:0]      pc_next;
        logic   [63:0]      order;
        logic               valid;
        logic               fetch_stall;
        logic               deq;
        logic               useless; // zero padding
        rfvi_packet_t       rfvi_monitor_vals;

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

        //alu_m1_sel_t        alu_m1_sel;

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
        // logic   [31:0]  rs1_v;
        // logic   [31:0]  rs2_v;
        // logic   [31:0]  rd_v;
        logic           regf_we;
        logic           is_store;
        logic           use_rd;
        // what else? - 391-32 bits
        logic           deq;
        //logic           useless;
        rfvi_packet_t       rfvi_monitor_vals;

    } id_ex_stage_reg_t;

    typedef struct packed {
        logic   [31:0]      inst;
        logic   [31:0]      pc;
        logic   [63:0]      order;
        logic   [31:0]      pc_next;
        logic               valid;
        logic               stall;

        //alu_m1_sel_t        alu_m1_sel;

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
        // logic   [31:0]  rs1_v;
        // logic   [31:0]  rs2_v;
        //logic   [31:0]  rd_v;
        logic           regf_we;
        logic           is_store;
        logic           use_rd;
        // what else? - 391 bits
        // logic             rs1_data
        logic           use_prs1;
        logic    [6:0]  rs1_paddr;
        logic           rs1_ready;

        logic           use_prs2;
        logic    [6:0]  rs2_paddr;
        logic           rs2_ready;

        logic    [3:0]  rob_idx;

        logic    [6:0]  rd_paddr;

        logic           deq;

        logic    [2:0]  useless;

        rfvi_packet_t       rfvi_monitor_vals;


    } ra_dp_stage_reg_t;

    typedef struct packed {
        logic   [31:0]      inst;
        logic   [31:0]      pc;
        logic   [63:0]      order;
        logic   [31:0]      pc_next;
        logic               valid;
        logic               stall;

        //alu_m1_sel_t        alu_m1_sel;

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
        // logic   [31:0]  rs1_v;
        // logic   [31:0]  rs2_v;
        //logic   [31:0]  rd_v;
        logic           regf_we;
        logic           is_store;
        logic           use_rd;
        // what else? - 391 bits
        // logic             rs1_data
        logic           use_prs1;
        logic    [6:0]  rs1_paddr;
        logic           rs1_ready;
        logic    [31:0] rs1_data;

        logic           use_prs2;
        logic    [6:0]  rs2_paddr;
        logic           rs2_ready;
        logic    [31:0] rs2_data;

        logic    [6:0]  rd_paddr;
        logic    [31:0] rd_data;

        logic    [3:0]  rob_idx;

        rfvi_packet_t       rfvi_monitor_vals;

        // logic           useless;
    } dp_is_stage_reg_t;

    typedef struct packed {
        //valid, renamed, p_addr, value
        logic           valid;
        logic           renamed; // not renamed = 0, renamed = 1
        logic   [6:0]   p_addr;
        logic   [6:0]   p_addr_ret; // retirement
        logic   [31:0]  value;
    } arf_reg_t;


    typedef struct packed {
        //valid, value
        logic           valid;
        logic   [31:0]  value;
    } prf_t;


        typedef struct packed {
        logic   [31:0]      inst;
        logic   [31:0]      pc;
        logic   [63:0]      order;
        logic   [31:0]      pc_next;
        logic               valid;
        logic               stall;

        //alu_m1_sel_t        alu_m1_sel;

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
        logic           use_rd;
        logic           regf_we;
        
        logic   [31:0]  dmem_addr;
        logic   [31:0]  dmem_addr_saved;
        logic   [3:0]   dmem_rmask;
        logic   [3:0]   dmem_wmask;
        //logic   [31:0]  dmem_rdata;
        logic   [31:0]  dmem_wdata;
        logic           dreq;
        logic           dreq_load;

        logic           branch_taken;

        // what else?

    } ex_mem_stage_reg_t;

    typedef struct packed {
        logic   [31:0]      inst;
        logic   [31:0]      pc;
        logic   [63:0]      order;
        logic   [31:0]      pc_next;
        logic               valid;
        logic               stall;

        //alu_m1_sel_t        alu_m1_sel;

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
        logic           is_store;
        logic           use_rd;
        logic           regf_we;
        
        logic   [31:0]  dmem_addr;
        logic   [31:0]  dmem_addr_saved;
        logic   [3:0]   dmem_rmask;
        logic   [3:0]   dmem_wmask;
        //logic   [31:0]  dmem_rdata;
        logic   [31:0]  dmem_wdata;
        logic           dreq;
        logic           dreq_load;

        logic           branch_taken;

    } prf_ex_stage_reg_t;       //comes out of prf? could easily not be struct


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
        logic valid;
        status_t status;
        logic [6:0] opcode;
        logic       use_rd;
        logic [6:0] rd_paddr;
        logic [4:0] rd_addr;
        branch_t br_pred;
        branch_t br_result;

        rfvi_packet_t       rfvi_monitor_vals;
    } rob_entry_t;

    typedef enum logic [2:0] {
        arith_f3_add   = 3'b000, // check logic 30 for sub if op_reg op
        arith_f3_sll   = 3'b001,
        arith_f3_slt   = 3'b010,
        arith_f3_sltu  = 3'b011,
        arith_f3_xor   = 3'b100,
        arith_f3_sr    = 3'b101, // check logic 30 for logical/arithmetic
        arith_f3_or    = 3'b110,
        arith_f3_and   = 3'b111
    } arith_f3_t;

    typedef enum logic [2:0] {
        load_f3_lb     = 3'b000,
        load_f3_lh     = 3'b001,
        load_f3_lw     = 3'b010,
        load_f3_lbu    = 3'b100,
        load_f3_lhu    = 3'b101
    } load_f3_t;

    typedef enum logic [2:0] {
        store_f3_sb    = 3'b000,
        store_f3_sh    = 3'b001,
        store_f3_sw    = 3'b010
    } store_f3_t;

    typedef enum logic [2:0] {
        branch_f3_beq  = 3'b000,
        branch_f3_bne  = 3'b001,
        branch_f3_blt  = 3'b100,
        branch_f3_bge  = 3'b101,
        branch_f3_bltu = 3'b110,
        branch_f3_bgeu = 3'b111
    } branch_f3_t;

    typedef enum logic [2:0] {
        alu_op_add     = 3'b000,
        alu_op_sll     = 3'b001,
        alu_op_sra     = 3'b010,
        alu_op_sub     = 3'b011,
        alu_op_xor     = 3'b100,
        alu_op_srl     = 3'b101,
        alu_op_or      = 3'b110,
        alu_op_and     = 3'b111
    } alu_ops;

    typedef enum logic [2:0] {
        md_MUL      = 3'b000,
        md_MULH     = 3'b001,
        md_MULHSU   = 3'b010,
        md_MULHU    = 3'b011,
        md_DIV      = 3'b100,
        md_DIVU     = 3'b101,
        md_REM      = 3'b110,
        md_REMU     = 3'b111
    } mul_div_ops;

    typedef enum logic [6:0] {
        funct7_mult = 7'b0000001
    } reg_funct7_vals;




    /// RANDOM TESTBENCH TYPES
    // typedef enum logic [6:0] {
    //     op_b_lui       = 7'b0110111, // load upper immediate (U type)
    //     op_b_auipc     = 7'b0010111, // add upper immediate PC (U type)
    //     op_b_jal       = 7'b1101111, // jump and link (J type)
    //     op_b_jalr      = 7'b1100111, // jump and link register (I type)
    //     op_b_br        = 7'b1100011, // branch (B type)
    //     op_b_load      = 7'b0000011, // load (I type)
    //     op_b_store     = 7'b0100011, // store (S type)
    //     op_b_imm       = 7'b0010011, // arith ops with register/immediate operands (I type)
    //     op_b_reg       = 7'b0110011  // arith ops with register operands (R type)
    // } rv32i_opcode;

    // typedef enum logic [2:0] {
    //     arith_f3_add   = 3'b000, // check logic 30 for sub if op_reg op
    //     arith_f3_sll   = 3'b001,
    //     arith_f3_slt   = 3'b010,
    //     arith_f3_sltu  = 3'b011,
    //     arith_f3_xor   = 3'b100,
    //     arith_f3_sr    = 3'b101, // check logic 30 for logical/arithmetic
    //     arith_f3_or    = 3'b110,
    //     arith_f3_and   = 3'b111
    // } arith_f3_t;

    // typedef enum logic [2:0] {
    //     load_f3_lb     = 3'b000,
    //     load_f3_lh     = 3'b001,
    //     load_f3_lw     = 3'b010,
    //     load_f3_lbu    = 3'b100,
    //     load_f3_lhu    = 3'b101
    // } load_f3_t;

    // typedef enum logic [2:0] {
    //     store_f3_sb    = 3'b000,
    //     store_f3_sh    = 3'b001,
    //     store_f3_sw    = 3'b010
    // } store_f3_t;

    typedef enum logic [2:0] {
        jalr_f3    = 3'b000
    } jalr_f3_t;

    // typedef enum logic [2:0] {
    //     branch_f3_beq  = 3'b000,
    //     branch_f3_bne  = 3'b001,
    //     branch_f3_blt  = 3'b100,
    //     branch_f3_bge  = 3'b101,
    //     branch_f3_bltu = 3'b110,
    //     branch_f3_bgeu = 3'b111
    // } branch_f3_t;

    // You'll need this type to randomly generate variants of certain
    // instructions that have the funct7 field.
    typedef enum logic [6:0] {
        base           = 7'b0000000,
        variant        = 7'b0100000
    } funct7_t;

    // typedef enum logic [2:0] {
    //     alu_op_add     = 3'b000,
    //     alu_op_sll     = 3'b001,
    //     alu_op_sra     = 3'b010,
    //     alu_op_sub     = 3'b011,
    //     alu_op_xor     = 3'b100,
    //     alu_op_srl     = 3'b101,
    //     alu_op_or      = 3'b110,
    //     alu_op_and     = 3'b111
    // } alu_ops;

    typedef union packed {
        logic [31:0] word;

        struct packed {
            logic [11:0] i_imm;
            logic [4:0]  rs1;
            logic [2:0]  funct3;
            logic [4:0]  rd;
            rv32i_opcode opcode;
        } i_type;

        struct packed {
            logic [6:0]  funct7;
            logic [4:0]  rs2;
            logic [4:0]  rs1;
            logic [2:0]  funct3;
            logic [4:0]  rd;
            rv32i_opcode opcode;
        } r_type;

        struct packed {
            logic [11:5] imm_s_top;
            logic [4:0]  rs2;
            logic [4:0]  rs1;
            logic [2:0]  funct3;
            logic [4:0]  imm_s_bot;
            rv32i_opcode opcode;
        } s_type;

        struct packed {
            logic imm_b_12;
            logic [10:5] imm_b_top;
            logic [4:0] rs2;
            logic [4:0] rs1;
            logic [2:0] funct3;
            logic [4:1] imm_b_bot;
            logic imm_b_11;
            rv32i_opcode opcode;
        } b_type;

        struct packed {
            logic [31:12] imm;
            logic [4:0]   rd;
            rv32i_opcode  opcode;
        } j_type;

        // I made this 
        struct packed {
            logic [31:12] imm;
            logic [4:0]   rd;
            rv32i_opcode  opcode;
        } u_type;

    } instr_t;

    // add your types in this file if needed.
    typedef enum logic [2:0] {
        imm_f3_slli = 3'b001,
        imm_f3_srli = 3'b101
    } imm_f3_t;

    typedef enum logic [6:0] {
        valid_f7_1 = 7'b0000000,
        valid_f7_2 = 7'b0100000
    } funct_7_valid_t;

    typedef enum logic [4:0] {
        zeroed_val = 5'b00000
    } zeroed_register;

endpackage : rv32i_types