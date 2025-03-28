module pcreg
(
    input logic rst,
    input logic stall,
    input logic fetch_stall,
    input logic [31:0] pc,
    output logic [31:0] pc_next
);

    always_comb begin
        if(rst) begin
            pc_next = 32'hAAAAA000;
        end else if(stall == 0 && fetch_stall == 0) begin
            pc_next = pc + 4;
        end else begin
            pc_next = pc;
        end
    end

endmodule : pcreg