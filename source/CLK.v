`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/30 18:48:48
// Design Name: 
// Module Name: CLK
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


module CLK(
//ϵͳ�ӿ�
    input           sys_clk  ,      //ϵͳ����ʱ��
    input           sys_rst_n,      //��λ�źţ��͵�ƽ��Ч  
    output       DCLK_MBI5353,           //MBI535��DCLK
    output   reg    DCLK_SPI  ,      //SPI_drive��DCLK
    output       DCLK_MBI5353_R
    );
    
    reg [2:0] fre_cnt_D;                 //DCLK��Ƶϵ������ʵ�ʵ�DCLK����ϵ��С
    reg [3:0] fre_cnt_SPI;              //SPI���������DCLK

DCLK u_DCLK(
  .clkin1(sys_clk),        // input
  .pll_lock(),    // output
  .clkout0(DCLK_MBI5353),      // output
  .clkout1(DCLK_MBI5353_R)       // output
);

   
/*
    //DCLK��Ƶ4��Ƶ
always@(posedge sys_clk or negedge sys_rst_n)
begin
    if(!sys_rst_n)begin
        fre_cnt_D <= 0;
        DCLK_MBI5353 <= 0;
        DCLK_MBI5353_R <= 1;
    end
    else if(fre_cnt_D == 1)begin
            DCLK_MBI5353 <= ~DCLK_MBI5353;
            DCLK_MBI5353_R <=  ~DCLK_MBI5353_R;
            fre_cnt_D <= 0;
         end
    else begin
            fre_cnt_D <= fre_cnt_D + 1;
         end
end

*/

always@(posedge sys_clk or negedge sys_rst_n)
begin
    if(!sys_rst_n)begin
        fre_cnt_SPI <= 0;
        DCLK_SPI <= 0;
        DCLK_SPI <= 0;
    end
    else if(fre_cnt_SPI == 3)begin
            DCLK_SPI <=~DCLK_SPI;
            fre_cnt_SPI <= 0;
         end
    else begin
            fre_cnt_SPI <= fre_cnt_SPI + 1;
         end
end
endmodule
