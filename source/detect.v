module detect(
    input             clk       ,
    input             reset     ,
    input             vs        , // ���ź�
    input             hs        , // ���ź�
    input             de        , // ����������Ч�ź�
    output            h_add_flag ,
    output   reg  [11:0]     yaddr
);
// wire define
wire        data_valid_pluse;
wire        start;
wire        start_pluse;
// reg define
reg         hs_reg;
reg         start_reg;


// // xaddr (ʵ��δ�õ�)
// always@(posedge clk or posedge reset)begin
//     if(reset)
//         xaddr <= 14'd0;
//     // ͨ��de�źŶ�xaddr���м���
//     else if(de)
//         xaddr <= xaddr + 1'b1;
//     else
//         xaddr <= 14'd0;
// end

// ��һ�ļ�� hs ������
always@(posedge clk or posedge reset)begin
    if(reset)
        hs_reg <= 1'b0;
    else
        hs_reg <= hs;
end

// yaddr
always@(posedge clk or posedge reset)begin
    if(reset)
        yaddr <= 11'd0;
    // vs Ϊ0˵��һ֡ͼ���Ѵ������ yaddr ��������
    else if(~vs)    
        yaddr <= 11'd0;
    // ��⵽���ź�������yaddr��һ
    else if(yaddr == 11'd45&&~hs_reg && hs)
        yaddr <= 1'b1;
    else if(~hs_reg && hs)
        yaddr <= yaddr + 1'b1;
    else
        yaddr <= yaddr;
end


assign start = (yaddr > 0) ? 1'b1 : 1'b0;

always@(posedge clk or posedge reset)begin
    if(reset)
        start_reg <= 1'b0;
    else
        start_reg <= start;
end

// �����ؼ��
assign h_add_flag = ~start_reg && start;

endmodule
 