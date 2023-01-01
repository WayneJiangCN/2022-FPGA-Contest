`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/07 15:21:32
// Design Name: 
// Module Name: sys_clk
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


module sys_clk(
//ϵͳ�ӿ�
    input           sys_clk  ,      //ϵͳ����ʱ��
    input           sys_rst_n,      //��λ�źţ��͵�ƽ��Ч  
    output reg      clk
    );
    
    reg [5:0] cnt;
always@(posedge sys_clk or negedge sys_rst_n)
begin
    if(!sys_rst_n)begin
        cnt <= 0;
        clk <= 0;
    end
//    else if(cnt == 1)begin
    else begin
            clk <= ~clk;
            cnt <= 0;
    end
//    else begin
//            cnt <= cnt + 1;
//    end
end
endmodule
