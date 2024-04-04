`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2024 02:12:30 PM
// Design Name: 
// Module Name: tb_full_adder
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
/*

module tb_full_adder;
logic a,b,cin;
logic sum,carry;

full_adder dut(a,b,cin,sum,carry);
initial begin
 integer i;
 for(i=0;i<10;i++)
    begin
        #20 //{a,b,cin} = $urandom_range(0,1);
         {a,b,cin} = i;
    end
 $monitor(" a = %0b , b = %0b , cin = %0b , sum = %0b , carry= %0b " , a,b,cin,sum,carry);
 #10 $finish;
end
endmodule*/


module tb_full_adder;

adder fa;
adder_ouy faout;
full_adder dut(.*);
initial begin
 integer i;
 for(i=0;i<10;i++)
    begin
        #20 //{a,b,cin} = $urandom_range(0,1);
         {fa.a,fa.b,fa.cin} = i;
    end
 $monitor(" a = %0b , b = %0b , cin = %0b , sum = %0b , carry= %0b " , fa.a,fa.b,fa.cin,faout.sum,faout.carry);
 #10 $finish;
end
endmodule
