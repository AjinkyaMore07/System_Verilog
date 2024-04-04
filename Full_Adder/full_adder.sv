`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2024 02:09:25 PM
// Design Name: 
// Module Name: full_adder
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
typedef struct {
                logic a,b,cin;
               
                }adder;
typedef struct {
                  logic sum,carry;
                }adder_ouy;                

module full_adder(input adder fa, 
                   output adder_ouy faout);
assign  {faout.carry,faout.sum} = fa.a+fa.b+fa.cin;
/*
always @(*)
    begin
       
    end*/
endmodule
