view wave 
wave clipboard store
wave create -pattern none -portmode in -language vhdl /pid_regler_wrapped/i_clk 
wave create -pattern none -portmode in -language vhdl /pid_regler_wrapped/i_rst 
wave create -pattern none -portmode in -language vhdl -range data_width 1 /pid_regler_wrapped/i_data_soll 
wave create -pattern none -portmode in -language vhdl -range data_width 1 /pid_regler_wrapped/i_data_ist 
wave create -pattern none -portmode out -language vhdl -range data_width 1 /pid_regler_wrapped/o_data_y 
wave create -pattern none -portmode out -language vhdl -range data_width 1 /pid_regler_wrapped/o_data_y 
wave modify -driver freeze -pattern constant -value 0010000010010000 -range 15 0 -starttime 0ns -endtime 1000ns Edit:/pid_regler_wrapped/i_data_soll 
wave modify -driver freeze -pattern constant -value 0010000000010000 -range 15 0 -starttime 0ns -endtime 1000ns Edit:/pid_regler_wrapped/i_data_ist 
wave modify -driver freeze -pattern constant -value 0 -starttime 0ns -endtime 1000ns Edit:/pid_regler_wrapped/i_rst 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 500ps -dutycycle 50 -starttime 0ns -endtime 1000ns Edit:/pid_regler_wrapped/i_clk 
wave modify -driver freeze -pattern constant -value 0010000010010000 -range 15 0 -starttime 500ns -endtime 1000ns Edit:/pid_regler_wrapped/i_data_ist 
wave modify -driver freeze -pattern constant -value 0011000010010000 -range 15 0 -starttime 600ns -endtime 1000ns Edit:/pid_regler_wrapped/i_data_ist 
WaveCollapseAll -1
wave clipboard restore
