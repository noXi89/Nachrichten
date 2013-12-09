onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /konzept/lcdRS
add wave -noupdate /konzept/CLOCK
add wave -noupdate /konzept/RESET
add wave -noupdate /konzept/SIG1
add wave -noupdate /konzept/SIG2
add wave -noupdate /konzept/lcdRW
add wave -noupdate /konzept/lcdE1
add wave -noupdate /konzept/lcdE2
add wave -noupdate /konzept/debug_1
add wave -noupdate /konzept/debug_2
add wave -noupdate /konzept/BLON_O
add wave -noupdate /konzept/BLON_I
add wave -noupdate /konzept/pwm
add wave -noupdate /konzept/richtung_in
add wave -noupdate /konzept/soll_drehzahl_switchs
add wave -noupdate /konzept/led_soll_richtung
add wave -noupdate /konzept/error_richtung
add wave -noupdate /konzept/error_drehzahl
add wave -noupdate /konzept/lcdData
add wave -noupdate /konzept/LEDS
add wave -noupdate /konzept/SEG1
add wave -noupdate /konzept/SEG2
add wave -noupdate /konzept/SEG3
add wave -noupdate /konzept/SEG4
add wave -noupdate /konzept/SEG5
add wave -noupdate /konzept/SEG6
add wave -noupdate /konzept/SEG8
add wave -noupdate /konzept/SEG9
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 187
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
WaveRestoreZoom {0 ps} {262500 us}
view wave 
wave clipboard store
wave create -pattern none -portmode out -language vhdl /konzept/lcdRS 
wave create -pattern none -portmode in -language vhdl /konzept/CLOCK 
wave create -pattern none -portmode in -language vhdl /konzept/RESET 
wave create -pattern none -portmode in -language vhdl /konzept/SIG1 
wave create -pattern none -portmode in -language vhdl /konzept/SIG2 
wave create -pattern none -portmode out -language vhdl /konzept/lcdRW 
wave create -pattern none -portmode out -language vhdl /konzept/lcdE1 
wave create -pattern none -portmode out -language vhdl /konzept/lcdE2 
wave create -pattern none -portmode out -language vhdl /konzept/debug_1 
wave create -pattern none -portmode out -language vhdl /konzept/debug_2 
wave create -pattern none -portmode out -language vhdl /konzept/BLON_O 
wave create -pattern none -portmode in -language vhdl /konzept/BLON_I 
wave create -pattern none -portmode out -language vhdl /konzept/pwm 
wave create -pattern none -portmode in -language vhdl /konzept/richtung_in 
wave create -pattern none -portmode in -language vhdl -range 15 0 /konzept/soll_drehzahl_switchs 
wave create -pattern none -portmode out -language vhdl /konzept/led_soll_richtung 
wave create -pattern none -portmode out -language vhdl /konzept/error_richtung 
wave create -pattern none -portmode out -language vhdl /konzept/error_drehzahl 
wave create -pattern none -portmode out -language vhdl -range 7 0 /konzept/lcdData 
wave create -pattern none -portmode out -language vhdl -range 17 0 /konzept/LEDS 
wave create -pattern none -portmode out -language vhdl -range 6 0 /konzept/SEG1 
wave create -pattern none -portmode out -language vhdl -range 6 0 /konzept/SEG2 
wave create -pattern none -portmode out -language vhdl -range 6 0 /konzept/SEG3 
wave create -pattern none -portmode out -language vhdl -range 6 0 /konzept/SEG4 
wave create -pattern none -portmode out -language vhdl -range 6 0 /konzept/SEG5 
wave create -pattern none -portmode out -language vhdl -range 6 0 /konzept/SEG6 
wave create -pattern none -portmode out -language vhdl -range 7 0 /konzept/SEG8 
wave create -pattern none -portmode out -language vhdl -range 7 0 /konzept/SEG9 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 100us -dutycycle 50 -starttime 0ms -endtime 1000ms Edit:/konzept/CLOCK 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ms -endtime 1000ms Edit:/konzept/RESET 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 100us -dutycycle 50 -starttime 0ms -endtime 1000ms Edit:/konzept/SIG1 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 100us -dutycycle 50 -starttime 50ms -endtime 1000ms Edit:/konzept/SIG2 
wave modify -driver freeze -pattern constant -value 1000101001001011 -range 15 0 -starttime 0ms -endtime 1000ms Edit:/konzept/soll_drehzahl_switchs 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 10ms -dutycycle 50 -starttime 0ms -endtime 1000ms Edit:/konzept/CLOCK 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 100ms -dutycycle 50 -starttime 0ms -endtime 1000ms Edit:/konzept/SIG1 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 10ms -dutycycle 50 -starttime 5ms -endtime 1000ms Edit:/konzept/SIG2 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 100ms -dutycycle 50 -starttime 50ms -endtime 1000ms Edit:/konzept/SIG2 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 100ms -dutycycle 50 -starttime 50ms -endtime 1000ms Edit:/konzept/SIG2 
WaveCollapseAll -1
wave clipboard restore
