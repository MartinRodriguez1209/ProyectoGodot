extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mov = Vector2()
var velmax = 50
var direc = 1
var limit
const UP = Vector2(0,-1)
export(int) var vel
# Called when the node enters the scene tree for the first time.
func _ready():
	limit = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	mov.x=velmax * direc
	mov.y += 100
	mov = move_and_slide(mov,UP)
	
	if is_on_wall():
		direc = direc *-1
		$RayCast2D.position.x += 20 * direc
	
	if direc == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
	
	$AnimatedSprite.play("normal")
	
	
	
	if $RayCast2D.is_colliding() == false: 
		direc = direc *-1
		$RayCast2D.position.x += 20 * direc
	
	