`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2017 18:45:07
// Design Name: 
// Module Name: TOP_MODULE
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


module TOP_MODULE(
    input CLK100MHZ,
    input SW,
    output [7:0] AN,
    output CA,CB,CC,CD,CE,CF,CG, DP,
    output LED
    );
    assign DP = 1'b1;
    wire [5:0] horas,
              minutos,
              segundos;
    reg [5:0] horas_display;
    wire clk_display, clk_segundos;
    
    
    always_comb begin
        if(SW && (horas > 12))horas_display = horas -12;
        else                  horas_display = horas;
    end
    assign LED = (horas >= 12) && SW;
    
    Clock_Divisor #(1)Frec_segundos(.CLK100MHZ(CLK100MHZ),.clk(clk_segundos));
    Watch Watch(.clk(clk_segundos),.horas(horas),.minutos(minutos),.segundos(segundos));
    
    Clock_Divisor #(500)Frec_display(.CLK100MHZ(CLK100MHZ),.clk(clk_display));
    HORA_DISPLAY HORA_DISPLAY1(.clk(clk_display),.AN(AN),.CATHODES({CA,CB,CC,CD,CE,CF,CG}),.horas(horas_display),.minutos(minutos),.segundos(segundos));
endmodule
