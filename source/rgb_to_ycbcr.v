/* 
    RGBתYUV�㷨
	���㹫ʽ��	Y  =  0.183R + 0.614G + 0.062B + 16;
							CB = -0.101R - 0.338G + 0.439B + 128; 
							CR =  0.439R - 0.399G - 0.040B + 128;
	���У�ʱ���ڼ����������ȫû���õ�
	���뵽���������clock��ʱ�ӡ�
	��һ����ˮ�߼������г˷���
	�ڶ�����ˮ�߼������мӷ��������ĺ͸��ķֿ����мӷ���
	��������ˮ�߼������յĺͣ���Ϊ����ȡ0��
	����ͨ��
*/
module	rgb_to_ycbcr(
						input								clk,
						input				[7 : 0]		i_r_8b,
						input				[7 : 0]		i_g_8b,
						input				[7 : 0]		i_b_8b,
						input                   rst_n,
  						
						input						      i_h_sync,
						input							   i_v_sync,
						input							   i_data_en,
						
						output			[7 : 0]		o_y_8b,
						output			[7 : 0]		o_cb_8b,
						output			[7 : 0]		o_cr_8b,					
						output							o_h_sync,
						output							o_v_sync,                                                                                                  
						output						   o_data_en                                                                                                
						);

/***************************************parameters*******************************************/
//multiply 256
parameter	para_0183_10b = 10'd47;    //0.183 ������
parameter	para_0614_10b = 10'd157;
parameter	para_0062_10b = 10'd16;
parameter	para_0101_10b = 10'd26;
parameter	para_0338_10b = 10'd86;
parameter	para_0439_10b = 10'd112;
parameter	para_0399_10b = 10'd102;
parameter	para_0040_10b = 10'd10;
parameter	para_16_18b = 18'd4096;
parameter	para_128_18b = 18'd32768;
/********************************************************************************************/

/***************************************signals**********************************************/
wire				sign_cb;
wire				sign_cr;
reg[17: 0]	mult_r_for_y_18b;
reg[17: 0]	mult_r_for_cb_18b;
reg[17: 0]	mult_r_for_cr_18b;

reg[17: 0]	mult_g_for_y_18b;
reg[17: 0]	mult_g_for_cb_18b;
reg[17: 0]	mult_g_for_cr_18b;

reg[17: 0]	mult_b_for_y_18b;
reg[17: 0]	mult_b_for_cb_18b;
reg[17: 0]	mult_b_for_cr_18b;

reg[17: 0]	add_y_0_18b;
reg[17: 0]	add_cb_0_18b;
reg[17: 0]	add_cr_0_18b;

reg[17: 0]	add_y_1_18b;
reg[17: 0]	add_cb_1_18b;
reg[17: 0]	add_cr_1_18b;

reg[17: 0] 	result_y_18b;
reg[17: 0]	result_cb_18b;
reg[17: 0]	result_cr_18b;

reg[9:0] y_tmp;
reg[9:0] cb_tmp;
reg[9:0] cr_tmp;

reg					i_h_sync_delay_1;
reg					i_v_sync_delay_1;
reg					i_data_en_delay_1;

reg					i_h_sync_delay_2;
reg					i_v_sync_delay_2;
reg					i_data_en_delay_2;

reg					i_h_sync_delay_3;
reg					i_v_sync_delay_3;
reg					i_data_en_delay_3;
/********************************************************************************************/


    
/***************************************arithmetic*******************************************/
//LV1 pipeline : mult
always @ (posedge	clk or negedge rst_n)
begin
    if(!rst_n)
        begin
          mult_r_for_y_18b <= 18'd0;
	       mult_r_for_cb_18b <= 18'd0;
	       mult_r_for_cr_18b <= 18'd0;
        end
    else begin
	    mult_r_for_y_18b <= i_r_8b * para_0183_10b;
	    mult_r_for_cb_18b <= i_r_8b * para_0101_10b;
	    mult_r_for_cr_18b <= i_r_8b * para_0439_10b;
    end
end

always @ (posedge	clk or negedge rst_n)
begin
    if(!rst_n)
        begin
           mult_g_for_y_18b <= 18'd0;
	       mult_g_for_cb_18b <= 18'd0;
    	   mult_g_for_cr_18b <= 18'd0;
        end
    else begin
	    mult_g_for_y_18b <= i_g_8b * para_0614_10b;
	    mult_g_for_cb_18b <= i_g_8b * para_0338_10b;
	    mult_g_for_cr_18b <= i_g_8b * para_0399_10b;
    end
end

