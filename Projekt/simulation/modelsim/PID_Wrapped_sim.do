onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pid_regler_wrapped/i_clk
add wave -noupdate /pid_regler_wrapped/i_rst
add wave -noupdate -radix decimal /pid_regler_wrapped/i_data_soll
add wave -noupdate -radix decimal -childformat {{/pid_regler_wrapped/i_data_ist(15) -radix decimal} {/pid_regler_wrapped/i_data_ist(14) -radix decimal} {/pid_regler_wrapped/i_data_ist(13) -radix decimal} {/pid_regler_wrapped/i_data_ist(12) -radix decimal} {/pid_regler_wrapped/i_data_ist(11) -radix decimal} {/pid_regler_wrapped/i_data_ist(10) -radix decimal} {/pid_regler_wrapped/i_data_ist(9) -radix decimal} {/pid_regler_wrapped/i_data_ist(8) -radix decimal} {/pid_regler_wrapped/i_data_ist(7) -radix decimal} {/pid_regler_wrapped/i_data_ist(6) -radix decimal} {/pid_regler_wrapped/i_data_ist(5) -radix decimal} {/pid_regler_wrapped/i_data_ist(4) -radix decimal} {/pid_regler_wrapped/i_data_ist(3) -radix decimal} {/pid_regler_wrapped/i_data_ist(2) -radix decimal} {/pid_regler_wrapped/i_data_ist(1) -radix decimal} {/pid_regler_wrapped/i_data_ist(0) -radix decimal}} -subitemconfig {/pid_regler_wrapped/i_data_ist(15) {-height 15 -radix decimal} /pid_regler_wrapped/i_data_ist(14) {-height 15 -radix decimal} /pid_regler_wrapped/i_data_ist(13) {-height 15 -radix decimal} /pid_regler_wrapped/i_data_ist(12) {-height 15 -radix decimal} /pid_regler_wrapped/i_data_ist(11) {-height 15 -radix decimal} /pid_regler_wrapped/i_data_ist(10) {-height 15 -radix decimal} /pid_regler_wrapped/i_data_ist(9) {-height 15 -radix decimal} /pid_regler_wrapped/i_data_ist(8) {-height 15 -radix decimal} /pid_regler_wrapped/i_data_ist(7) {-height 15 -radix decimal} /pid_regler_wrapped/i_data_ist(6) {-height 15 -radix decimal} /pid_regler_wrapped/i_data_ist(5) {-height 15 -radix decimal} /pid_regler_wrapped/i_data_ist(4) {-height 15 -radix decimal} /pid_regler_wrapped/i_data_ist(3) {-height 15 -radix decimal} /pid_regler_wrapped/i_data_ist(2) {-height 15 -radix decimal} /pid_regler_wrapped/i_data_ist(1) {-height 15 -radix decimal} /pid_regler_wrapped/i_data_ist(0) {-height 15 -radix decimal}} /pid_regler_wrapped/i_data_ist
add wave -noupdate -radix decimal /pid_regler_wrapped/o_data_y
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {499292 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 250
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {501797 ps} {502624 ps}
view wave 
wave clipboard store
wave create -pattern none -portmode in -language vhdl /pid_regler_wrapped/i_clk 
wave create -pattern none -portmode in -language vhdl /pid_regler_wrapped/i_rst 
wave create -pattern none -portmode in -language vhdl -range data_width 1 /pid_regler_wrapped/i_data_soll 
wave create -pattern none -portmode in -language vhdl -range data_width 1 /pid_regler_wrapped/i_data_ist 
wave create -pattern none -portmode out -language vhdl -range data_width 1 /pid_regler_wrapped/o_data_y 
wave create -pattern none -portmode in -language vhdl /pid_regler_wrapped/i_clk 
wave create -pattern none -portmode in -language vhdl /pid_regler_wrapped/i_rst 
wave create -pattern none -portmode in -language vhdl -range data_width 1 /pid_regler_wrapped/i_data_soll 
wave create -pattern none -portmode in -language vhdl -range data_width 1 /pid_regler_wrapped/i_data_ist 
wave create -pattern none -portmode out -language vhdl -range data_width 1 /pid_regler_wrapped/o_data_y 
wave modify -driver freeze -pattern constant -value 0010000010010000 -range 15 0 -starttime 0ns -endtime 1000ns Edit:/pid_regler_wrapped/i_data_soll 
wave modify -driver freeze -pattern constant -value 0010000000010000 -range 15 0 -starttime 0ns -endtime 1000ns Edit:/pid_regler_wrapped/i_data_ist 
wave modify -driver freeze -pattern constant -value 0 -starttime 0ns -endtime 1000ns Edit:/pid_regler_wrapped/i_rst 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 500ps -dutycycle 50 -starttime 0ns -endtime 1000ns Edit:/pid_regler_wrapped/i_clk 
wave modify -driver freeze -pattern constant -value 0010000010010000 -range 15 0 -starttime 500ns -endtime 1000ns Edit:/pid_regler_wrapped/i_data_ist 
WaveCollapseAll -1
wave clipboard restore
