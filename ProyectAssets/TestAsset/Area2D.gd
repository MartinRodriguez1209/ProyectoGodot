extends Area2D

var nivel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.has_method("disparar"):
		if nivel == 1:
			get_tree().change_scene("res://Niveles/nivel2.tscn")
		if nivel == 2:
			get_tree().change_scene("res://Niveles/nivel3.tscn")
		if nivel == 3:
			print("win")