always @ (posedge	clk or negedge rst_n)
begin
    if(!rst_n)
        begin
           mult_b_for_y_18b <= 18'd0;
	       mult_b_for_cb_18b <= 18'd0;
    	   mult_b_for_cr_18b <= 18'd0;
        end
    else begin
	    mult_b_for_y_18b <= i_b_8b * para_0062_10b;
	    mult_b_for_cb_18b <= i_b_8b * para_0439_10b;
	    mult_b_for_cr_18b <= i_b_8b * para_0040_10b;
    end
end
//LV2 pipeline : add
always @ (posedge	clk or negedge rst_n)
begin
	if(!rst_n)
        begin
           add_y_0_18b <= 18'd0;
		   add_cb_0_18b <= 18'd0;
		   add_cr_0_18b <= 18'd0;
		   add_y_1_18b <= 18'd0;
		   add_cb_1_18b <= 18'd0;
		   add_cr_1_18b <= 18'd0;		   
        end
	else begin
		add_y_0_18b <= mult_r_for_y_18b + mult_g_for_y_18b;
		add_y_1_18b <= mult_b_for_y_18b + para_16_18b;
	
		add_cb_0_18b <= mult_b_for_cb_18b + para_128_18b;
		add_cb_1_18b <= mult_r_for_cb_18b + mult_g_for_cb_18b;
	
		add_cr_0_18b <= mult_r_for_cr_18b + para_128_18b;
		add_cr_1_18b <= mult_g_for_cr_18b + mult_b_for_cr_18b;
		end
end
//LV3 pipeline : y + cb + cr

assign	sign_cb = (add_cb_0_18b >= add_cb_1_18b);
assign	sign_cr = (add_cr_0_18b >= add_cr_1_18b);
always @ (posedge	clk or negedge rst_n)
begin
	if(!rst_n)
        begin
		result_y_18b <= 18'd0;
		result_cb_18b <= 18'd0;
		result_cr_18b <= 18'd0;
        end
	else begin
		result_y_18b <= add_y_0_18b + add_y_1_18b;
		result_cb_18b <= sign_cb ? (add_cb_0_18b - add_cb_1_18b) : 18'd0;
		result_cr_18b <= sign_cr ? (add_cr_0_18b - add_cr_1_18b) : 18'd0;
	end
end

always @ (posedge	clk or negedge rst_n)
begin
	if(!rst_n)
        begin
		y_tmp <= 8'd0;
		cb_tmp <= 8'd0;
		cr_tmp <= 8'd0;
        end
	else begin
	y_tmp <= result_y_18b[17:8] + {9'd0,result_y_18b[7]};
	cb_tmp <= result_cb_18b[17:8] + {9'd0,result_cb_18b[7]};
	cr_tmp <= result_cr_18b[17:8] + {9'd0,result_cr_18b[7]};
	end
end

//output
assign	o_y_8b 	= (y_tmp[9:8] == 2'b00) ? y_tmp[7 : 0] : 8'hFF;
assign	o_cb_8b 	= (cb_tmp[9:8] == 2'b00) ? cb_tmp[7 : 0] : 8'hFF;
assign	o_cr_8b 	= (cr_tmp[9:8] == 2'b00) ? cr_tmp[7 : 0] : 8'hFF;

/********************************************************************************************/

/***************************************timing***********************************************/
always @ (posedge	clk or negedge rst_n)
begin
	if(!rst_n) begin
	i_h_sync_delay_1 <= 1'd0;
	i_v_sync_delay_1 <= 1'd0;
	i_data_en_delay_1 <= 1'd0;
	
	i_h_sync_delay_2 <= 1'd0;
	i_v_sync_delay_2 <= 1'd0;
	i_data_en_delay_2 <= 1'd0;
	end
	else begin
	i_h_sync_delay_1 <= i_h_sync;
	i_v_sync_delay_1 <= i_v_sync;
	i_data_en_delay_1 <= i_data_en;
	
	i_h_sync_delay_2 <= i_h_sync_delay_1;
	i_v_sync_delay_2 <= i_v_sync_delay_1;
	i_data_en_delay_2 <= i_data_en_delay_1;
	
	i_h_sync_delay_3 <= i_h_sync_delay_2;
	i_v_sync_delay_3 <= i_v_sync_delay_2;
	i_data_en_delay_3 <= i_data_en_delay_2;
	end
end	
//--------------------------------------
//timing
//--------------------------------------	
assign	o_h_sync = i_h_sync_delay_3;
assign	o_v_sync = i_v_sync_delay_3;
assign 	o_data_en = i_data_en_delay_3;

/********************************************************************************************/
endmodule 