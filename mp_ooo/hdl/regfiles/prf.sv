module prf
import rv32i_types::*;
 #(
            parameter               DEPTH     = 128,
            parameter               PTR_SIZE  = $clog2(DEPTH),
            parameter               WIDTH     = 32

)(
    input   logic                     clk,
    input   logic                     rst,
    input   logic                     regf_we_0,
    input   logic                     regf_we_1,
    input   logic                     regf_we_2,
    input   logic                     regf_we_3,
    input   logic   [WIDTH-1:0]       rd_v_0,
    input   logic   [WIDTH-1:0]       rd_v_1,
    input   logic   [WIDTH-1:0]       rd_v_2,
    input   logic   [WIDTH-1:0]       rd_v_3,
    input   logic   [PTR_SIZE-1:0]    rs1_s, rs2_s, rd_s_0, rd_s_1, rd_s_2, rd_s_3,
    input   logic   [PTR_SIZE-1:0]    commit_rs,
    input   logic                     free_we,
    input   logic   [PTR_SIZE-1:0]    rd_s_free,
    output  prf_t                     prs1_v, prs2_v, commit_prs, prs1_v_comb, prs2_v_comb
    //input   logic           load_stall,
    //input   logic           global_stall
    //input   logic           transparent_1, transparent_2
    //output  logic   [31:0]  rs1_v_comb, rs2_v_comb
);

    prf_t     data [DEPTH];
    logic     transparent_1_0, transparent_1_1, transparent_1_2, transparent_1_3, transparent_2_0, transparent_2_1, transparent_2_2, transparent_2_3;

    assign transparent_1_0 = regf_we_0 && (rd_s_0 == rs1_s);
    assign transparent_1_1 = regf_we_1 && (rd_s_1 == rs1_s); //  && (rs1_s != 5'd0) help
    assign transparent_1_2 = regf_we_2 && (rd_s_2 == rs1_s);
    assign transparent_1_3 = regf_we_3 && (rd_s_3 == rs1_s);
    assign transparent_2_0 = regf_we_0 && (rd_s_0 == rs2_s);
    assign transparent_2_1 = regf_we_1 && (rd_s_1 == rs2_s); //  && (rs2_s != 5'd0)
    assign transparent_2_2 = regf_we_2 && (rd_s_2 == rs2_s);
    assign transparent_2_3 = regf_we_3 && (rd_s_3 == rs2_s);
    

    always_ff @(posedge clk) begin
        if (rst) begin
            for (integer i = 0; i < DEPTH; i++) begin
                data[i].valid <= '0;
                data[i].value <= '0;
            end
        end else begin
            if (regf_we_0) begin // write to PRF     && (rd_s != 5'd0)
                data[rd_s_0].valid <= '1;
                data[rd_s_0].value <= rd_v_0;
            end

            if (regf_we_1) begin // write to PRF     && (rd_s != 5'd0)
                data[rd_s_1].valid <= '1;
                data[rd_s_1].value <= rd_v_1;
            end

            if (regf_we_2) begin // write to PRF     && (rd_s != 5'd0)
                data[rd_s_2].valid <= '1;
                data[rd_s_2].value <= rd_v_2;
            end

            if (regf_we_3) begin // write to PRF     && (rd_s != 5'd0)
                data[rd_s_3].valid <= '1;
                data[rd_s_3].value <= rd_v_3;
            end

            if (free_we) begin
                data[rd_s_free].valid <= '0;
                data[rd_s_free].value <= '0;
            end
        end
    end

    always_comb begin
        if (rst) begin
            prs1_v_comb = '0;
            prs2_v_comb = '0;
        end 
        else begin // read from PRF
            if (transparent_1_0) begin
                prs1_v_comb.valid = '1;
                prs1_v_comb.value = rd_v_0;
            end
            else if (transparent_1_1) begin
                prs1_v_comb.valid = '1;
                prs1_v_comb.value = rd_v_1;
            end
            else if (transparent_1_2) begin
                prs1_v_comb.valid = '1;
                prs1_v_comb.value = rd_v_2;
            end
            else if (transparent_1_3) begin
                prs1_v_comb.valid = '1;
                prs1_v_comb.value = rd_v_3;
            end
            else begin
                prs1_v_comb = data[rs1_s];
                //prs1_v_comb.valid = '1;
            end
            if (transparent_2_0) begin
                prs2_v_comb.valid = '1;
                prs2_v_comb.value = rd_v_0;
            end
            else if (transparent_2_1) begin
                prs2_v_comb.valid = '1;
                prs2_v_comb.value = rd_v_1;
            end
            else if (transparent_2_2) begin
                prs2_v_comb.valid = '1;
                prs2_v_comb.value = rd_v_2;
            end
            else if (transparent_2_3) begin
                prs2_v_comb.valid = '1;
                prs2_v_comb.value = rd_v_3;
            end
            else begin
                prs2_v_comb = data[rs2_s];
                //prs2_v_comb.valid = '1;
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