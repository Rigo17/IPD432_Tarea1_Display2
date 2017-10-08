`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2017 22:38:25
// Design Name: 
// Module Name: Number_2_7S
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


module Number_2_7S(
    input [3:0] numero_decimal,
    output reg [6:0] numero_7s
);

    always_comb begin
        case(numero_decimal)
        4'd0:numero_7s = 7'b0000_001;//0
        4'd1:numero_7s = 7'b1001_111;//1
        4'd2:numero_7s = 7'b0010_010;//2
        4'd3:numero_7s = 7'b0000_110;//3
        4'd4:numero_7s = 7'b1001_100;//4
        4'd5:numero_7s = 7'b0100_100;//5
        4'd6:numero_7s = 7'b0100_000;//6
        4'd7:numero_7s = 7'b0001_111;//7
        4'd8:numero_7s = 7'b0000_000;//8
        4'd9:numero_7s = 7'b0001_100;//9
        default: numero_7s = 7'b1111_110;//-
        endcase
    end
endmodule
