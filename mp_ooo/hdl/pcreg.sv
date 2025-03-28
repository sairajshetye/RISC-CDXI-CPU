module pcreg
(
    input logic clk,
    input logic rst,
    output logic [31:0] pc,
    input logic [31:0] pc_next
);

    always_ff @(posedge clk) begin
        if(rst) begin
            pc <= 32'hAAAAA000;
        end else begin
            pc <= pc_next;
        end
    end

endmodule : pcreg