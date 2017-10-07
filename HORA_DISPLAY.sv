`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2017 18:50:30
// Design Name: 
// Module Name: HORA_DISPLAY
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


module HORA_DISPLAY(
    input clk,
    input [5:0] horas,
                minutos,
                segundos,
    output [7:0] AN,
    //output CA,CB,CC,CD,CE,CF,CG
    output [6:0] CATHODES
    );
    parameter [7:0] D0=8'b1111_1110,
                    D1=8'b1111_1101,
                    D2=8'b1111_1011,
                    D3=8'b1111_0111,
                    D4=8'b1110_1111,
                    D5=8'b1101_1111,
                    D6=8'b1011_1111,
                    D7=8'b0111_1111;
    reg [7:0] actual_digit, nxt_digit;
    reg [6:0] digit;
        
    always_ff @(posedge clk) begin
        actual_digit <= nxt_digit;
    end
    
    always_comb begin
        case(actual_digit)
            D0: nxt_digit = D1;
            D1: nxt_digit = D2;
            D2: nxt_digit = D3;
            D3: nxt_digit = D4;                      
            D4: nxt_digit = D5;
            D5: nxt_digit = D6;
            D6: nxt_digit = D7;
            D7: nxt_digit = D0;
            default: nxt_digit = D0;
         endcase
    end 
    
    
    wire [3:0] unidad_segundo_decimal,
              decena_segundo_decimal,
              unidad_minuto_decimal,
              decena_minuto_decimal,
              unidad_hora_decimal,
              decena_hora_decimal;
    wire [6:0] unidad_segundo_7s,
              decena_segundo_7s,
              unidad_minuto_7s,
              decena_minuto_7s,
              unidad_hora_7s,
              decena_hora_7s;
    
    SPLIT_UNIDAD_DECENA seg(segundos,unidad_segundo_decimal,decena_segundo_decimal);
    SPLIT_UNIDAD_DECENA min(minutos,unidad_minuto_decimal,decena_minuto_decimal);
    SPLIT_UNIDAD_DECENA hor(horas,unidad_hora_decimal,decena_hora_decimal);
    
    Number_2_7S seg1(unidad_segundo_decimal,unidad_segundo_7s);
    Number_2_7S seg2(decena_segundo_decimal,decena_segundo_7s);
    Number_2_7S min1(unidad_minuto_decimal,unidad_minuto_7s);
    Number_2_7S min2(decena_minuto_decimal,decena_minuto_7s);
    Number_2_7S hr1(unidad_hora_decimal,unidad_hora_7s);
    Number_2_7S hr2(decena_hora_decimal,decena_hora_7s);
    always_comb begin
        case(actual_digit)
            D0: digit = unidad_segundo_7s;
            D1: digit = decena_segundo_7s;
            D2: digit = unidad_minuto_7s;
            D3: digit = decena_minuto_7s;
            D4: digit = unidad_hora_7s;
            D5: digit = decena_hora_7s;
            D6: digit = 7'b1111_111;
            D7: digit = 7'b1111_111;
            default: digit =7'b0011_100;//o
        endcase
    end
    
    
    assign AN=actual_digit;
    //assign {CA,CB,CC,CD,CE,CF,CG}= digit;
    assign CATHODES = digit;
endmodule
