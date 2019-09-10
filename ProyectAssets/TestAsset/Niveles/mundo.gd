extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Musica_ini.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func _on_Musica_loop_finished():
	$Musica_loop.play()


func _on_Musica_ini_finished():
	$Musica_loop.play()


func _on_Caballero_senalmuerto():
	$Musica_ini.stop()
	$Musica_loop.stop()
