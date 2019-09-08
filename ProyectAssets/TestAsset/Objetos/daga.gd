extends Node2D

const mov = Vector2(300,0)
var direccion = 1

func _process(delta):
	mover(delta)
	
func _ready():
	pass

func init(direc):
	direccion = direc

func mover(delta):
	global_position += mov * delta * direccion

func _on_Area2D_body_entered(body):
	if body.has_method("recibir_golpe"):
		body.recibir_golpe(position.x)
		get_parent().remove_child(self)
