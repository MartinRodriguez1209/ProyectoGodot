extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal golpe
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_espada_body_entered(body):
	if body.has_method("recibir_golpe"):
		body.recibir_golpe(position.x)

func _on_Node2D_golpe():
	pass # Replace with function body.
