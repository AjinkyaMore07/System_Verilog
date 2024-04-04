`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2024 01:47:10 PM
// Design Name: 
// Module Name: tb_dual_port_ram
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


module tb_dual_port_ram();
 port_in port_A;
 port_in port_B;
 port_out out_A;
 port_out out_B;
 
 dualportmem dut(.*);
 
 parameter clock_A = 10;
 parameter clock_B = 20;
 
 always #(clock_A/2) port_A.clk <= ~port_A.clk; 
 always #(clock_B/2) port_B.clk <= ~port_B.clk; 
 
 task clock_init;
    begin
            port_A.clk<=0;
            port_B.clk<=0;
    end
 endtask
 
  task data_init;
    begin
            port_A.data<=0;
            port_B.data<=0;
    end
 endtask
 
  task chipselect_init;
    begin
            port_A.chipselect<=0;
            port_B.chipselect<=0;
    end
 endtask
 
  task outenable_init;
    begin
            port_A.outenable<=0;
            port_B.outenable<=0;
    end
 endtask
 
  task wr_init;
    begin
            port_A.wr_en=0;
            port_B.wr_en=0;
    end
 endtask
 
 integer i;
 
 
 task datawrite_A;
    begin
        @(posedge  port_A.clk) port_A.chipselect=1;
                               port_A.wr_en=1; 
        for(i=0;i<10;i++)  
            begin
                @(posedge  port_A.clk) port_A.address=i;
                                       port_A.data=$urandom_range(1,80);
            end
    end
 endtask
 
 task dataread_A;
    begin
        @(posedge  port_A.clk) port_A.chipselect=1;
                               port_A.wr_en=0; 
                               port_A.outenable=1;
        for(i=0;i<10;i++)  
            begin
                @(posedge  port_A.clk) port_A.address=i;
            end
    end
 endtask
 
 
  task datawrite_B;
    begin
        @(posedge  port_B.clk) port_B.chipselect=1;
                               port_B.wr_en=1; 
        for(i=10;i<20;i++)  
            begin
               @(posedge  port_B.clk) port_B.address=i;
                port_B.data=$urandom_range(0,90);
            end
    end
 endtask
 
 task dataread_B;
    begin
        @(posedge  port_B.clk) port_B.chipselect=1;
                               port_B.wr_en=0; 
                               port_B.outenable=1;
        for(i=11;i<20;i++)  
            begin
              @(posedge  port_B.clk)  port_B.address=i;
            end
    end
 endtask
 
initial begin
    clock_init;
    data_init;
    chipselect_init;
    outenable_init;
    wr_init;
    
    #10;
    
    datawrite_A;
    
    #10;
    
    dataread_A;
    
    outenable_init;
    
    #10;
    
    datawrite_B;
    
    #10;
    
    dataread_B;
    
  #10 $finish;
end
 
initial begin
    $monitor(" port_A.clk = %0d ,  port_A.chipselect = %0d , port_A.wr_en = %0d , port_A.outenable = %0d , port_A.address = %0d , port_A.data = %0d , port_A.dataout = %0d " ,port_A.clk , port_A.chipselect , port_A.wr_en , port_A.outenable, port_A.address ,port_A.data , out_A.dataout );
    $monitor(" port_B.clk = %0d ,  port_B.chipselect = %0d , port_B.wr_en = %0d , port_B.outenable = %0d , port_B.address = %0d , port_B.data = %0d , port_B.dataout = %0d " ,port_B.clk , port_B.chipselect , port_B.wr_en , port_B.outenable, port_B.address ,port_B.data , out_B.dataout );
end
endmodule
