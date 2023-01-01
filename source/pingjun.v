//先写入所有RAM所有数据，然后写计数器比读计数器慢一拍，形成加一个数同时减一个数。
module pingjun

(
input	            clk,
input	            rst_n,
input               i_data_de,
input	[7:0]   	data_in,
output	[7:0]       data_out,
output  reg         o_data_de
);

reg [12:0] data_all;
reg [5:0] cnt;
always @(posedge clk or posedge rst_n)begin
    if(rst_n)
        cnt <= 6'd0;
    else if(cnt == 52)begin
        cnt <= 6'd0;
    end
    else if(i_data_de)
        cnt <= cnt +1'd1;
    else 
        cnt <= 6'd0;
end

always @(posedge clk or posedge rst_n)begin
    if(rst_n)
        o_data_de <= 6'd0;
    else if(cnt == 52)
        o_data_de <= 1'd1;
    else 
        o_data_de <= 6'd0;
end

always @(posedge clk or posedge rst_n)begin
    if(rst_n)begin
    data_all <= 13'd0;
 
    end
    else if(i_data_de&&cnt<52)
        data_all <= data_all + data_in;
end
assign data_out = o_data_de?((data_all + data_in)/53):data_out;

endmodule
