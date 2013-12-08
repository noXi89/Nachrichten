onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /freq_gen/clk20Hz
add wave -noupdate /freq_gen/clk1MHz
add wave -noupdate /freq_gen/clkLCD
add wave -noupdate /freq_gen/clk50mhz
add wave -noupdate /freq_gen/reset
add wave -noupdate /freq_gen/count1
add wave -noupdate /freq_gen/count2
add wave -noupdate /freq_gen/count3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
configure wave -timelineunits sec
update
WaveRestoreZoom {0 ps} {10500 ms}
view wave 
wave clipboard store
wave create -pattern none -portmode in -language vhdl /freq_gen/clk50mhz 
wave create -pattern none -portmode in -language vhdl /freq_gen/reset 
wave create -pattern none -portmode out -language vhdl /freq_gen/clk20Hz 
wave create -pattern none -portmode out -language vhdl /freq_gen/clk1MHz 
wave create -pattern none -portmode out -language vhdl /freq_gen/clkLCD 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 10ms -dutycycle 5 -starttime 0ms -endtime 1000ms Edit:/freq_gen/clk50mhz 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ms -endtime 1000ms Edit:/freq_gen/reset 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 5ms -dutycycle 10 -starttime 0ms -endtime 10000ms Edit:/freq_gen/clk50mhz 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ms -endtime 10000ms Edit:/freq_gen/reset 
WaveCollapseAll -1
wave clipboard restore
