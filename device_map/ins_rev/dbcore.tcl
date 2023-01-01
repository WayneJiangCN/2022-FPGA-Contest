add_design -verilog "E:/Arm/purple_light/ddr3_hdmi/device_map/ins_rev/cores.v"
add_design -verilog "D:/pango/PDS_2020.3-Lite/arch/vendor/pango/arch/cdt/debug_core_rtls_pdir/ips_dbc_cfg_reg_file_v1_0.vp"
add_design -verilog "D:/pango/PDS_2020.3-Lite/arch/vendor/pango/arch/cdt/debug_core_rtls_pdir/ips_dbc_compare_256b_v1_0.vp"
add_design -verilog "D:/pango/PDS_2020.3-Lite/arch/vendor/pango/arch/cdt/debug_core_rtls_pdir/ips_dbc_data_capture_mem_v1_1.vp"
add_design -verilog "D:/pango/PDS_2020.3-Lite/arch/vendor/pango/arch/cdt/debug_core_rtls_pdir/ips_dbc_debug_core_v1_4.vp"
add_design -verilog "D:/pango/PDS_2020.3-Lite/arch/vendor/pango/arch/cdt/debug_core_rtls_pdir/ips_dbc_hub_decode_v1_2.vp"
add_design -verilog "D:/pango/PDS_2020.3-Lite/arch/vendor/pango/arch/cdt/debug_core_rtls_pdir/ips_dbc_rd_addr_gen_v1_3.vp"
add_design -verilog "D:/pango/PDS_2020.3-Lite/arch/vendor/pango/arch/cdt/debug_core_rtls_pdir/ips_dbc_storage_condition_v1_3.vp"
add_design -verilog "D:/pango/PDS_2020.3-Lite/arch/vendor/pango/arch/cdt/debug_core_rtls_pdir/ips_dbc_storage_qualification_v1_2.vp"
add_design -verilog "D:/pango/PDS_2020.3-Lite/arch/vendor/pango/arch/cdt/debug_core_rtls_pdir/ips_dbc_trig_unit_v1_3.vp"
add_design -verilog "D:/pango/PDS_2020.3-Lite/arch/vendor/pango/arch/cdt/debug_core_rtls_pdir/ips_dbc_trigger_condition_v1_3.vp"
add_design -verilog "D:/pango/PDS_2020.3-Lite/arch/vendor/pango/arch/cdt/debug_core_rtls_pdir/ips_dbc_trigger_output_v1_2.vp"
add_design -verilog "D:/pango/PDS_2020.3-Lite/arch/vendor/pango/arch/cdt/debug_core_rtls_pdir/ips_jtag_hub_v1_3.vp"
add_constraint -fdc "E:/Arm/purple_light/ddr3_hdmi/device_map/ins_rev/cores.fdc"
set_arch -family Logos -device PGL22G -package MBG324 -speedgrade -6
compile
synthesize -ADS -disable_io_insertion  -infer_clock_en false
