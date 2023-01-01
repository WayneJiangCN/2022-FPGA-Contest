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
//�Ҷ�����ͨ������"SDI��SDO"���ͣ�����������"LE"��"DCLK"���

module MBI5353(
//ϵͳ�ӿ�
    input           sys_clk  ,      //ϵͳ����ʱ��
    input           sys_rst_n,      //��λ�źţ��͵�ƽ��Ч   
//�û���������
    output  reg      GCLK    ,       //ȫ��ʱ�ӣ��൱��spi��clk������spi������ʱ�ӣ�
    input             DCLK_LE    ,       //����ʱ��
    input             DCLK_data,      //
    output  reg      LE      ,       //�����������
    input           o_dataen,      //���ʹ���ź�
//�û��ӿ�
//    input   [7:0]  data_input  ,   //ddr���͹���������
    output  reg     send_done,      //��������һ���ֽڽ�����־
    output  reg     spi_start,      //���ʹ��俪ʼ�źţ�һ���ߵ�ƽ
    output  reg     spi_end  ,      //���ʹ�������źţ�һ���ߵ�ƽ
    output  reg     spi_mosi,       //���ݴ���
    output  reg  [47:0] data_send,   //Ҫ���͵�����
//    output  reg  [47:0] data_store,   //Ҫ���͵�����
    output  reg  [2:0]  line,         //��ǰ����
    
    input        [7:0]  fifo_dout ,  // ��FIFO����������
    input               almost_full ,// FIFO�����ź�
    input               almost_empty,// FIFO�����ź�
    output  reg         fifo_rd_en   // FIFO��ʹ��
);

reg [5:0] fre_cnt_G;                  //GCLK��Ƶϵ��
//reg [3:0] fre_cnt_D;                 //DCLK��Ƶϵ��
reg [3:0] state_cnt;                 //DCLK��ת������
reg [3:0] data_cnt;                 //����д��λ��������
reg [5:0] data_num;                 //���ݸ���������

reg [4:0] flow_cnt;                 //״̬��ת������
//�ϵ��ȶ�
reg [9:0] cnt_wait;                 
//���ݴ������
reg [1:0] data_latch;               //����ͨ������һ�μ�����һ������RGB��    
reg [1:0] vsync_cmd;                //������ָ��DCLK����
reg [5:0] latch_cnt;                //16���������
reg line_flag;                      //��һ�����治����

reg [3:0] fre_cnt;                  //��Ƶ������
reg GCLK_r;                         //GCLK

reg	[5:0]	bit_cnt_send;						//���ͼ�����

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
//оƬ����״̬��1.��ȷ��״̬�����޸ļĴ���һ��ֵ�Ӷ��޸�����Ϊ8�� 2.д��һ������48��ͨ�� 3.������ʱ�����볡ȷ���źţ�ͬʱ����
//4.��д����һ������ 5.�����������֮�������������
always@(posedge DCLK_LE or negedge sys_rst_n)
begin
    if(!sys_rst_n)begin //��ʼ״̬
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
//        spi_start <= 0;     //�������������ź�
        spi_end <= 0;       //�������������ź�
        case(flow_cnt)
            //�ϵ��ȴ��ȶ�
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
             //�ȷ���ȷ��״̬��ָ�LE����ͬʱDCLK����14��������
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
                     state_cnt <= state_cnt + 1; //״̬1��ȷ��ָ�LE����14��DCLK������
                end
              end
           //�ṩ����ʱ��
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
              //�޸ļĴ�1�е�ֵ���޸�����Ϊ8��h'00e0�������δ���ȫ�ּĴ���1��2��3��ֵ��������LE 4��DCLK��������������
                //һ�δ���3���Ĵ�����ֵ��global register1 global register2 global register3
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
             //����LE 4��DCLK����������
