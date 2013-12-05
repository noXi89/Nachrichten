onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /drehregler/clock
add wave -noupdate /drehregler/reset
add wave -noupdate /drehregler/signal_a
add wave -noupdate /drehregler/signal_b
add wave -noupdate /drehregler/error
add wave -noupdate -radix decimal /drehregler/soll_drehzahl
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 129
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
wave create -pattern none -portmode in -language vhdl /drehregler/clock 
wave create -pattern none -portmode in -language vhdl /drehregler/reset 
wave create -pattern none -portmode in -language vhdl /drehregler/signal_a 
wave create -pattern none -portmode in -language vhdl /drehregler/signal_b 
wave create -pattern none -portmode out -language vhdl /drehregler/error 
wave create -pattern none -portmode out -language vhdl -range 15 0 /drehregler/soll_drehzahl 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 100us -dutycycle 50 -starttime 0ms -endtime 1000ms Edit:/drehregler/clock 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ms -endtime 1000ms Edit:/drehregler/reset 
wave modify -driver freeze -pattern random -initialvalue 0 -period 50ms -random_type Uniform -seed 5 -starttime 0ms -endtime 1000ms Edit:/drehregler/signal_a 
wave modify -driver freeze -pattern repeater -initialvalue 0 -period 50ms -sequence { 0 0 1 1  } -repeat forever -starttime 0ms -endtime 1000ms Edit:/drehregler/signal_a 
wave modify -driver freeze -pattern repeater -initialvalue 0 -period 10ms -sequence { 0 0 1 1  } -repeat forever -starttime 0ms -endtime 1000ms Edit:/drehregler/signal_a 
wave modify -driver freeze -pattern repeater -initialvalue 0 -period 10ms -sequence { 0 1 1 0  } -repeat forever -starttime 0ms -endtime 1000ms Edit:/drehregler/signal_b 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 5ms -dutycycle 10 -starttime 0ms -endtime 1000ms Edit:/drehregler/clock 
wave modify -driver freeze -pattern repeater -initialvalue 0 -period 10ms -sequence { 0 1 1 1  } -repeat forever -starttime 0ms -endtime 1000ms Edit:/drehregler/signal_a 
wave modify -driver freeze -pattern repeater -initialvalue 0 -period 10ms -sequence { 0 0 1 1  } -repeat forever -starttime 0ms -endtime 1000ms Edit:/drehregler/signal_a 
wave modify -driver freeze -pattern repeater -initialvalue 0 -period 10ms -sequence { 0 1 1 0  } -repeat forever -starttime 300ms -endtime 700ms Edit:/drehregler/signal_a 
wave modify -driver freeze -pattern repeater -initialvalue 0 -period 10ms -sequence { 0 0 1 1  } -repeat forever -starttime 300ms -endtime 700ms Edit:/drehregler/signal_b 
WaveCollapseAll -1
wave clipboard restore
