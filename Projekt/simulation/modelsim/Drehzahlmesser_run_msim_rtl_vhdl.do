transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {E:/GitHub/Nachrichten/Projekt/freq_gen.vhd}
vcom -93 -work work {E:/GitHub/Nachrichten/Projekt/Richtungserkennung.vhd}
vcom -93 -work work {E:/GitHub/Nachrichten/Projekt/Drehzahlmessung.vhd}
vcom -93 -work work {E:/GitHub/Nachrichten/Projekt/Anzeige_Richtung.vhd}
vcom -93 -work work {E:/GitHub/Nachrichten/Projekt/Anzeige_Drehzahl.vhd}

