`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2017 01:51:20
// Design Name: 
// Module Name: Watch2
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


module Watch2(
    input clk_100,
    input btn1,btn2,
    output reg [4:0] horas=12,
    output reg [5:0] minutos=12,
                     segundos=50
);

    parameter T1 = 28'd100_000_000,
              T2 = 28'd50_000_000;
              
    reg [27:0] cnt1 = 28'd0,
               cnt2 = 28'd0,
               cnt  = 28'd0;
    reg [4:0] horas_nxt;
    reg [5:0] minutos_nxt,
              segundos_nxt;
               
    
    always_comb begin
        if(cnt==T1) segundos_nxt = (segundos<59) ? segundos +1 : 6'd0;
        else        segundos_nxt = segundos;
    
        if (cnt1 == 1)                         minutos_nxt = (minutos<59) ? minutos+1 : 6'd0;
        else if (cnt1 == T1)                   minutos_nxt = (minutos<59) ? minutos+1 : 6'd0;
        else if ((segundos == 59) && cnt ==T1) minutos_nxt = (minutos<59) ? minutos+1 : 6'd0;
        else                                   minutos_nxt = minutos;
        
        if (cnt2 == 1)                                            horas_nxt =(horas<23) ? horas+1 : 5'd0;
        else if (cnt2 == T1)                                      horas_nxt= (horas<23) ? horas+1 : 5'd0;
        else if  ((minutos ==59) && (segundos == 59) && cnt ==T1) horas_nxt= (horas<23) ? horas+1 : 5'd0;
        else                                                      horas_nxt = horas;    
    end
    
    always_ff @(posedge clk_100) begin
        segundos <= segundos_nxt;
        minutos  <= minutos_nxt;
        horas    <= horas_nxt;
    end
    
    always_ff @(posedge clk_100) begin
       if (cnt <= T1) cnt <= cnt +1;
       else           cnt <= 0; 
       
       if(btn1 && (cnt1 <= T1))      cnt1 <= cnt1 + 1;
       else if (btn1 && (cnt1 > T1)) cnt1 <= cnt1 - T2;
       else                          cnt1 <= 0;
       
       if(btn2 && (cnt2 <= T1))     cnt2 <= cnt2 + 1;
       else if (btn2 && (cnt2 > T1))cnt2 <= cnt2 - T2;
       else                         cnt2 <= 0;                               
    end
    
endmodule
