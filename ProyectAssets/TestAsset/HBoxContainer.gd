extends HBoxContainer

var corzon_lleno_text = preload("res://Sprites/Corazon_lleno.png")
var corzon_vacio_text = preload("res://Sprites/Corazon_Vacio.png")

func update(corazones):
	
	for corazon in get_node("HBox