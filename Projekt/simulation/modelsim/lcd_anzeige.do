onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /drehzahl_lcd_anzeige/clock
add wave -noupdate /drehzahl_lcd_anzeige/reset
add wave -noupdate /drehzahl_lcd_anzeige/error
add wave -noupdate /drehzahl_lcd_anzeige/charposition
add wave -noupdate /drehzahl_lcd_anzeige/drehzahl
add wave -noupdate /drehzahl_lcd_anzeige/richtung
add wave -noupdate -radix ascii /drehzahl_lcd_anzeige/ascii_out
add wave -noupdate /drehzahl_lcd_anzeige/write_enable
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {691666666667 ps} 0}
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
WaveRestoreZoom {0 ps} {262500 us}
view wave 
wave clipboard store
wave create -pattern none -portmode in -language vhdl /drehzahl_lcd_anzeige/clock 
wave create -pattern none -portmode in -language vhdl /drehzahl_lcd_anzeige/reset 
wave create -pattern none -portmode in -language vhdl /drehzahl_lcd_anzeige/error 
wave create -pattern none -portmode in -language vhdl -range 7 0 /drehzahl_lcd_anzeige/charposition 
wave create -pattern none -portmode in -language vhdl -range 15 0 /drehzahl_lcd_anzeige/drehzahl 
wave create -pattern none -portmode in -language vhdl /drehzahl_lcd_anzeige/richtung 
wave create -pattern none -portmode out -language vhdl -range 7 0 /drehzahl_lcd_anzeige/ascii_out 
wave create -pattern none -portmode out -language vhdl /drehzahl_lcd_anzeige/write_enable 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 100us -dutycycle 50 -starttime 0ms -endtime 2000ms Edit:/drehzahl_lcd_anzeige/clock 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ms -endtime 2000ms Edit:/drehzahl_lcd_anzeige/reset 
wave modify -driver freeze -pattern constant -value 0 -starttime 0ms -endtime 2000ms Edit:/drehzahl_lcd_anzeige/error 
wave modify -driver freeze -pattern counter -startvalue 00000000 -endvalue 10011111 -type Range -direction Up -period 10ms -step 1 -repeat forever -range 7 0 -starttime 0ms -endtime 2000ms Edit:/drehzahl_lcd_anzeige/charposition 
wave modify -driver freeze -pattern constant -value 0011100110100100 -range 15 0 -starttime 0ms -endtime 2000ms Edit:/drehzahl_lcd_anzeige/drehzahl 
wave modify -driver freeze -pattern constant -value 0 -starttime 0ms -endtime 2000ms Edit:/drehzahl_lcd_anzeige/richtung 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 1ms -dutycycle 50 -starttime 0ms -endtime 2000ms Edit:/drehzahl_lcd_anzeige/clock 
WaveCollapseAll -1
wave clipboard restore
