module if_stage
import rv32i_types::*;
(
    input   logic           clk,
    input   logic           rst,
    input   logic           stall,

    output  logic   [31:0]  imem_addr,
    output  logic   [3:0]   imem_rmask,
    input   logic   [31:0]  imem_rdata,
    input   logic           imem_resp,

    input   logic   [31:0]  pc,
    input   logic   [31:0]  pc_next,

    output if_id_stage_reg_t if_id
);

    logic [63:0] order_reg;

    always_ff @(posedge clk) begin
        if (rst) begin
            order_reg <= '0;
        end else if (imem_resp && !stall) begin
            order_reg <= order_reg + 1;
        end 
    end

    always_comb begin

            if_id.inst = '0;
            if_id.pc = pc;
            if_id.pc_next = pc_next;

            if_id.order = order_reg;

            if_id.valid = '1;
            if_id.rst = rst;
            
            imem_rmask  = '0;

            if_id.ctrl_word = '0;

            if_id.ctrl_word.dmem_rdata = '0;

            if_id.ctrl_word.commit = '0;

            imem_addr = pc_next;

            imem_rmask = '1;
            if (imem_resp) begin
                if_id.inst = imem_rdata;
                if_id.ctrl_word.commit = '1;
            end
    end


endmodule : if_stage