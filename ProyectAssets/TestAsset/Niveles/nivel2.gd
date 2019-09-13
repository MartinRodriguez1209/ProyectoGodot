extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Audioini.play()
	$Puerta.nivel=2

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Audioini_finished():
	$Audioloop.play()


func _on_Audioloop_finished():
	$Audioloop.play()


func _on_Caballero_senalmuerto():
	$Audioini.stop()
	$Audioloop.stop()
