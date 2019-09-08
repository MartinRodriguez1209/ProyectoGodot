extends Node2D

const mov = Vector2(300,0)

var direccion = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.

func _process(delta):
	mover(delta)
	
func _ready():
	pass # Replace with function body.

func init(direc):
	direccion = direc

func mover(delta):
	global_position += mov * delta * direccion



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.has_method("recibir_golpe"):
		body.recibir_golpe(position.x)
		get_parent().remove_child(self)



