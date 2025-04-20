module id_stage
import rv32i_types::*;
(
    input if_id_stage_reg_t if_id,
    // input   logic         rq_stall,
    input   logic        dq_stall,
   //input   logic [31:0]  rs1_v,
    //input   logic [31:0]  rs2_v,
    output  logic         enq,
    // output  logic         deq,
    // output  logic [4:0]   rs1_s,
    // output  logic [4:0]   rs2_s,
    //input   logic         global_stall,
    output id_ex_stage_reg_t id_ex
);
 
    logic   [2:0]   funct3;
    logic   [6:0]   funct7;
    logic   [6:0]   opcode;
    logic   [31:0]  i_imm;
    logic   [31:0]  s_imm;
    logic   [31:0]  b_imm;
    logic   [31:0]  u_imm;
    logic   [31:0]  j_imm;
    logic   [4:0]   rd_s;
    logic   [31:0]  rd_v;
    logic           regf_we;
    logic           use_rs1, use_rs2, use_rd, is_store, is_load;
    logic   [4:0]   rs1_s;
    logic   [4:0]   rs2_s;

    logic           valid_check;

    assign funct3 = if_id.inst[14:12];
    assign funct7 = if_id.inst[31:25];
    assign opcode = if_id.inst[6:0];
    assign i_imm  = {{21{if_id.inst[31]}}, if_id.inst[30:20]};
    assign s_imm  = {{21{if_id.inst[31]}}, if_id.inst[30:25], if_id.inst[11:7]};
    assign b_imm  = {{20{if_id.inst[31]}}, if_id.inst[7], if_id.inst[30:25], if_id.inst[11:8], 1'b0};
    assign u_imm  = {if_id.inst[31:12], 12'h000}; // imm[19:0] {13{inst[31]},inst[30:12]}
    assign j_imm  = {{12{if_id.inst[31]}}, if_id.inst[19:12], if_id.inst[20], if_id.inst[30:21], 1'b0};
    //assign rs1_s  = if_id.inst[19:15];
    //assign rs2_s  = if_id.inst[24:20];
    //assign rd_s   = if_id.inst[11:7];
    assign is_store = opcode == 7'b0100011 ? 1'b1 : 1'b0;
    assign is_load = opcode == 7'b0000011 ? 1'b1 : 1'b0;

    assign regf_we = 1'b1; // should only write back at wb stage tho hmm and if needed

    //assign deq = '0; // dont dequeue from decode queue
    
    always_comb begin // sets if we use rs1, rs2, rd
        unique case (opcode)
            7'b0010011: begin // b_imm
                use_rs1 = '1;
                use_rs2 = '0;
                use_rd = '1;
                valid_check = '1;
            end
            7'b0110011: begin // b_reg
                use_rs1 = '1;
                use_rs2 = '1;
                use_rd = '1;
                valid_check = '1;
            end
            7'b0000011: begin // b_load
                use_rs1 = '1;
                use_rs2 = '0;
                use_rd = '1;
                valid_check = '1;
            end
            7'b0100011: begin // b_store
                use_rs1 = '1;
                use_rs2 = '1;
                use_rd = '0;
                valid_check = '1;
            end
            7'b1100011 : begin // b_br
                use_rs1 = '1;
                use_rs2 = '1;
                use_rd = '0;
                valid_check = '1;
            end
            7'b1100111: begin // b_jalr
                use_rs1 = '1;
                use_rs2 = '0;
                use_rd = '1;
                valid_check = '1;
            end
            7'b1101111: begin // b_jal
                use_rs1 = '0;
                use_rs2 = '0;
                use_rd = '1;
                valid_check = '1;
            end
            7'b0010111: begin // b_auipc
                use_rs1 = '0;
                use_rs2 = '0;
                use_rd = '1;
                valid_check = '1;
            end
            7'b0110111: begin // b_lui
                use_rs1 = '0;
                use_rs2 = '0;
                use_rd = '1;
                valid_check = '1;
            end
            default: begin
                use_rs1 = '0;
                use_rs2 = '0;
                use_rd = '1; // default will use rd
                valid_check = '0;
            end
        endcase

        rs1_s = use_rs1 ? if_id.inst[19:15] : '0;
        rs2_s = use_rs2 ? if_id.inst[24:20] : '0;
        rd_s  = use_rd ? if_id.inst[11:7] : '0;
    end

    always_comb
    begin
        id_ex.inst = if_id.inst;
        id_ex.pc = if_id.pc;
        id_ex.pc_next = if_id.pc_next;
        id_ex.order = if_id.order;
        //id_ex.alu_m1_sel = '0; //if_id.alu_m1_sel;
        id_ex.valid = valid_check;//if_id.valid;
        id_ex.stall = if_id.fetch_stall;

        id_ex.funct3 = funct3;
        id_ex.funct7 = funct7;
        id_ex.opcode = opcode;
        id_ex.i_imm = i_imm;
        id_ex.s_imm = s_imm;
        id_ex.b_imm = b_imm;
        id_ex.u_imm = u_imm;
        id_ex.j_imm = j_imm;
        id_ex.rs1_s = rs1_s;
        id_ex.rs2_s = rs2_s;
        id_ex.rd_s = rd_s;
        //id_ex.rs1_v = rs1_v;
        //id_ex.rs2_v = rs2_v;
        //id_ex.rd_v = i_imm; // needs to be mux ? -> handled in exec
        id_ex.regf_we = regf_we;
        id_ex.use_rs1 = use_rs1;
        id_ex.use_rs2 = use_rs2;
        id_ex.is_store = is_store;
        id_ex.is_load = is_load;
        id_ex.use_rd = use_rd;
        //id_ex.useless = '0;
        // if (rq_stall) begin
        //     deq = '0;
        //     id_ex.deq = '0;
        // end
        // else begin
        //     deq = '1;
        //     id_ex.deq = '1;
        // end
        // enq = if_id.deq;

        if (!dq_stall && if_id.valid) begin
            enq = '1;
        end else begin
            enq = '0;
        end


        id_ex.rfvi_monitor_vals = if_id.rfvi_monitor_vals;
        id_ex.rfvi_monitor_vals.monitor_rs1_addr = rs1_s;
        id_ex.rfvi_monitor_vals.monitor_rs2_addr = rs2_s;

        id_ex.rfvi_monitor_vals.monitor_rd_addr = rd_s;
    end

endmodule : id_stage