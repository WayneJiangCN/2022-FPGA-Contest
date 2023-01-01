module detect(
    input             clk       ,
    input             reset     ,
    input             vs        , // 场信号
    input             hs        , // 行信号
    input             de        , // 输入数据有效信号
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


// // xaddr (实际未用到)
// always@(posedge clk or posedge reset)begin
//     if(reset)
//         xaddr <= 14'd0;
//     // 通过de信号对xaddr进行计数
//     else if(de)
//         xaddr <= xaddr + 1'b1;
//     else
//         xaddr <= 14'd0;
// end

// 打一拍检测 hs 上升沿
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
    // vs 为0说明一帧图像已传输完成 yaddr 可以置零
    else if(~vs)    
        yaddr <= 11'd0;
    // 检测到行信号上升沿yaddr加一
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

// 上升沿检测
assign h_add_flag = ~start_reg && start;

endmodule
 