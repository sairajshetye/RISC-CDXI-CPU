module pcreg
(
    input logic clk,
    input logic rst,
    input logic fetch_stall,
    output logic [31:0] pc,
    input logic [31:0] pc_next
);

    always_ff @(posedge clk) begin
        if(rst) begin
            pc <= 32'hAAAAA000;
        end else if (!fetch_stall) begin
            pc <= pc_next;
        end 
    end

endmodule : pcreg