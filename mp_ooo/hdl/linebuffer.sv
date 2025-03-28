module linebuffer #(
            parameter               WIDTH     = 256
)(
    input   logic                   clk,
    input   logic                   rst,
    input   logic   [31:0]          new_bmem_addr, 
    input   logic                   wen,
    input   logic   [WIDTH-1:0]     wdata,
    output  logic   [WIDTH-1:0]     rdata,
    output  logic                   rvalid    
);

    logic [WIDTH-1:0] internal_array;

    logic [3:0] old_bmem_addr_set_reg;
    logic [3:0] new_bmem_addr_set;

    logic [22:0] old_bmem_addr_tag_reg;
    logic [22:0] new_bmem_addr_tag;

    logic write;
    logic read;
    logic old_valid;
    logic [WIDTH-1:0] wdata_reg;

    always_ff @(posedge clk) begin
        if (rst) begin
            wdata_reg <= '0;
        end else begin
            wdata_reg <= wdata;
        end
    end

    always_comb begin
        new_bmem_addr_set = new_bmem_addr[8:5];
        new_bmem_addr_tag = new_bmem_addr[31:9];
        if (old_bmem_addr_tag_reg != '0 && 
        old_bmem_addr_set_reg != '0 && 
        new_bmem_addr_set == old_bmem_addr_set_reg
        && new_bmem_addr_tag == old_bmem_addr_tag_reg) begin
            rvalid = '1;
        end else begin
            rvalid = '0;
        end

        write = wen;
        read = ~wen;
    end

    always_ff @(posedge clk) begin
        if(rst) begin
            old_bmem_addr_set_reg <= '0;
            old_bmem_addr_tag_reg <= '0;
            internal_array <= 'x;
            old_valid <= '0;
        end else if(write) begin
            old_bmem_addr_set_reg <= new_bmem_addr_set;
            old_bmem_addr_tag_reg <= new_bmem_addr_tag;
            old_valid <= '1;
            internal_array <= wdata_reg;
        end else if(read) begin
            if(old_valid && rvalid) begin
                rdata <= internal_array;
            end else begin
                rdata <= 'x;
            end
        end
    end

endmodule : linebuffer