extends StaticBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	$Sprite/AnimationPlayer.play("flotar")

func _on_Area2D_body_entered(body):
	if body.has_method("actualizar_vida"):
		if body.vida != 3:
			body.actualizar_vida ()
			get_parent().remove_child(self)



