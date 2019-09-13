extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Musica_ini.play()

func _process(delta):
	if $Boss.position() < $Caballero.position():
		$Boss.sentido = 1
	else:
		$Boss.sentido = -1


func _on_Musica_ini_finished():
	$Musica_loop.play()


func _on_Musica_loop_finished():
	$Musica_loop.play()
