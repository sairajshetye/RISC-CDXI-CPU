module multiply_divide_unit
import rv32i_types::*;
#(
        parameter INST_SIZE = 3,
        parameter RS1_DATA_SIZE = 32,
        parameter RS2_DATA_SIZE = 32,
        parameter STALL_MODE = 0,
        parameter RESET_MODE = 0,
        parameter ONE = 1,
        parameter ZERO = 0,
        parameter NUM_STAGES = 10

)
(   
    input logic clk, 
    input logic rst,
    input logic flush,
    input dp_is_stage_reg_t rs_out,           //only use inst (change to be just that?)
    //input logic pre_wb_mult_stall,
    //input logic [RS1_DATA_SIZE-1:0] rs1_v,        //rs1 read data
    //input logic [RS2_DATA_SIZE-1:0] rs2_v,        //rs2 read data
    output logic funct_unit_busy,
    output dp_is_stage_reg_t out_inst,
    output logic funct_mult_done
    //output logic [RS1_DATA_SIZE-1:0] out

);  
    logic [2:0] funct3;
    // logic [RS1_DATA_SIZE+RS2_DATA_SIZE-1:0] product;
    logic [65:0] product_mulhsu;
    // logic div_en, mult_en, div_tc, mult_tc;
    logic div_en, mult_en, mult_tc;
    
    // logic div0, div0_tc;
    logic div0;
    // logic [RS1_DATA_SIZE-1:0] quotient, quotient_tc, remainder, remainder_tc;
    // logic [RS1_DATA_SIZE-1:0] quotient, remainder, remainder_tc;
    // logic [RS1_DATA_SIZE-1:0] quotient, remainder;
    logic [32:0] quotient, remainder;
    

    logic [2:0] out_select;
    logic start_sig, end_sig;

    integer counter;

    //logic [RS1_DATA_SIZE-1:0] rs1_v, rs2_v;
    logic [32:0] rs1_v_extended, rs1_v_e;
    logic [32:0] rs2_v_extended, rs2_v_e;
    logic signed [RS1_DATA_SIZE-1:0] rs1_vi, rs2_vi;
    logic [RS1_DATA_SIZE-1:0] out;

    logic new_inst, overflow;

    dp_is_stage_reg_t rs_reg;
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
    

    always_ff @(posedge clk) begin
        if (!rst || flush) begin
            funct3 <= '0;
            //rs1_vi <= '0;
            //rs2_vi <= '0;
            rs_reg <= '0;
            new_inst <= '1;
            rs1_v_e <= '0;
            rs2_v_e <= '0;
        
        end else if (rs_out.valid && !funct_mult_done && (rs_reg != rs_out)) begin
            funct3 <= rs_out.funct3;
            rs1_v_e <= {rs_out.rs1_data[31], rs_out.rs1_data};  
            rs2_v_e <= {rs_out.rs2_data[31], rs_out.rs2_data};  
            //rs1_vi <= signed'(rs_out.rs1_data);
            //rs2_vi <= signed'(rs_out.rs2_data);
            rs_reg <= rs_out;
            new_inst <= '0;
            
        end else if (funct_mult_done) begin
            funct3 <= '0;
            //rs1_vi <= '0;
            //rs2_vi <= '0;
            rs_reg <= '0;
            rs1_v_e <= '0;
            rs2_v_e <= '0;
            new_inst <= '1;
        end
    end

    always_comb begin
        if (rs_out.valid && !funct_mult_done && (rs_reg != rs_out)) begin
            funct_unit_busy <= '1;
        end else if (funct_mult_done || new_inst) begin
            funct_unit_busy <= '0;
        end else begin
            funct_unit_busy <= '1;
        end
    end

    always_comb begin
        rs1_v_extended = '0;
        rs2_v_extended = '0;
        if (!rs_reg.valid) begin
            mult_en = '0;
            mult_tc = '0;
            div_en = '0;
            // div_tc = '0;
            out_select = 3'b000;
            overflow = '0;

            //rs1_v = '0;
            //rs2_v = '0;
        end else begin 
            overflow = '0;
            rs1_v_extended = rs1_v_e;
            rs2_v_extended = rs2_v_e;
            //rs1_v = unsigned'(rs1_vi);
            //rs2_v = unsigned'(rs2_vi);
        unique case (funct3)
            md_MUL : begin      //MUL, signed x signed
                rs1_v_extended = rs1_v_e;
                rs2_v_extended = rs2_v_e;

                //rs1_v = signed'(rs1_vi);
                //rs2_v = signed'(rs2_vi);
                mult_en = '1;
                mult_tc = '1;
                div_en = '0;
                // div_tc = '0;
                out_select = 3'b001;
            end
            md_MULH : begin      //MUL High, signed x signed
                rs1_v_extended = rs1_v_e;
                rs2_v_extended = rs2_v_e;
                //rs1_v = signed'(rs1_vi);
                //rs2_v = signed'(rs2_vi);
                mult_en = '1;
                mult_tc = '1;
                div_en = '0;
                // div_tc = '0;
                out_select = 3'b010;
            end
            md_MULHSU : begin      //MUL High (S)(U), signed x unsigned
                //rs1_v = signed'(rs1_vi);
                //rs2_v = unsigned'(rs2_vi);
                mult_en = '1;
                mult_tc = '1;   //?
                div_en = '0;
                // div_tc = '0;
                out_select = 3'b010;
                rs1_v_extended = rs1_v_e;
                rs2_v_extended = {1'b0, rs2_v_e[31:0]};
            end
            md_MULHU : begin      //MUL High (U), unsigned x unisgned
                rs1_v_extended = {1'b0, rs1_v_e[31:0]};
                rs2_v_extended = {1'b0, rs2_v_e[31:0]};
                //rs1_v = unsigned'(rs1_vi);
                //rs2_v = unsigned'(rs2_vi);
                mult_en = '1;
                mult_tc = '0;
                div_en = '0;
                // div_tc = '0;
                out_select = 3'b010;
            end
            md_DIV : begin      //DIV
                rs1_v_extended = rs1_v_e;
                rs2_v_extended = rs2_v_e;
                //rs1_v = signed'(rs1_vi);
                //rs2_v = signed'(rs2_vi);
                //(signed'(rs2_v_e[31:0]) == signed'(-32'b1)) && (signed'(rs1_v_e[31:0]) == signed'(-'d2147483648))
                //(rs2_v_e[31:0] == -32'b1) && (rs1_v_e[31:0] == -'d2147483648)
                if ((rs2_v_e[31:0] == -32'b1) && (rs1_v_e[31:0] == -'d2147483648)) begin //signed overflow
                    mult_en = '0;
                    mult_tc = '0;
                    // div_en = '0;
                    // div_tc = '1;
                    div_en = '1;

                    out_select = 3'b100;
                    overflow = '1;
                    
                
                end else begin
                    mult_en = '0;
                    mult_tc = '0;
                    // div_en = '0;
                    // div_tc = '1;
                    div_en = '1;

                    out_select = 3'b100;
                end
            end
            md_DIVU : begin      //DIV (U)
                rs1_v_extended = {1'b0, rs1_v_e[31:0]};
                rs2_v_extended = {1'b0, rs2_v_e[31:0]};
                //rs1_v = unsigned'(rs1_vi);
                //rs2_v = unsigned'(rs2_vi);
                mult_en = '0;
                mult_tc = '0;
                div_en = '1;
                // div_tc = '0;
                out_select = 3'b101;
            end
            md_REM : begin      //Remainder
                rs1_v_extended = rs1_v_e;
                rs2_v_extended = rs2_v_e;
                //rs1_v = signed'(rs1_vi);
                //rs2_v = signed'(rs2_vi);
                if ((rs2_v_e[31:0] == -32'b1) && (rs1_v_e[31:0] == -'d2147483648)) begin //signed overflow
                    mult_en = '0;
                    mult_tc = '0;
                    // div_en = '0;
                    // div_tc = '1;
                    div_en = '1;

                    out_select = 3'b110;
                    overflow = '1;
                end else begin
                    mult_en = '0;
                    mult_tc = '0;
                    // div_en = '0;
                    // div_tc = '1;
                    div_en = '1;

                    out_select = 3'b110;
                end
            end
            md_REMU : begin      //Remainder (U)
                rs1_v_extended = {1'b0, rs1_v_e[31:0]};
                rs2_v_extended = {1'b0, rs2_v_e[31:0]};
                //rs1_v = unsigned'(rs1_vi);
                //rs2_v = unsigned'(rs2_vi);
                mult_en = '0;
                mult_tc = '0;
                div_en = '1;
                // div_tc = '0;
                out_select = 3'b111;
            end
            default : begin
                //rs1_v = '0;
                //rs2_v = '0;
                mult_en = '0;
                mult_tc = '0;
                div_en = '0;
                // div_tc = '0;
                rs1_v_extended = '0;
                rs1_v_extended = '0;
                out_select = '0;
            end
        endcase
        end

    end
    // DW_mult_pipe #(
    //     .a_width(RS1_DATA_SIZE), 
    //     .b_width(RS2_DATA_SIZE), 
    //     .num_stages(NUM_STAGES),
    //     .rst_mode(RESET_MODE)
    //     ) mult (
    //     .clk(clk), 
    //     .rst_n(rst), //active low
    //     .en(mult_en),    //enable
    //     .tc(mult_tc),   //two's complement 
    //     .a(rs1_v_extended[31:0]),
    //     .b(rs2_v_extended[31:0]), 
    //     .product(product) 

    // );

    DW_mult_pipe #(
        .a_width(33), 
        .b_width(33), 
        .num_stages(NUM_STAGES),
        .rst_mode(RESET_MODE),
        .stall_mode(STALL_MODE)
    ) mult_mulhsu (
        .clk(clk), 
        .rst_n('0), //active low
        .en(mult_en),    //enable
        .tc(mult_tc),   //two's complement 
        .a(rs1_v_extended),
        .b(rs2_v_extended), 
        .product(product_mulhsu) 

    );

    DW_div_pipe #(
        .a_width(33), 
        .b_width(33), 
        .tc_mode(ONE),      //two's complement 
        .num_stages(NUM_STAGES),
        .rst_mode(RESET_MODE),
        .stall_mode(STALL_MODE)
    ) div (
        .clk(clk),
        .rst_n('0),    //active low
        .en(div_en),     //enable
        .a(rs1_v_extended),
        .b(rs2_v_extended),
        .quotient(quotient),
        .remainder(remainder),
        .divide_by_0(div0)
    );

    // DW_div_pipe #(
    //     .a_width(RS1_DATA_SIZE), 
    //     .b_width(RS2_DATA_SIZE), 
    //     .tc_mode(ZERO),      //two's complement 
    //     .num_stages(NUM_STAGES),
    //     .rst_mode(RESET_MODE)
    // ) div (
    //     .clk(clk),
    //     .rst_n(rst),    //active low
    //     .en(div_en),     //enable
    //     .a(rs1_v_extended[31:0]),
    //     .b(rs2_v_extended[31:0]),
    //     .quotient(quotient),
    //     .remainder(remainder),
    //     .divide_by_0(div0)
    // );

    // DW_div_pipe #(
    //     .a_width(RS1_DATA_SIZE), 
    //     .b_width(RS2_DATA_SIZE), 
    //     .tc_mode(ONE),      //two's complement 
    //     .num_stages(NUM_STAGES),
    //     .rst_mode(RESET_MODE)
    // ) div_signed (
    //     .clk(clk),
    //     .rst_n(rst),    //active low
    //     .en(div_tc),     //enable
    //     .a(rs1_v_extended[31:0]),
    //     .b(rs2_v_extended[31:0]),
    //     .quotient(quotient_tc),
    //     .remainder(remainder_tc),
    //     .divide_by_0(div0_tc)
    // );

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
            3'b001 : begin  //mult low bits, signed
                out = product_mulhsu[31:0];
            end
            3'b010 : begin  //mult high bits
            if (funct3 == md_MULHSU) begin
                out = product_mulhsu[63:32];
            end
            else begin
                out = product_mulhsu[63:32];
            end
            end
            3'b011 : begin //signed divison overflow
                if (funct3 == md_REM) begin   //
                     out = '0;   //rem is 0
                end else if (funct3 == md_DIV) begin 
                    out = rs1_v_extended[31:0];      //quoteint = dividend
                end else begin
                    out = '0;
                end
            end
            3'b100 : begin  //div signed
                if (!div0 && !overflow) begin
                    // if ((rs1_v_extended[32] == 1'b1) && (rs2_v_extended[32] == 1'b1)) begin
                    //     out = {1'b0, quotient_tc[30:0]};
                    // end else if ((rs1_v_extended[32] == 1'b0) && (rs2_v_extended[32] == 1'b0)) begin
                    //     out = {1'b0, quotient_tc[30:0]};
                    //  end else if ((quotient_tc != '0)) begin
                    //     out = {1'b1, quotient_tc[30:0]};
                    // end else begin
                    //     out = quotient_tc[31:0];
                    // end
                    out = quotient[31:0];
                end else if (overflow) begin
                    out = rs1_v_extended[31:0];      //quoteint = dividend
                end
                
                else begin  //divide by 0, quoteint = -1 (s)
                    out = 'hFFFFFFFF;
                end
            end
            3'b101 : begin  //div unsigned
                if (!div0) begin
                    out = quotient[31:0];
                end else begin  //divide by 0, quoteint = all 1's (u)
                    out = 'hFFFFFFFF;
                end
            end
            3'b110 : begin //rem of div signed
                if (overflow) begin
                        out = '0;   //rem is 0
                    end
                else if (!div0) begin
                    if (remainder != '0) begin
                        // if ((rs1_v_extended[32] == 1'b1)) begin
                        //     out = {1'b1, remainder_tc[30:0]};
                        // end else begin
                        //     out = {1'b0, remainder_tc[30:0]};
                        // end
                        out = remainder[31:0];
                    end
                    else begin
                        out = remainder[31:0];
                    end
                end else begin //div by 0, rem = dividend
                        out = rs1_v_extended[31:0];
                    end
                end
            3'b111 : begin  //rem of div unsigned
                if (!div0 && (rs2_v_extended != '0)) begin
                    out = remainder[31:0];
                end else begin
                    out = rs1_v_extended[31:0];
                end
            end
            default : begin
                out = 'hFFFFFFFF;
            end

        endcase
    end

     always_comb begin
        if (!rst || flush) begin
            out_inst = '0;
            out_inst.rfvi_monitor_vals = '0;
        end else if (rs_reg.valid && (funct_mult_done) ) begin
            out_inst = rs_reg;
            out_inst.rfvi_monitor_vals = rs_reg.rfvi_monitor_vals;

            out_inst.rd_data = out;

            out_inst.rfvi_monitor_vals.monitor_rd_wdata = out;
            
            out_inst.rfvi_monitor_vals.monitor_rs1_rdata = rs1_v_e[31:0]; //rs1_v;

            out_inst.rfvi_monitor_vals.monitor_rs2_rdata = rs2_v_e[31:0]; // rs2_v;
            out_inst.rfvi_monitor_vals.monitor_regf_we = '1;

        end else begin
            out_inst = '0;
            out_inst.rfvi_monitor_vals = '0;
        end

    end 


    always_ff @(posedge clk) begin
        //funct_mult_done = '0;
        if (!rst || flush) begin
            counter <= 0;
            //funct_unit_busy <= '0;
            //done <= '0;
            funct_mult_done <= '0;
            
            //out_inst <= '0;
            //out_inst.rfvi_monitor_vals <= '0;
        end
        else begin
        //if (rs_out.valid && !done) begin
        //if (new_inst) begin
        //    funct_unit_busy <= '1;
        //end
        //out_inst <= '0;
        //out_inst.rfvi_monitor_vals <= '0;
        //end
        //if (pre_wb_mult_stall) begin
            //funct_unit_busy <= '1;
          //  funct_mult_done <= '0;
       // end
        if ((counter == NUM_STAGES)) begin
         
            counter <= 0;
            //funct_unit_busy <= '0;
            funct_mult_done <= '1;

           
        
        end 
        else if (mult_en | div_en) begin
            counter <= counter + 1;
            //funct_unit_busy <= '1;
            funct_mult_done <= '0;

            
            
        end
        //if ()
        //else if (rs_out.valid) begin
        //    counter <= counter + 1;
        //    funct_unit_busy <= '1;
        //end
        

        end
        
    end



endmodule : multiply_divide_unit