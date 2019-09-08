extends Node2D

func _ready():
	pass 

func _on_espada_body_entered(body):
	if body.has_method("recibir_golpe"):
		body.recibir_golpe(position.x)