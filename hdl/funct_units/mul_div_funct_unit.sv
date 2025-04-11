module multiply_divide_unit
import rv32i_types::*;
#(
        parameter INST_SIZE = 32,
        parameter RS1_DATA_SIZE = 32,
        parameter RS2_DATA_SIZE = 32,
        parameter RESET_MODE = 0,
        parameter ONE = 1,
        parameter ZERO = 0

)
(   
    input logic clk, 
    input logic rst,
    input dp_is_stage_reg_t rs_out,           //only use inst (change to be just that?)
    input logic pre_wb_mult_stall,
    //input logic [RS1_DATA_SIZE-1:0] rs1_v,        //rs1 read data
    //input logic [RS2_DATA_SIZE-1:0] rs2_v,        //rs2 read data
    output logic funct_unit_busy,
    output dp_is_stage_reg_t out_inst
    //output logic [RS1_DATA_SIZE-1:0] out

);  
    logic [2:0] funct3;
    logic [RS1_DATA_SIZE+RS2_DATA_SIZE-1:0] product;
    logic div_en, mult_en, div_tc, mult_tc;
    
    logic div0, div0_tc;
    logic [RS1_DATA_SIZE-1:0] quotient, quotient_tc, remainder, remainder_tc;
    

    logic [2:0] out_select;
    logic start_sig, end_sig;

    integer counter;

    logic [RS1_DATA_SIZE-1:0] rs1_v, rs2_v;
    logic [RS1_DATA_SIZE-1:0] out;


    /* out_select
    3'b000 : '0 
    3'b001 : mult low bits
    3'b010 : mult high bits
    3'b011 : signed overflow
    3'b100 : div signed
    3'b101 : div unsigned
    3'b110 : rem of div signed
    3'b111 : rem of div unsigned
    */
    

    always_comb begin
        funct3 = rs_out.funct3;
        rs1_v = rs_out.rs1_data;
        rs2_v = rs_out.rs2_data;
    end

    always_comb begin
        if (!rst) begin
            mult_en = '0;
                mult_tc = '0;
                div_en = '0;
                div_tc = '0;
                out_select = 3'b000;
        end else begin 
        unique case (funct3)
            md_MUL : begin      //MUL, signed x signed
                mult_en = '1;
                mult_tc = '1;
                div_en = '0;
                div_tc = '0;
                out_select = 3'b001;
            end
            md_MULH : begin      //MUL High, signed x signed
                mult_en = '1;
                mult_tc = '1;
                div_en = '0;
                div_tc = '0;
                out_select = 3'b010;
            end
            md_MULHSU : begin      //MUL High (S)(U), signed x unsigned
                mult_en = '1;
                mult_tc = '1;   //?
                div_en = '0;
                div_tc = '0;
                out_select = 3'b010;
            end
            md_MULHU : begin      //MUL High (U), unsigned x unisgned
                mult_en = '1;
                mult_tc = '0;
                div_en = '0;
                div_tc = '0;
                out_select = 3'b010;
            end
            md_DIV : begin      //DIV
                if ((signed'(rs2_v) == signed'(-32'b1)) && (signed'(rs1_v) == signed'('hFFFFFFFF))) begin //signed overflow
                    mult_en = '0;
                    mult_tc = '0;
                    div_en = '0;
                    div_tc = '0;
                    out_select = 3'b011;
                
                end else begin
                    mult_en = '0;
                    mult_tc = '0;
                    div_en = '0;
                    div_tc = '1;
                    out_select = 3'b100;
                end
            end
            md_DIVU : begin      //DIV (U)
                mult_en = '0;
                mult_tc = '0;
                div_en = '1;
                div_tc = '0;
                out_select = 3'b101;
            end
            md_REM : begin      //Remainder
                if ((signed'(rs2_v) == signed'(-32'b1)) && (signed'(rs1_v) == signed'('hFFFFFFFF))) begin //signed overflow
                    mult_en = '0;
                    mult_tc = '0;
                    div_en = '0;
                    div_tc = '0;
                    out_select = 3'b011;
                end else begin
                    mult_en = '0;
                    mult_tc = '0;
                    div_en = '0;
                    div_tc = '1;
                    out_select = 3'b110;
                end
            end
            md_REMU : begin      //Remainder (U)
                mult_en = '0;
                mult_tc = '0;
                div_en = '1;
                div_tc = '0;
                out_select = 3'b111;
            end
            default : begin
                mult_en = '0;
                mult_tc = '0;
                div_en = '0;
                div_tc = '0;
                out_select = '0;
            end
        endcase
        end

    end
    DW_mult_pipe #(
        .a_width(RS1_DATA_SIZE), 
        .b_width(RS2_DATA_SIZE), 
        .rst_mode(RESET_MODE)
        ) mult (
        .clk(clk), 
        .rst_n(rst), //active low
        .en(mult_en),    //enable
        .tc(mult_tc),   //two's complement 
        .a(rs1_v),
        .b(rs2_v), 
        .product(product) 

    );

    DW_div_pipe #(
        .a_width(RS1_DATA_SIZE), 
        .b_width(RS2_DATA_SIZE), 
        .tc_mode(ZERO),      //two's complement 
        .rst_mode(RESET_MODE)
    ) div (
        .clk(clk),
        .rst_n(rst),    //active low
        .en(div_en),     //enable
        .a(rs1_v),
        .b(rs2_v),
        .quotient(quotient),
        .remainder(remainder),
        .divide_by_0(div0)
    );

    DW_div_pipe #(
        .a_width(RS1_DATA_SIZE), 
        .b_width(RS2_DATA_SIZE), 
        .tc_mode(ONE),      //two's complement 
        .rst_mode(RESET_MODE)
    ) div_signed (
        .clk(clk),
        .rst_n(rst),    //active low
        .en(div_tc),     //enable
        .a(rs1_v),
        .b(rs2_v),
        .quotient(quotient_tc),
        .remainder(remainder_tc),
        .divide_by_0(div0_tc)
    );

    /* out_select

    3'b000 : '0 
    3'b001 : mult low bits
    3'b010 : mult high bits
    3'b011 : 
    3'b100 : div signed
    3'b101 : div unsigned
    3'b110 : rem of div signed
    3'b111 : rem of div unsigned
    
    */
    always_comb begin
        out = '0;
        case (out_select)
            3'b000 : begin  //nothing
                out = '0;
            end
            3'b001 : begin  //mult low bits
                out = product[31:0];
            end
            3'b010 : begin  //mult high bits
                out = product[63:32];
            end
            3'b011 : begin //signed divison overflow
                if (funct3 == md_REM) begin   //
                     out = '0;   //rem is 0
                end else if (funct3 == md_DIV) begin 
                    out = rs1_v;      //quoteint = dividend
                end else begin
                    out = '0;
                end
            end
            3'b100 : begin  //div signed
                if (!div0_tc && (rs2_v != '0)) begin
                    out = quotient_tc;
                end else begin  //divide by 0, quoteint = -1 (s)
                    out = 'hFFFFFFFF;
                end
            end
            3'b101 : begin  //div unsigned
                if (!div0) begin
                    out = quotient;
                end else begin  //divide by 0, quoteint = all 1's (u)
                    out = 'hFFFFFFFF;
                end
            end
            3'b110 : begin //rem of div signed
                if (!div0_tc && (rs2_v != '0)) begin
                    if (rs1_v[RS1_DATA_SIZE-1] == 1) begin
                        if (remainder_tc[RS1_DATA_SIZE-1] != 1) begin
                            out = {1'b1, remainder_tc[RS1_DATA_SIZE-2:0]};
                        end else begin
                            out = remainder_tc;
                        end
                    end
                    else begin
                        out = remainder_tc;
                    end
                end else begin //div by 0, rem = dividend
                        out = rs1_v;
                    end
                end
            3'b111 : begin  //rem of div unsigned
                if (!div0 && (rs2_v != '0)) begin
                    out = remainder;
                end else begin
                    out = rs1_v;
                end
            end
            default : begin
                out = 'hFFFFFFFF;
            end

        endcase
    end

    always_comb begin
        out_inst = rs_out;
        out_inst.rd_data = out;

        out_inst.rfvi_monitor_vals = rs_out.rfvi_monitor_vals;

        out_inst.rfvi_monitor_vals.monitor_rs1_rdata = rs1_v;
        out_inst.rfvi_monitor_vals.monitor_rs2_rdata = rs2_v;
        out_inst.rfvi_monitor_vals.monitor_regf_we = '1;
        out_inst.rfvi_monitor_vals.monitor_rd_wdata = out;
    end


    always_ff @(posedge clk) begin
        if (!rst) begin
            counter <= 0;
            funct_unit_busy <= '0;
        end
        else if (pre_wb_mult_stall) begin
            funct_unit_busy <= '1;
        end
        else if (counter == 2) begin
         
            counter <= 0;
            funct_unit_busy <= '0;
        
        end 
        else if (mult_en | div_en | div_tc) begin
            counter <= counter + 1;
            funct_unit_busy <= '1;
        end
        else begin
            counter <= 0;
            funct_unit_busy <= '0;
        end
        
    end

endmodule : multiply_divide_unit