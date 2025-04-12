module prf
import rv32i_types::*;
 #(
            parameter               DEPTH     = 128,
            parameter               PTR_SIZE  = $clog2(DEPTH),
            parameter               WIDTH     = 32

)(
    input   logic                     clk,
    input   logic                     rst,
    input   logic                     regf_we,
    input   logic   [WIDTH-1:0]       rd_v,
    input   logic   [PTR_SIZE-1:0]    rs1_s, rs2_s, rd_s,
    input   logic   [PTR_SIZE-1:0]    commit_rs,
    input   logic                     free_we,
    input   logic   [PTR_SIZE-1:0]    rd_s_free,
    output  prf_t                     prs1_v, prs2_v, commit_prs
    //input   logic           load_stall,
    //input   logic           global_stall
    //input   logic           transparent_1, transparent_2
    //output  logic   [31:0]  rs1_v_comb, rs2_v_comb
);

    prf_t     data [DEPTH];
    logic     transparent_1, transparent_2;

    assign transparent_1 = regf_we && (rd_s == rs1_s); //  && (rs1_s != 5'd0) help
    assign transparent_2 = regf_we && (rd_s == rs2_s); //  && (rs2_s != 5'd0)

    always_ff @(posedge clk) begin
        if (rst) begin
            for (integer i = 0; i < DEPTH; i++) begin
                data[i].valid <= '0;
                data[i].value <= '0;
            end
        end else begin
            if (regf_we) begin // write to PRF     && (rd_s != 5'd0)
                data[rd_s].valid <= '1;
                data[rd_s].value <= rd_v;
            end

            if (free_we) begin
                data[rd_s_free].valid <= '0;
                data[rd_s_free].value <= '0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            prs1_v <= 'x;
            prs2_v <= 'x;
        end 
        else begin // read from PRF
            if (transparent_1) begin
                prs1_v.valid <= '1;
                prs1_v.value <= rd_v;
            end
            else begin
                prs1_v <= data[rs1_s];
            end
            if (transparent_2) begin
                prs2_v.valid <= '1;
                prs2_v.value <= rd_v;
            end
            else begin
                prs2_v <= data[rs2_s];
            end
        end
        // else if (!global_stall & !load_stall) begin
        //     if (transparent_1)
        //         rs1_v <= (rs1_s != 5'd0) ? rd_v : '0;
        //     else
        //         rs1_v <= (rs1_s != 5'd0) ? data[rs1_s] : '0;
        //     if (transparent_2)
        //         rs2_v <= (rs2_s != 5'd0) ? rd_v : '0;
        //     else
        //         rs2_v <= (rs2_s != 5'd0) ? data[rs2_s] : '0;
        // end
        // else if (!global_stall & load_stall) begin // also for transparent, in case of stall due to load use
        //     if (regf_we && (rd_s == rs1_s_ex) && (rs1_s_ex != 5'd0))
        //         rs1_v <= (rs1_s_ex != 5'd0) ? rd_v : '0;
        //     if (regf_we && (rd_s == rs2_s_ex) && (rs2_s_ex != 5'd0))
        //         rs1_v <= (rs2_s_ex != 5'd0) ? rd_v : '0;
        // end
    end

    assign commit_prs = data[commit_rs]; // shouldnt do p0 -> change later
    //assign rs1_v_comb = (rs1_s != 5'd0) ? data[rs1_s] : '0;
    //assign rs2_v_comb = (rs2_s != 5'd0) ? data[rs2_s] : '0;

endmodule : prf