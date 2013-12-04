onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pwm_gen/clock
add wave -noupdate /pwm_gen/reset
add wave -noupdate /pwm_gen/drehzahl
add wave -noupdate /pwm_gen/richtung
add wave -noupdate /pwm_gen/pwm
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18304278922 ps} 0}
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
WaveRestoreZoom {0 ps} {1050 ms}
view wave 
wave clipboard store
wave create -pattern none -portmode in -language vhdl /pwm_gen/clock 
wave create -pattern none -portmode in -language vhdl /pwm_gen/reset 
wave create -pattern none -portmode in -language vhdl -range 15 0 /pwm_gen/drehzahl 
wave create -pattern none -portmode in -language vhdl /pwm_gen/richtung 
wave create -pattern none -portmode out -language vhdl /pwm_gen/pwm 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 100us -dutycycle 50 -starttime 0ms -endtime 1000ms Edit:/pwm_gen/clock 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 1000ps Edit:/pwm_gen/reset 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ms -endtime 1000ms Edit:/pwm_gen/reset 
wave modify -driver freeze -pattern counter -startvalue 0000000000000000 -endvalue 1111111111111111 -type Range -direction Up -period 50ms -step 1 -repeat forever -range 15 0 -starttime 0ms -endtime 1000ms Edit:/pwm_gen/drehzahl 
wave modify -driver freeze -pattern counter -startvalue 0 -endvalue 1 -type Range -direction Up -period 500ms -step 1 -repeat forever -starttime 0ms -endtime 1000ms Edit:/pwm_gen/richtung 
WaveCollapseAll -1
wave clipboard restore
