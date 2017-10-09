`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2017 12:15:41
// Design Name: 
// Module Name: Clock_Divisor
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


module Clock_Divisor #(parameter frecuencia = 1)
(
    input CLK100MHZ,
    output reg clk
);

    //parameter [10:0] frecuencia=11'd2000; //frecuenca en Hz
    reg [26:0] cnt=27'd0, cnt_next;
    wire [26:0] max_cnt;
    assign max_cnt = (27'd100_000_000) /(frecuencia * 2);
    
    always_ff @(posedge CLK100MHZ)begin
        if(cnt == max_cnt) clk <= ~clk;
        if(cnt == max_cnt) cnt <= 26'd1;
        else cnt <= cnt + 26'd1;
    end
    /*
    always_ff @(posedge CLK100MHZ)begin
        cnt <= cnt_next;
    end
    
    always_comb begin
        cnt_next = cnt + 26'd1;
        if (cnt_next == max_cnt+26'd1) cnt_next = 26'd1;
    end
    
    always_ff @(posedge CLK100MHZ)begin
        if(cnt == max_cnt) clk <= ~clk;
    end
    */
endmodule
