#Generated by Fabric Compiler ( version 2020.3 <build 62942> ) at Tue Dec 22 14:16:18 2020

add_design "E:/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/aq_axi_master.v"
add_design "E:/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/cmos_8_16bit.v"
add_design "E:/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/cmos_write_req_gen.v"
add_design "E:/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/color_bar.v"
add_design "E:/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/frame_fifo_read.v"
add_design "E:/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/frame_fifo_write.v"
add_design "E:/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/frame_read_write.v"
add_design "E:/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/lut_ov5640_rgb565_1024_768.v"
add_design "E:/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/top.v"
add_design "E:/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/video_define.v"
add_design "E:/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/video_timing_data.v"
add_design "E:/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/rtl/pll/pll_50_400_v1_1.v"
add_design "E:/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/rtl/ipsl_hmic_h_ddrc_apb_reset_v1_1.v"
add_design "E:/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/rtl/ipsl_hmic_h_ddrc_reset_ctrl_v1_1.v"
add_design "E:/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/rtl/ipsl_hmic_h_ddrc_top_v1_1.v"
add_design "E:/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/rtl/ipsl_hmic_h_ddrphy_dll_update_ctrl_v1_1.v"
add_design "E:/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/rtl/ipsl_hmic_h_ddrphy_reset_ctrl_v1_1.v"
add_design "E:/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/rtl/ipsl_hmic_h_ddrphy_training_ctrl_v1_1.v"
add_design "E:/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/rtl/ipsl_hmic_h_ddrphy_update_ctrl_v1_1.v"
add_design "E:/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/rtl/ipsl_hmic_h_phy_io_v1_1.v"
add_design "E:/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/rtl/ipsl_hmic_h_phy_top_v1_1.v"
add_design E:/14_1_ddr3_ov5640_hdmi/ipcore/video_pll/video_pll.idf
add_design "E:/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/ddr3.v"
add_design "E:/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/dvi_tx/dvi_encoder.v"
add_design "E:/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/dvi_tx/encode.v"
add_design "E:/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/dvi_tx/serdes_4b_10to1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/I2c/ax_debounce.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/I2c/key_debounce.v"
remove_design -verilog "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/I2c/key_debounce.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/i2c_master/i2c_config.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/i2c_master/i2c_master_bit_ctrl.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/i2c_master/i2c_master_byte_ctrl.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/i2c_master/i2c_master_defines.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/i2c_master/i2c_master_top.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/i2c_master/timescale.v"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
add_design E:/14_1_ddr3_ov5640_hdmi/ipcore/afifo_16i_64o_512/afifo_16i_64o_512.idf
add_design E:/14_1_ddr3_ov5640_hdmi/ipcore/ddr3_ov5640_hdmi/ddr3_ov5640_hdmi.idf
remove_design -force E:/14_1_ddr3_ov5640_hdmi/ipcore/ddr3_ov5640_hdmi/ddr3_ov5640_hdmi.idf
add_design E:/14_1_ddr3_ov5640_hdmi/ipcore/afifo_64i_16o_128/afifo_64i_16o_128.idf
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
remove_design -verilog "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/I2c/ax_debounce.v"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
add_constraint "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/ddr3_ov5640_hdmi.fdc"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
add_constraint "E:/14_1_ddr3_ov5640_hdmi/ddr3_ov5640_hdmi.fdc"
remove_constraint  -logic -fdc "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/ddr3_ov5640_hdmi.fdc"
remove_design -verilog "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/i2c_master/i2c_config.v"
remove_design -verilog "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/i2c_master/i2c_master_bit_ctrl.v"
remove_design -verilog "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/i2c_master/i2c_master_byte_ctrl.v"
remove_design -verilog "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/i2c_master/i2c_master_defines.v"
remove_design -verilog "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/i2c_master/i2c_master_top.v"
remove_design -verilog "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/i2c_master/timescale.v"
add_design "E:/14_1_ddr3_ov5640_hdmi/source/i2c_master/i2c_config.v"
add_design "E:/14_1_ddr3_ov5640_hdmi/source/i2c_master/i2c_master_bit_ctrl.v"
add_design "E:/14_1_ddr3_ov5640_hdmi/source/i2c_master/i2c_master_byte_ctrl.v"
add_design "E:/14_1_ddr3_ov5640_hdmi/source/i2c_master/i2c_master_defines.v"
add_design "E:/14_1_ddr3_ov5640_hdmi/source/i2c_master/i2c_master_top.v"
add_design "E:/14_1_ddr3_ov5640_hdmi/source/i2c_master/timescale.v"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/aq_axi_master.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/cmos_8_16bit.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/cmos_write_req_gen.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/color_bar.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/frame_fifo_read.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/frame_fifo_write.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/frame_read_write.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/lut_ov5640_rgb565_1024_768.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/top.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/video_define.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/video_timing_data.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_ddrc_apb_reset_v1_1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_ddrc_reset_ctrl_v1_1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_ddrc_top_v1_1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_ddrphy_dll_update_ctrl_v1_1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_ddrphy_reset_ctrl_v1_1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_ddrphy_training_ctrl_v1_1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_ddrphy_update_ctrl_v1_1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_phy_io_v1_1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_phy_top_v1_1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/pll/pll_50_400_v1_1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/dvi_tx/dvi_encoder.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/dvi_tx/encode.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/dvi_tx/serdes_4b_10to1.v"
remove_design -verilog "E:/PGL22G/demo/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/aq_axi_master.v"
remove_design -verilog "E:/PGL22G/demo/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/cmos_8_16bit.v"
remove_design -verilog "E:/PGL22G/demo/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/cmos_write_req_gen.v"
remove_design -verilog "E:/PGL22G/demo/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/color_bar.v"
remove_design -verilog "E:/PGL22G/demo/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/frame_fifo_read.v"
remove_design -verilog "E:/PGL22G/demo/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/frame_fifo_write.v"
remove_design -verilog "E:/PGL22G/demo/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/frame_read_write.v"
remove_design -verilog "E:/PGL22G/demo/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/lut_ov5640_rgb565_1024_768.v"
remove_design -verilog "E:/PGL22G/demo/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/top.v"
remove_design -verilog "E:/PGL22G/demo/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/video_define.v"
remove_design -verilog "E:/PGL22G/demo/soft_pango/CD/demo/14_1_ddr3_ov5640_hdmi/source/sources_1/video_timing_data.v"
remove_design -verilog "E:/PGL22G/demo/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/rtl/pll/pll_50_400_v1_1.v"
remove_design -verilog "E:/PGL22G/demo/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/rtl/ipsl_hmic_h_ddrc_apb_reset_v1_1.v"
remove_design -verilog "E:/PGL22G/demo/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/rtl/ipsl_hmic_h_ddrc_reset_ctrl_v1_1.v"
remove_design -verilog "E:/PGL22G/demo/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/rtl/ipsl_hmic_h_ddrc_top_v1_1.v"
remove_design -verilog "E:/PGL22G/demo/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/rtl/ipsl_hmic_h_ddrphy_dll_update_ctrl_v1_1.v"
remove_design -verilog "E:/PGL22G/demo/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/rtl/ipsl_hmic_h_ddrphy_reset_ctrl_v1_1.v"
remove_design -verilog "E:/PGL22G/demo/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/rtl/ipsl_hmic_h_ddrphy_training_ctrl_v1_1.v"
remove_design -verilog "E:/PGL22G/demo/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/rtl/ipsl_hmic_h_ddrphy_update_ctrl_v1_1.v"
remove_design -verilog "E:/PGL22G/demo/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/rtl/ipsl_hmic_h_phy_io_v1_1.v"
remove_design -verilog "E:/PGL22G/demo/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/rtl/ipsl_hmic_h_phy_top_v1_1.v"
remove_design -verilog "E:/PGL22G/demo/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/ddr3.v"
remove_design -verilog "E:/PGL22G/demo/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/dvi_tx/dvi_encoder.v"
remove_design -verilog "E:/PGL22G/demo/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/dvi_tx/encode.v"
remove_design -verilog "E:/PGL22G/demo/PGL22G/demo/13_1_picture_hdmi/13_1_picture_hdmi/source/dvi_tx/serdes_4b_10to1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/ddr3/ddr3.v"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
remove_design -verilog "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/ddr3/ddr3.v"
remove_design -verilog "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/pll/pll_50_400_v1_1.v"
remove_design -verilog "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_phy_top_v1_1.v"
remove_design -verilog "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_ddrc_top_v1_1.v"
remove_design -verilog "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_phy_io_v1_1.v"
remove_design -verilog "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_ddrphy_update_ctrl_v1_1.v"
remove_design -verilog "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_ddrphy_training_ctrl_v1_1.v"
remove_design -verilog "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_ddrphy_reset_ctrl_v1_1.v"
remove_design -verilog "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_ddrphy_dll_update_ctrl_v1_1.v"
remove_design -verilog "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_ddrc_reset_ctrl_v1_1.v"
remove_design -verilog "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_ddrc_apb_reset_v1_1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_ddrc_apb_reset_v1_1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_ddrc_reset_ctrl_v1_1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_ddrc_top_v1_1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_ddrphy_dll_update_ctrl_v1_1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_ddrphy_reset_ctrl_v1_1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_ddrphy_training_ctrl_v1_1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_ddrphy_update_ctrl_v1_1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_phy_io_v1_1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/rtl/ipsl_hmic_h_phy_top_v1_1.v"
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/ddr3/ddr3.v"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
add_design "E:/PGL22G/demo/14_1_ddr3_ov5640_hdmi/source/pll/pll_50_400_v1_1.v"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
synthesize -ads -selected_syn_tool_opt 2 
synthesize -ads -selected_syn_tool_opt 2 
synthesize -ads -selected_syn_tool_opt 2 
synthesize -ads -selected_syn_tool_opt 2 
synthesize -ads -selected_syn_tool_opt 2 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
add_fic "E:/Arm/purple_light/14_1_ddr3_ov5640_hdmi/synthesize/top_syn.fic"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
remove_fic "E:/Arm/purple_light/14_1_ddr3_ov5640_hdmi/synthesize/top_syn.fic"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
add_fic "E:/Arm/purple_light/14_1_ddr3_ov5640_hdmi/synthesize/top_syn.fic"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
dev_map 
pnr 
report_timing 
gen_bit_stream 
add_simulation "E:/Arm/purple_light/14_1_ddr3_ov5640_hdmi/source/fifo_tb.v"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
remove_simulation "E:/Arm/purple_light/14_1_ddr3_ov5640_hdmi/source/fifo_tb.v"
add_simulation "E:/Arm/purple_light/14_1_ddr3_ov5640_hdmi/source/fifo_tb.v"
add_simulation "E:/Arm/purple_light/14_1_ddr3_ov5640_hdmi/source/frame_write_read.v"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
add_simulation "E:/Arm/purple_light/14_1_ddr3_ov5640_hdmi/ipcore/afifo_16i_64o_512/afifo_16i_64o_512_tb.v"
dev_map 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
remove_design -verilog "E:/Arm/purple_light/14_1_ddr3_ov5640_hdmi/source/i2c_master/i2c_config.v"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
remove_fic "E:/Arm/purple_light/14_1_ddr3_ov5640_hdmi/synthesize/top_syn.fic"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
pnr 
report_timing 
gen_bit_stream 
add_fic "E:/Arm/purple_light/14_1_ddr3_ov5640_hdmi/synthesize/top_syn.fic"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
remove_simulation "E:/Arm/purple_light/ddr3_hdmi/ipcore/afifo_16i_64o_512/afifo_16i_64o_512_tb.v"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
dev_map 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
remove_fic "E:/Arm/purple_light/ddr3_hdmi/synthesize/top_syn.fic"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
add_design "E:/Arm/purple_light/ddr3_hdmi_v3/ddr3_hdmi/source/rgb_to_ycbcr.v"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
add_design "E:/Arm/purple_light/ddr3_hdmi_v3/ddr3_hdmi/source/fenqu.v"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
add_design "E:/Arm/purple_light/ddr3_hdmi_v3/ddr3_hdmi/source/pingjun.v"
add_design "E:/Arm/purple_light/ddr3_hdmi_v3/ddr3_hdmi/source/detect.v"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
add_design "E:/Arm/purple_light/ddr3_hdmi_v3/ddr3_hdmi/source/write_spi_buf.v"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 
report_power 
gen_netlist 
add_design "E:/Arm/purple_light/ddr3_hdmi_v3/ddr3_hdmi/source/MBI5353_top.v"
add_design "E:/Arm/purple_light/ddr3_hdmi_v3/ddr3_hdmi/source/sys_clk.v"
add_design "E:/Arm/purple_light/ddr3_hdmi_v3/ddr3_hdmi/source/CLK.v"
add_design "E:/Arm/purple_light/ddr3_hdmi_v3/ddr3_hdmi/source/spi.v"
add_design "E:/Arm/purple_light/ddr3_hdmi_v3/ddr3_hdmi/source/MBI5353.v"
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
remove_design -force -verilog "E:/Arm/purple_light/ddr3_hdmi_v3/ddr3_hdmi/source/MBI5353_top.v"
add_design "C:/Users/Travmly/Desktop/ddr3_hdmi_fenqu/ddr3_hdmi_v3/ddr3_hdmi/source/sources_1/CLK.v"
add_design "C:/Users/Travmly/Desktop/ddr3_hdmi_fenqu/ddr3_hdmi_v3/ddr3_hdmi/source/sources_1/fifo_wr.v"
add_design "C:/Users/Travmly/Desktop/ddr3_hdmi_fenqu/ddr3_hdmi_v3/ddr3_hdmi/source/sources_1/LED_IC.v"
add_design "C:/Users/Travmly/Desktop/ddr3_hdmi_fenqu/ddr3_hdmi_v3/ddr3_hdmi/source/sources_1/MBI5353.v"
remove_design -force -verilog "E:/Arm/purple_light/ddr3_hdmi_v3/ddr3_hdmi/source/spi.v"
add_design E:/Arm/purple_light/ddr3_hdmi_v3/ddr3_hdmi/ipcore/fifo_generator_0/fifo_generator_0.idf
set_arch -family Logos -device PGL22G -speedgrade -6 -package MBG324
compile -top_module top
synthesize -ads -selected_syn_tool_opt 2 
dev_map 
pnr 
report_timing 
gen_bit_stream 