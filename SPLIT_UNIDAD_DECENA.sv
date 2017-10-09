`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2017 22:20:29
// Design Name: 
// Module Name: SPLIT_UNIDAD_DECENA
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


module SPLIT_UNIDAD_DECENA(
input [5:0] numero,
output reg [3:0] unidad,
                 decena
    );
reg [1:0] basura;
always_comb begin
    if(numero<10)      begin {basura,unidad}=numero;    decena = 4'd0; end
    else if(numero<20) begin {basura,unidad}=numero-10; decena = 4'd1; end
    else if(numero<30) begin {basura,unidad}=numero-20; decena = 4'd2; end
    else if(numero<40) begin {basura,unidad}=numero-30; decena = 4'd3; end
    else if(numero<50) begin {basura,unidad}=numero-40; decena = 4'd4; end
    else if(numero<60) begin {basura,unidad}=numero-50; decena = 4'd5; end
    else               begin {basura,unidad}=6'b0; decena=4'd0; end
end
endmodule
