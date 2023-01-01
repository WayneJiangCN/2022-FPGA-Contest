@echo off
set bin_path=D:/Program_Files/modeltech64_10.4/win64
cd E:/Arm/purple_light/14_1_ddr3_ov5640_hdmi/sim/behav
call "%bin_path%/modelsim"   -do "do {run_behav_compile.tcl};do {run_behav_simulate.tcl}" -l run_behav_simulate.log
if "%errorlevel%"=="1" goto END
if "%errorlevel%"=="0" goto SUCCESS
:END
exit 1
:SUCCESS
exit 0