//             'd5:begin
//                LE <= 1;
//                if(state_cnt == 4)begin
//                    LE <= 0;
//                    state_cnt <= 0;
//                    flow_cnt <= flow_cnt + 1;
//                end
//                else begin
//                     flow_cnt <= flow_cnt;
//                     state_cnt <= state_cnt + 1; //LE����4��DCLK������
//                end
//              end
            //��ʼ�������ݣ�һ�����У�ÿ��48�����ݣ�ÿ�δ����������Ҷ����ݣ�һ������RGB������һ�����棨LE һ��DCLK��
            //һ��48��������Ҫ����16�Σ�ch15-ch0����һ���������֮�����VSYNC���棨2or3DCLK����ͬʱ���л���
            //vsync��������ݿ�ʼ��ʾ����ָ��ִ��ʱ��ֹͣGCLK��ǰ300ns��1200ns��
                //������
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
                //�ж�״̬����������or�����棨һ�δ�48bit��
            'd6:begin
                if(send_done)begin
                    spi_end <= 1;
                    spi_start <= 0;
                    //��ʼ��������
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
                    //�ж��Ƿ���Ҫ���г�����
                    if(latch_cnt == 15)begin    //���г�����
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
//                 //�ж�״̬����������or��������or������
//            'd12:begin
//                if(data_latch == 2)begin            //�ж��Ƿ������������
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
//                //�ж��Ƿ���16����������,��16������г����棬û��16�����������
//             'd13:begin
//                if(latch_cnt == 15)begin    //���г�����
//                   latch_cnt <= 0;
//                   flow_cnt <= flow_cnt + 1;
//                end
//                else begin
//                    latch_cnt <= latch_cnt + 1;
//                    flow_cnt  <= 10;
//                end
//             end
                //���г����棬ע��ǰ����ʱ�䣬300ns 1200ns
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
                //������
              'd8:begin
                 LE <= 1;
                 if(state_cnt == 2)begin
                     LE <= 0;
                     state_cnt <= 0;
                     flow_cnt <= flow_cnt + 1;
                 end
                 else begin
                      flow_cnt <= flow_cnt;
                      state_cnt <= state_cnt + 1; //״̬1��ȷ��ָ�LE����14��DCLK������
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
              //����
              'd10:begin
                flow_cnt <= 5;
              end
        endcase
        end
end

//-----------------------���ݴ���-----------------------------//
// ��������
always @(posedge DCLK_data or negedge sys_rst_n)begin
	if(!sys_rst_n)begin                         //ģʽ0���С�ʱ�ӿ��е͵�ƽ����һ�������ز����������أ�
		spi_mosi <= 1'b0;						//���߿�����Ϊ�͵�ƽ��������SCKʱ�ӵ������ر�������������SCKʱ�ӵ��½����л�
		bit_cnt_send <= 4'd0;
	end
//	else if(cnt == 2'd0 && !spi_cs)begin		//ģʽ0��������
    else if(spi_start)begin
                spi_mosi <= data_send[47-bit_cnt_send];	//����������λ
                if(bit_cnt_send == 47)				//������48bit
                    bit_cnt_send <= 0;
                else if(bit_cnt_send < 47)    
                    bit_cnt_send <= bit_cnt_send + 1'b1;	
                else begin
                    spi_mosi <= spi_mosi;
                    bit_cnt_send <= bit_cnt_send;
                end
        end
        else begin
            spi_mosi <= 0;      //����״̬��Ϊ0
            end
end
// �������ݱ�־
always @(posedge DCLK_data or negedge sys_rst_n)begin
	if(!sys_rst_n)
		send_done <= 1'b0;			
	else if(bit_cnt_send == 47)		//��������16bit����
		send_done <= 1'b1;								//����һ�����ڣ���ʾ�������	
	else 
		send_done <= 1'b0;			
end



//�ж��Ƿ���,��һ�β�����
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
//GCLK��Ƶ��ͬʱ�ж��Ƿ�����GCLK
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


////flag_send��־����
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

//////flag_send��־����
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
reg  [1:0]  state           ;  // ����״̬
reg         almost_full_d0  ;  // fifo_full �ӳ�һ��
reg  		almost_full_syn ;  // fifo_full �ӳ�����
reg  [3:0]  dly_cnt         ;  //�ӳټ�����


//��Ϊ fifo_full �ź�������FIFOдʱ�����
//����Ҫ����ͬ������ʱ������
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

//����FIFO������
always @(posedge sys_clk ) begin
    if(!sys_rst_n) begin
        fifo_rd_en <= 1'b0;
		state      <= 2'd0;
		dly_cnt    <= 4'd0;
    end
    else begin
        case(state)
            2'd0: begin
                if(almost_full_syn)      //�����⵽FIFO����д��
                    state <= 2'd1;       //�ͽ�����ʱ״̬
                else
                    state <= state;
            end 
			2'd1: begin
                if(dly_cnt == 4'd10) begin  //��ʱ10��
											//ԭ����FIFO IP���ڲ�״̬�źŵĸ��´�����ʱ
											//�ӳ�10���Եȴ�״̬�źŸ������
                    dly_cnt <= 4'd0;
					state   <= 2'd2;        //��ʼ������
				end
				else
					dly_cnt <= dly_cnt + 4'd1;
            end
		    2'd2: begin
                if(almost_empty) begin     //�ȴ�FIFO��������
                    fifo_rd_en <= 1'b0;    //�رն�ʹ��
                    state      <= 2'd0;    //�ص���һ��״̬
                end
                else                       //���FIFOû�б�����
                    fifo_rd_en <= 1'b1;    //������򿪶�ʹ��
            end 
			default : state <= 2'd0;
        endcase
    end
end

endmodule























