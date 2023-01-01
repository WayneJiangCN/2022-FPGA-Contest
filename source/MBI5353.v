`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/19 17:45:38
// Design Name: 
// Module Name: MBI5353
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
//灰度数据通过引脚"SDI和SDO"发送，命令由引脚"LE"和"DCLK"组成

module MBI5353(
//系统接口
    input           sys_clk  ,      //系统输入时钟
    input           sys_rst_n,      //复位信号，低电平有效   
//用户控制引脚
    output  reg      GCLK    ,       //全局时钟（相当于spi的clk，连接spi驱动的时钟）
    input             DCLK_LE    ,       //像素时钟
    input             DCLK_data,      //
    output  reg      LE      ,       //命令控制引脚
    input           o_dataen,      //输出使能信号
//用户接口
//    input   [7:0]  data_input  ,   //ddr发送过来的数据
    output  reg     send_done,      //主机发送一个字节结束标志
    output  reg     spi_start,      //发送传输开始信号，一个高电平
    output  reg     spi_end  ,      //发送传输结束信号，一个高电平
    output  reg     spi_mosi,       //数据传输
    output  reg  [47:0] data_send,   //要发送的数据
//    output  reg  [47:0] data_store,   //要发送的数据
    output  reg  [2:0]  line,         //当前行数
    
    input        [7:0]  fifo_dout ,  // 从FIFO读出的数据
    input               almost_full ,// FIFO将满信号
    input               almost_empty,// FIFO将空信号
    output  reg         fifo_rd_en   // FIFO读使能
);

reg [5:0] fre_cnt_G;                  //GCLK分频系数
//reg [3:0] fre_cnt_D;                 //DCLK分频系数
reg [3:0] state_cnt;                 //DCLK跳转计数器
reg [3:0] data_cnt;                 //数据写入位数计数器
reg [5:0] data_num;                 //数据个数计数器

reg [4:0] flow_cnt;                 //状态跳转计数器
//上电稳定
reg [9:0] cnt_wait;                 
//数据传输过程
reg [1:0] data_latch;               //三个通道锁存一次计数（一个像素RGB）    
reg [1:0] vsync_cmd;                //场锁存指令DCLK计数
reg [5:0] latch_cnt;                //16次锁存计数
reg line_flag;                      //第一次锁存不换行

reg [3:0] fre_cnt;                  //分频计数器
reg GCLK_r;                         //GCLK

reg	[5:0]	bit_cnt_send;						//发送计数器

reg flag;
//reg  send_done;
//reg  [47:0] data_send; 

reg [47:0] data_store = 48'd0;
reg [47:0] data_pre;
reg [2:0] store_cnt = 3'd0;
reg flag_send;
reg flag_complete;
reg o_data_en_reg1;
reg o_data_en_reg2;
reg flag_send_reg;
reg start_flag;

reg [3:0] flag_CNT;
reg [8:0] read_cnt;
//always@(posedge p_clk or negedge sys_rst_n)
//begin
//    if(!sys_rst_n)begin
//        o_data_en_reg1 <= 1'd0;
//        o_data_en_reg2 <= 1'd0;
//    end 
//    else begin
//        o_data_en_reg1 <= o_dataen;
//        o_data_en_reg2 <= o_data_en_reg1;
//    end
//end


//always@(posedge p_clk or negedge sys_rst_n)begin 
//    if (!sys_rst_n)begin
//        data_total_cnt <= 5'd0;
//    end
//    else if (data_total_cnt == 5'd23 )
//         data_total_cnt <= 5'd0;
//    else if (data_total_cnt < 5'd23&&(o_data_en_reg1 && !o_data_en_reg2))
//         data_total_cnt <= data_total_cnt + 1'd1;
//end 
//integer i;
//always@(posedge p_clk or negedge sys_rst_n)begin 
//    if(!sys_rst_n)begin
//           for( i = 0; i < 24 ;i = i+1)begin
//          data_total[i] <= 12'd0;
//          end
//    end
    
//    else if (o_data_en_reg1 && !o_data_en_reg2) begin 
//         data_total[data_total_cnt] <= data_input<<8;
//    end

//end
//芯片工作状态：1.先确认状态，再修改寄存器一的值从而修改行数为8行 2.写入一行数据48个通道 3.在死区时间输入场确认信号，同时换行
//4.再写入下一行数据 5.数据输入完成之后进行数据锁存
always@(posedge DCLK_LE or negedge sys_rst_n)
begin
    if(!sys_rst_n)begin //初始状态
        LE <= 0;
        state_cnt <= 0;
        data_cnt <= 0;
        flow_cnt <= 0;
        cnt_wait <= 0;
        data_num <= 0;
        data_latch <= 0;
        latch_cnt <= 0;
        data_send <= 0;
        flag <= 0;
        spi_start <= 0;
        flag_complete <= 0;
    end
    else begin 
//        spi_start <= 0;     //便于生成脉冲信号
        spi_end <= 0;       //便于生成脉冲信号
        case(flow_cnt)
            //上电后等待稳定
           'd0:begin
				if(cnt_wait == 100)begin			
					cnt_wait <= 8'd0;
					flow_cnt <= flow_cnt + 1'd1;
				end
				else begin
					cnt_wait <= cnt_wait + 1'd1;
					flow_cnt <= flow_cnt;								
				end
               end
             //先发送确认状态的指令，LE拉高同时DCLK产生14个跳变沿
            'd1:begin
                 LE <= 1;
                if(state_cnt == 14)begin
                    LE <= 0;
                    state_cnt <= 0;
                    flow_cnt <= flow_cnt + 3;
                    data_send <= {16'h0000,16'h0e00,16'h0000};
                    spi_start <= 1;
                end
                else begin
                     flow_cnt <= flow_cnt;
                     state_cnt <= state_cnt + 1; //状态1，确认指令，LE拉高14个DCLK跳变沿
                end
              end
           //提供建立时间
//           'd2:begin
//				if(cnt_wait == 30)begin			
//					cnt_wait <= 8'd0;
//					flow_cnt <= flow_cnt + 1'd1;
//				end
//				else begin
//					cnt_wait <= cnt_wait + 1'd1;
//					flow_cnt <= flow_cnt;								
//				end
//               end
              //修改寄存1中的值以修改行数为8（h'00e0），依次传输全局寄存器1，2，3的值，再拉高LE 4个DCLK跳变沿锁存数据
                //一次传输3个寄存器的值，global register1 global register2 global register3
//             'd3:begin
//                data_send <= {16'h00e0,16'h0e00,16'h0000};
//                spi_start <= 1;
//                flow_cnt <= flow_cnt + 1'd1;
//             end
             'd4:begin
                if(send_done)begin
                    spi_end <= 1;
                    spi_start <= 0;
                    LE <= 1;
                    flag <= 1;
                end
                if(flag == 1)begin
                    if(state_cnt == 3)begin
                        LE <= 0;
                        state_cnt <= 0;
                        flow_cnt <= flow_cnt + 1;
                        flag <= 0;
                    end
                    else begin
                        state_cnt <= state_cnt + 1;
                    end
//                    flow_cnt <= flow_cnt + 1'd1;
                end
                else begin
                    flow_cnt <= flow_cnt;
                end
             end
//                //global register2
//             'd5:begin
//                data_send <= 16'h0e00;
//                spi_start <= 1;
//                flow_cnt <= flow_cnt + 1'd1;
//             end
//             'd6:begin
//                if(send_done)begin
//                    spi_end <= 1;
//                    flow_cnt <= flow_cnt + 1'd1;
//                end
//                else begin
//                    flow_cnt <= flow_cnt;
//                end
//             end
//                //global register3
//             'd7:begin
//                data_send <= 16'h0000;
//                spi_start <= 1;
//                flow_cnt <= flow_cnt + 1'd1;
//             end
//             'd8:begin
//                if(send_done)begin
//                    spi_end <= 1;
//                    flow_cnt <= flow_cnt + 1'd1;
//                end
//                else begin
//                    flow_cnt <= flow_cnt;
//                end
//             end
             //拉高LE 4个DCLK以锁存数据
//             'd5:begin
//                LE <= 1;
//                if(state_cnt == 4)begin
//                    LE <= 0;
//                    state_cnt <= 0;
//                    flow_cnt <= flow_cnt + 1;
//                end
//                else begin
//                     flow_cnt <= flow_cnt;
//                     state_cnt <= state_cnt + 1; //LE拉高4个DCLK跳变沿
//                end
//              end
            //开始传输数据，一共八行，每行48个数据；每次传输完三个灰度数据（一个像素RGB）进行一次锁存（LE 一个DCLK）
            //一行48个数据需要锁存16次（ch15-ch0），一行数据完成之后进行VSYNC锁存（2or3DCLK），同时进行换行
            //vsync锁存后数据开始显示，该指令执行时需停止GCLK（前300ns后1200ns）
                //传数据
            'd5:begin
                if(flag_send == 1'd1 )begin
                    flag_complete <= 0;
                    data_send <= data_store;
                    spi_start <= 1;
                    flow_cnt <= flow_cnt + 1'd1;
                end
                else
                    flow_cnt <= flow_cnt;
            end
                //判断状态，数据锁存or场锁存（一次传48bit）
            'd6:begin
                if(send_done)begin
                    spi_end <= 1;
                    spi_start <= 0;
                    //开始数据锁存
                    LE <= 1;
                    flag <= 1;
                end
                else if(flag == 1)begin
                    if(state_cnt == 0)begin
                        LE <= 0;
//                        state_cnt <= 0;
                        flag <= 0;
//                        flow_cnt <= flow_cnt + 1'd1;
                    end
//                    else 
//                         state_cnt <= state_cnt + 1;
                    else begin
                        flow_cnt <= flow_cnt;
                        end
                    //判断是否需要进行场锁存
                    if(latch_cnt == 15)begin    //进行场锁存
                       latch_cnt <= 0;
                       flow_cnt <= flow_cnt + 1;
                    end
                    else  begin
                        latch_cnt <= latch_cnt + 1;
                            //send_flag= 0;
                        flow_cnt  <= 5;
                    end                    
                end
            end
//                 //判断状态，继续传输or数据锁存or场锁存
//            'd12:begin
//                if(data_latch == 2)begin            //判断是否进行数据锁存
//                    LE <= 1;
//                    if(state_cnt == 1)begin
//                        LE <= 0;
//                        data_latch <= 0;
//                        state_cnt <= 0;
//                        flow_cnt <= flow_cnt + 1;
//                    end
//                    else begin
//                        flow_cnt <= flow_cnt;
//                        state_cnt <= state_cnt + 1;
//                    end
//                end
//                else begin
//                    data_latch <= data_latch + 1;
//                    flow_cnt <= 10;
//                end
//             end
//                //判断是否满16次数据锁存,满16次则进行场锁存，没满16次则继续锁存
//             'd13:begin
//                if(latch_cnt == 15)begin    //进行场锁存
//                   latch_cnt <= 0;
//                   flow_cnt <= flow_cnt + 1;
//                end
//                else begin
//                    latch_cnt <= latch_cnt + 1;
//                    flow_cnt  <= 10;
//                end
//             end
                //进行场锁存，注意前后间隔时间，300ns 1200ns
             'd7:begin
                if(cnt_wait == 3)begin			
					cnt_wait <= 8'd0;
					flow_cnt <= flow_cnt + 1'd1;
				end
				else begin
					cnt_wait <= cnt_wait + 1'd1;
					flow_cnt <= flow_cnt;								
				end
             end
                //场锁存
              'd8:begin
                 LE <= 1;
                 if(state_cnt == 2)begin
                     LE <= 0;
                     state_cnt <= 0;
                     flow_cnt <= flow_cnt + 1;
                 end
                 else begin
                      flow_cnt <= flow_cnt;
                      state_cnt <= state_cnt + 1; //状态1，确认指令，LE拉高14个DCLK跳变沿
                 end
               end
                //1200ns
              'd9:begin
                if(cnt_wait == 6)begin			
					cnt_wait <= 8'd0;
					flow_cnt <= flow_cnt + 1;
				end
				else begin
					cnt_wait <= cnt_wait + 1'd1;
					flow_cnt <= flow_cnt;								
				end
              end
              //换行
              'd10:begin
                flow_cnt <= 5;
              end
        endcase
        end
end

//-----------------------数据传输-----------------------------//
// 发送数据
always @(posedge DCLK_data or negedge sys_rst_n)begin
	if(!sys_rst_n)begin                         //模式0空闲。时钟空闲低电平，第一个跳变沿采样（上升沿）
		spi_mosi <= 1'b0;						//钟线空闲是为低电平，数据在SCK时钟的上升沿被采样，数据在SCK时钟的下降沿切换
		bit_cnt_send <= 4'd0;
	end
//	else if(cnt == 2'd0 && !spi_cs)begin		//模式0的上升沿
    else if(spi_start)begin
                spi_mosi <= data_send[47-bit_cnt_send];	//发送数据移位
                if(bit_cnt_send == 47)				//发送完48bit
                    bit_cnt_send <= 0;
                else if(bit_cnt_send < 47)    
                    bit_cnt_send <= bit_cnt_send + 1'b1;	
                else begin
                    spi_mosi <= spi_mosi;
                    bit_cnt_send <= bit_cnt_send;
                end
        end
        else begin
            spi_mosi <= 0;      //空闲状态下为0
            end
end
// 发送数据标志
always @(posedge DCLK_data or negedge sys_rst_n)begin
	if(!sys_rst_n)
		send_done <= 1'b0;			
	else if(bit_cnt_send == 47)		//发送完了16bit数据
		send_done <= 1'b1;								//拉高一个周期，表示发送完成	
	else 
		send_done <= 1'b0;			
end



//判断是否换行,第一次不换行
always@(posedge DCLK_LE or negedge sys_rst_n)
begin
    if(!sys_rst_n)begin
        line <= 0;
        line_flag <= 0;
    end
    else if(flow_cnt == 10)begin
            if(line_flag == 0)begin
                line <= line;
                line_flag <= 1;
            end
            else begin
                line <= line + 1;
                line_flag <= line_flag;
            end
    end
end
//GCLK分频，同时判断是否拉低GCLK
always@(posedge sys_clk or negedge sys_rst_n)
begin
    if(!sys_rst_n)begin
        fre_cnt_G <= 0;
        GCLK <= 0;
    end
    else if(flow_cnt >= 7)begin
            GCLK <= 0;
        end
        else if(fre_cnt_G == 1)begin
                GCLK <= ~GCLK;
                fre_cnt_G <= 0;
             end
             else begin
                fre_cnt_G <= fre_cnt_G + 1;
             end
end







//store_en
//always@(posedge sys_clk or negedge sys_rst_n)begin 
//    if(!sys_rst_n)begin
//        data_en <= 1'd0;
//    end
//    else if ( data_total_cnt == 5'd23)begin
//        data_en <=1'd1;
//    end
//    else if (read_cnt == 5'd24)
//    begin 
//       data_en <= 1'd0;
//    end
////end
//reg data_store_end_flag;
//always@(posedge sys_clk or negedge sys_rst_n)begin 
//    if(!sys_rst_n)begin
//        data_store <= 48'd0;
//        data_store_end_flag =1'd0;
//    end
//    else if(read_cnt <=5'd21&&data_en && flag_send==0 )begin
//        data_store[47:0] <= {data_total[read_cnt+2'd2],data_total[read_cnt+2'd1],data_total[read_cnt]};
//        data_store_end_flag =1'd1;
//    end
//    else begin 
//        data_store_end_flag =1'd0;
//    end
//end


reg [15:0] data_total[383:0];
reg [8:0] data_total_cnt;
always@(posedge sys_clk or negedge sys_rst_n)begin 
    if (!sys_rst_n)begin
        data_total_cnt <= 9'd0;
    end
    else if (data_total_cnt == 9'd383 )
         data_total_cnt <= 9'd0;
    else if (data_total_cnt < 9'd383&&fifo_rd_en)
         data_total_cnt <= data_total_cnt + 1'd1;
end 
integer i;
always@(posedge sys_clk or negedge sys_rst_n)begin 
    if(!sys_rst_n)begin
           for( i = 0; i < 24 ;i = i+1)begin
          data_total[i] <= 8'd0;
          end
    end
    else if (fifo_rd_en) begin 
         data_total[data_total_cnt] <= fifo_dout<<8;
    end

end


reg data_store_end_flag;
always@(posedge sys_clk or negedge sys_rst_n)begin 
    if(!sys_rst_n)begin
       read_cnt <= 9'd0;
    end
    else if( read_cnt == 9'd384)begin
       read_cnt <= 9'd0;
    end
    else if (data_store_end_flag==1)begin
       read_cnt <= read_cnt + 9'd3;
    end
end

reg fifo_rd_en_reg;
reg fa_en;
always@(posedge sys_clk or negedge sys_rst_n)begin
    if(!sys_rst_n)
        fa_en <= 1'd0;
    else if(!fifo_rd_en_reg && fifo_rd_en)
        fa_en <=  1'd0;
    else if(fifo_rd_en_reg && !fifo_rd_en)
        fa_en <=  1'd1;
    else
        fa_en <=  fa_en;
end

always@(posedge sys_clk or negedge sys_rst_n)begin 
    if(!sys_rst_n)begin
        data_store <= 48'd0;
        data_store_end_flag =1'd0;
    end
    else if(read_cnt <=9'd381 && flag_send==0 && fa_en == 1)begin
        data_store[47:0] <= {data_total[read_cnt+2'd2],data_total[read_cnt+2'd1],data_total[read_cnt]};
        data_store_end_flag =1'd1;
    end
    else begin 
        data_store_end_flag =1'd0;
    end
end



always@(posedge sys_clk or negedge sys_rst_n)begin
    if(!sys_rst_n)
        fifo_rd_en_reg <= 1'd0;
    else
        fifo_rd_en_reg <= fifo_rd_en;
end

reg send_done_reg;
always@(posedge sys_clk or negedge sys_rst_n)begin
    if(!sys_rst_n)
        send_done_reg <= 1'd0;
    else
        send_done_reg <= send_done;
end


always@(posedge sys_clk or negedge sys_rst_n)begin
    if(!sys_rst_n)
        flag_send_reg <= 1'd0;
    else
        flag_send_reg <= flag_send;
end

//always@(posedge sys_clk or negedge sys_rst_n)begin
//    if(!sys_rst_n)
//        start_flag <= 1'd0;
//    else if((!flag_send_reg && flag_send) == 1)
//        start_flag <= 1'd1;
//    else if((flag_send_reg && !flag_send) == 1)
//        start_flag <= 1'd0;
//    else
//        start_flag <= start_flag;
//end


////flag_send标志控制
always@(posedge sys_clk or negedge sys_rst_n)
begin
    if(!sys_rst_n)begin
        flag_send <= 0;        
    end
   else if(data_store_end_flag)begin
        flag_send <= 1;
    end
   else if(!send_done_reg && send_done)
        flag_send <= 0;
end


//always@(posedge sys_clk or negedge sys_rst_n)
//begin
//    if(!sys_rst_n)begin
//        flag_CNT <= 0;       
//    end
//    else if(flag_CNT == 4'd15)
//        flag_CNT <= 0; 
//   else if((!flag_send_reg && flag_send) && flag_CNT == 0)begin
//        flag_CNT <= flag_CNT + 1; 
//    end
//end

//////flag_send标志控制
//always@(posedge sys_clk or negedge sys_rst_n)
//begin
//    if(!sys_rst_n)begin
//        flag_send <= 0;        
//    end
//   else if(data_store_end_flag)begin
//        flag_send <= 1;
//    end
//   else if(send_done)
//        flag_send <= 0;
//end

//*****************************************************
//**                    FIFO
//*****************************************************
//reg define
reg  [1:0]  state           ;  // 动作状态
reg         almost_full_d0  ;  // fifo_full 延迟一拍
reg  		almost_full_syn ;  // fifo_full 延迟两拍
reg  [3:0]  dly_cnt         ;  //延迟计数器


//因为 fifo_full 信号是属于FIFO写时钟域的
//所以要将其同步到读时钟域中
always@( posedge sys_clk ) begin
	if( !sys_rst_n ) begin
		almost_full_d0  <= 1'b0 ;
		almost_full_syn <= 1'b0 ;
	end
	else begin
		almost_full_d0  <= almost_full ;
		almost_full_syn <= almost_full_d0 ;
	end
end

//读出FIFO的数据
always @(posedge sys_clk ) begin
    if(!sys_rst_n) begin
        fifo_rd_en <= 1'b0;
		state      <= 2'd0;
		dly_cnt    <= 4'd0;
    end
    else begin
        case(state)
            2'd0: begin
                if(almost_full_syn)      //如果检测到FIFO将被写满
                    state <= 2'd1;       //就进入延时状态
                else
                    state <= state;
            end 
			2'd1: begin
                if(dly_cnt == 4'd10) begin  //延时10拍
											//原因是FIFO IP核内部状态信号的更新存在延时
											//延迟10拍以等待状态信号更新完毕
                    dly_cnt <= 4'd0;
					state   <= 2'd2;        //开始读操作
				end
				else
					dly_cnt <= dly_cnt + 4'd1;
            end
		    2'd2: begin
                if(almost_empty) begin     //等待FIFO将被读空
                    fifo_rd_en <= 1'b0;    //关闭读使能
                    state      <= 2'd0;    //回到第一个状态
                end
                else                       //如果FIFO没有被读空
                    fifo_rd_en <= 1'b1;    //则持续打开读使能
            end 
			default : state <= 2'd0;
        endcase
    end
end

endmodule























