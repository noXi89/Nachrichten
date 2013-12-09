onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /regler_simple/i_clk
add wave -noupdate /regler_simple/i_rst
add wave -noupdate -radix unsigned /regler_simple/i_data_soll
add wave -noupdate -radix unsigned /regler_simple/i_data_ist
add wave -noupdate /regler_simple/debug_diff
add wave -noupdate /regler_simple/add
add wave -noupdate -radix unsigned /regler_simple/o_data_y
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {237 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1 ns}
view wave 
wave clipboard store
wave create -pattern none -portmode in -language vhdl /regler_simple/i_clk 
wave create -pattern none -portmode in -language vhdl /regler_simple/i_rst 
wave create -pattern none -portmode in -language vhdl -range data_width 1 /regler_simple/i_data_soll 
wave create -pattern none -portmode in -language vhdl -range data_width 1 /regler_simple/i_data_ist 
wave create -pattern none -portmode out -language vhdl -range data_width 1 /regler_simple/o_data_y 
wave create -pattern none -portmode out -language vhdl /regler_simple/add 
wave create -pattern none -portmode out -language vhdl -range data_width 1 /regler_simple/o_data_y 
wave modify -driver freeze -pattern constant -value 0000000010010010 -range 15 0 -starttime 0ps -endtime 1000ps Edit:/regler_simple/i_data_soll 
wave modify -driver freeze -pattern counter -startvalue 0000000000000000 -endvalue 1111111111111111 -type Range -direction Up -period 50ps -step 1 -repeat forever -range 15 0 -starttime 0ps -endtime 1000ps Edit:/regler_simple/i_data_ist 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 10ps -dutycycle 50 -starttime 0ps -endtime 1000ps Edit:/regler_simple/i_clk 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 1000ps Edit:/regler_simple/i_rst 
wave modify -driver freeze -pattern counter -startvalue 0000000000000000 -endvalue 1111111111111111 -type Range -direction Up -period 10ps -step 1 -repeat forever -range 15 0 -starttime 0ps -endtime 1000ps Edit:/regler_simple/i_data_ist 
wave modify -driver freeze -pattern counter -startvalue 0000000000000000 -endvalue 1111111111111111 -type Range -direction Up -period 5ps -step 1 -repeat forever -range 15 0 -starttime 0ps -endtime 1000ps Edit:/regler_simple/i_data_ist 
WaveCollapseAll -1
wave clipboard restore
