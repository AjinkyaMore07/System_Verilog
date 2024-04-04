`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2024 01:15:46 PM
// Design Name: 
// Module Name: dualportmem
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
                  logic [7:0] data;
                  logic [1024:0] address;
                  logic wr_en;
                  logic chipselect;
                  logic outenable;
                  logic clk;
                  } port_in;
typedef struct {
                  reg [7:0] dataout;
               } port_out;
               
module dualportmem (
                    input port_in port_A ,
                    input port_in port_B ,
                    output port_out out_A,
                    output port_out out_B);
                    
logic [0:7] mem [0:1024];
/*
always_ff @(posedge port_A.clk , negedge port_A.reset) begin
    if(port_A.reset)
        begin
            mem[port_A.address] <= 0; 
        end
     else
        begin
            if(port_A.chipselect & port_A.wr_en )
                mem[port_A.address] <= port_A.data;
            else if (port_A.chipselect & !port_A.wr_en & port_A.outenable)
                out_A.dataout <= mem[port_A.address];
        end
end

always_ff @(posedge port_B.clk , negedge port_B.reset) begin
    if(port_B.reset)
        begin
            mem[port_B.address] <= 0; 
        end
     else
        begin
            if(port_B.chipselect & port_B.wr_en)
                mem[port_B.address] <= port_B.data;
            else if (port_B.chipselect & !port_B.wr_en & port_B.outenable)
                out_B.dataout <= mem[port_B.address];
        end
end*/


always_ff @(posedge port_A.clk) //
    begin
        if(port_A.chipselect & port_A.wr_en)
            mem[port_A.address] <= port_A.data;  
    end
    
always_ff @(posedge port_A.clk) //
    begin
  
       if (port_A.chipselect & !port_A.wr_en & port_A.outenable)
            out_A.dataout <= mem[port_A.address];       
    end



always_ff @(posedge port_B.clk) //
    begin
        if(port_B.chipselect & port_B.wr_en)
            mem[port_B.address] <= port_B.data;  
    end
    
always_ff @(posedge port_B.clk) //
    begin
  
       if (port_B.chipselect & !port_B.wr_en & port_B.outenable)
            out_B.dataout <= mem[port_B.address];       
    end
endmodule
