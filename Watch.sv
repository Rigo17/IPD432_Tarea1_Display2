`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2017 12:49:14
// Design Name: 
// Module Name: Watch
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Watch(
    input clk,
    output reg [5:0] horas = 6'd23,
                     minutos = 6'd58,
                     segundos = 6'd00
);
    reg [5:0] horas_nxt,
              minutos_nxt,
              segundos_nxt;
    always_comb begin
        if(segundos < 6'd59) begin segundos_nxt = segundos + 6'd1; 
                                   minutos_nxt = minutos; 
                                   horas_nxt = horas; end
        else                 begin segundos_nxt = 6'd0;
                                   minutos_nxt = (minutos<59) ? minutos+1 : 6'd0;
                                   horas_nxt = (minutos<59) ? horas : ((horas<23)? horas+1: 6'd0 );end 
    end
    
    always_ff @(posedge clk) begin
        segundos <= segundos_nxt;
        minutos  <= minutos_nxt;
        horas    <= horas_nxt;
    end
endmodule
