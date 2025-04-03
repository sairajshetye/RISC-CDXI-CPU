module multiply_divide_unit
import rv32i_types::*;

(   
    input logic clk, 
    input logic rst,
    input logic [31:0] op1,
    input logic [31:0] op2,

    output logic [63:0] product

);
    assign one = '1;
    assign zero = '0;
    DW_mult_pipe #(
        .a_width(32), 
        .b_width(32), 
        .rst_mode(0)
        ) mult (
        
        .clk(clk), 
        .rst_n(rst), //active low
        .en(one),    //enable
        .tc(zero),   //two's complement 
        .a(op1),
        .b(op2), 
        .product(product) 

    );

endmodule 

