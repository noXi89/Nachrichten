view wave 
wave clipboard store
wave create -pattern none -portmode in -language vhdl /drehzahlmessung/clock 
wave create -pattern none -portmode in -language vhdl /drehzahlmessung/reset 
wave create -pattern none -portmode in -language vhdl /drehzahlmessung/sig1 
wave create -pattern none -portmode in -language vhdl /drehzahlmessung/sig2 
wave create -pattern none -portmode out -language vhdl /drehzahlmessung/error 
wave create -pattern none -portmode out -language vhdl -range 15 0 /drehzahlmessung/drehzahl 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 1000ps Edit:/drehzahlmessung/reset 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 50ps -dutycycle 50 -starttime 0ps -endtime 1000ps Edit:/drehzahlmessung/clock 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 200ps -dutycycle 50 -starttime 0ps -endtime 1000ps Edit:/drehzahlmessung/sig1 
WaveCollapseAll -1
wave clipboard restore
