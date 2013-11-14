transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

<<<<<<< HEAD
vcom -93 -work work {E:/GitHub/Nachrichten/Projekt/freq_gen.vhd}
vcom -93 -work work {E:/GitHub/Nachrichten/Projekt/Richtungserkennung.vhd}
vcom -93 -work work {E:/GitHub/Nachrichten/Projekt/Drehzahlmessung.vhd}
vcom -93 -work work {E:/GitHub/Nachrichten/Projekt/Anzeige_Richtung.vhd}
vcom -93 -work work {E:/GitHub/Nachrichten/Projekt/Anzeige_Drehzahl.vhd}
=======
vcom -93 -work work {C:/Users/Alex/git/Nachrichten/Projekt/Drehzahlmessung.vhd}
>>>>>>> e0b18bf2b845c06c6b38b9e39ab6ca3d9b70c9b8

