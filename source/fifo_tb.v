`timescale 1ns/1ps
`define wrclk_period 20
`define rdclk_period 10

module fifo_tb;

//source define
	reg	[31:0]  write_data;
	reg	  write_clk;
	reg	  mem_clk;
    reg write_fifo_aclr;
    reg write_en; //使能引脚
    reg wr_burst_data_req; //读使能
//probe define
	wire	[63:0]  wr_burst_data;
	wire	[10:0]  rdusedw;
wire GRS_N;

GTP_GRS GRS_INST (

.GRS_N(1'b1)

);
afifo_16i_64o_512 write_buf(
    .wr_clk			(write_clk),     //vedio)clk
    .wr_rst			(write_fifo_aclr),
    .wr_en			(write_en),
    .wr_data		(write_data),
    .wr_full		(),
    .wr_water_level	(),
    .almost_full	(),
    .rd_clk			(mem_clk),      //ddr 时钟
    .rd_rst			(write_fifo_aclr),
    .rd_en			(wr_burst_data_req),
    .rd_data		(wr_burst_data),
    .rd_empty		(),
    .rd_water_level	(),
    .almost_empty	()
);

//generater clock
	initial write_clk = 1;
	always #(`wrclk_period/2)write_clk = ~write_clk;
	
	initial mem_clk = 1;
	always #(`rdclk_period/2)mem_clk = ~mem_clk;
	
	integer i;

	initial begin
        write_fifo_aclr = 1;
		write_data = 0;
		write_en = 0;
		wr_burst_data_req = 0;
		#(`wrclk_period*20 + 1);
        write_fifo_aclr = 0;
		for (i=0;i <= 255 ;i = i + 1)begin
			write_en = 1;
			write_data = i + 1024;
			#`wrclk_period;
		end
		write_en = 0;
		#(`rdclk_period*20);
		for (i=0;i <= 512 ;i = i + 1)begin
			wr_burst_data_req = 1;
			#`rdclk_period;
		end	
		wr_burst_data_req = 0;
		#(`rdclk_period*200);
		$stop;	

	end

endmodule
