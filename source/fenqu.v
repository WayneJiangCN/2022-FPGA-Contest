module fenqu(
        input [7:0]                     data,
		input						    clk,
        input                           rst_n,
		input						    i_h_sync,
		input							i_v_sync,
		input							i_data_en,
        output        [7:0]             o_data,
        output          reg            o_data_en                      
   );


wire  h_add_flag;


wire [11:0]  yaddr;
//reg [5:0]   h_count;
wire [7:0]   max_data0;
//reg [11:0]   max_data1;
//reg [7:0]   max_data;
reg [5:0]   row_cnt;
reg [4:0]   area_num; //������
reg h_add_flag_reg;
reg i_data_en_reg;
//reg [7:0] area_data;

reg area_data_de; //һ�������ݽ�����־λ
//reg all_de; 
wire ave_data_de;  //ƽ��ֵ�������ޱ�־

reg [11:0] area_ave_data [23:0];
detect  u_detect(
                .clk(clk)                     ,
                .reset(rst_n)                  ,
                .vs(i_v_sync)                 , // ���ź�
                .hs(i_h_sync)                 , // ���ź�
                .de(i_data_en)                , // ����������Ч�ź�
                .h_add_flag(h_add_flag)       ,
                .yaddr(yaddr)
                );

// ��һ�ļ�� hs ������
always@(posedge clk or posedge rst_n)begin
    if(rst_n)
        h_add_flag_reg <= 1'b0;
    else
        h_add_flag_reg <= h_add_flag;
end

always@(posedge clk or posedge rst_n)begin
    if(rst_n)
        i_data_en_reg <= 1'b0;
    else
        i_data_en_reg <= i_data_en;
end
pingjun u_pingjun

    (
    	.clk                       (clk),
    	.rst_n                     (rst_n),
        .i_data_de                 (i_data_en),
    	.data_in                   (data),
    	.data_out                  (max_data0),
        .o_data_de                 (ave_data_de)
    );
integer i;
//45��ƽ��ֵ ÿ������һ��ƽ������
always @(posedge clk or posedge rst_n)begin
    if(!rst_n)begin
       
           for( i = 0; i < 24 ;i = i+1)begin
          area_ave_data[i] <= 12'd0;
          end
    end
    else if(ave_data_de)begin
        if (yaddr <6'd45&&ave_data_de)begin
       area_ave_data[area_num-1'd1]<=area_ave_data[area_num-1'd1]+max_data0;
         end
         else  begin
         area_ave_data[area_num-1'd1] <=area_ave_data[area_num-1'd1];
         end
     end
end
always @(posedge clk or posedge rst_n)begin
    if(!rst_n)
    area_data_de <= 1'b0;
    else if(yaddr == 6'd45)
        area_data_de <= 1'b1;
    else if(yaddr < 6'd45)
        area_data_de <= 1'b0;
end


//ÿ53��Ϊһ��
always @(posedge clk or posedge rst_n)begin
    if(!rst_n)begin
        row_cnt <= 6'd0;
    end
    else if(row_cnt == 6'd52 )//horizontal counter maximum value
        row_cnt <= 6'd0;
    else if(yaddr == 6'd0)
        row_cnt <= 6'd0;
    else if(i_data_en)
        row_cnt <= row_cnt + 6'd1;
    else 
        row_cnt <= 6'd0;
end


//�ҵ���Ӧ������
always@(posedge clk or posedge rst_n)begin
    if(!rst_n)
    area_num <= 6'd0;
    else if (area_num == 6'd24&&(~i_data_en_reg&&i_data_en))
        area_num <= 6'd0;
     else if (row_cnt == 6'd52)
      area_num <= area_num +1'd1;
    else 
        area_num <= area_num;
end
always@(posedge clk or posedge rst_n)begin
    if(!rst_n)
          o_data_en = 1'd0;
    else if(ave_data_de&&yaddr==6'd45)
          o_data_en = 1'd1;
    else 
          o_data_en = 1'd0;   
end
assign o_data= area_ave_data[area_num-1'd1]/45;
//ͨ�����Ĵ�Сȷ�������ֵ

endmodule
