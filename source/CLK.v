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
//系统接口
    input           sys_clk  ,      //系统输入时钟
    input           sys_rst_n,      //复位信号，低电平有效  
    output       DCLK_MBI5353,           //MBI535的DCLK
    output   reg    DCLK_SPI  ,      //SPI_drive的DCLK
    output       DCLK_MBI5353_R
    );
    
    reg [2:0] fre_cnt_D;                 //DCLK分频系数，比实际的DCLK分配系数小
    reg [3:0] fre_cnt_SPI;              //SPI驱动传输的DCLK

DCLK u_DCLK(
  .clkin1(sys_clk),        // input
  .pll_lock(),    // output
  .clkout0(DCLK_MBI5353),      // output
  .clkout1(DCLK_MBI5353_R)       // output
);

   
/*
    //DCLK分频4分频
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
