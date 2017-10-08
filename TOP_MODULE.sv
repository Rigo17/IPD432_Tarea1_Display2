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
    input BTNL, BTNR,
    output [7:0] AN,
    output CA,CB,CC,CD,CE,CF,CG, DP,
    output LED
    );
    parameter display_point = 1;
    assign DP = display_point;
    
    wire [4:0] horas;
    wire [5:0] minutos,
               segundos;
    reg [4:0] horas_display;
    wire clk_display;
    
           
    Watch2 Watch(.horas(horas),.minutos(minutos),.segundos(segundos),.clk_100(CLK100MHZ),.btn1(BTNR),.btn2(BTNL));
        
    always_comb begin
        if(SW && (horas > 12))horas_display = horas -12;
        else                  horas_display = horas;
    end
    
    assign LED = (horas > 12) && SW;
        
    Clock_Divisor #(500)Frec_display(.CLK100MHZ(CLK100MHZ),.clk(clk_display));
    HORA_DISPLAY HORA_DISPLAY1(.clk(clk_display),.AN(AN),.CATHODES({CA,CB,CC,CD,CE,CF,CG}),.horas({1'b0,horas_display}),.minutos(minutos),.segundos(segundos));
    

endmodule
