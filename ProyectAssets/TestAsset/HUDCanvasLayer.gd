extends CanvasLayer

var corazon_lleno_tex = preload("res://Sprites/Corazon_lleno.png")
var corazon_vacio_tex = preload("res://Sprites/Corazon_Vacio.png")
var corazon_Medio_tex = preload("res://Sprites/Corazon_Mitad.png")
func actualizar(corazones):
	for i in range(0,get_node("HBoxContainer").get_children().size()):
		var corazon = get_node("HBoxContainer/Corazon_" + str(i))
		if (i + 1) > corazones:
			corazon.texture = corazon_vacio_tex
		else:
			corazon.texture =  corazon_lleno_tex