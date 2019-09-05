extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mov = Vector2()
var velmax = 300
var limit
const UP = Vector2(0,-1)
export(int) var vel
# Called when the node enters the scene tree for the first time.
func _ready():
	limit = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var friction = false
	
	mov.y += 100
	if Input.is_action_pressed("ui_right"):
		mov.x = velmax
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("lado")
	
	if Input.is_action_pressed("ui_left"):
		mov.x = -velmax
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("lado")
	
	
	elif Input.is_action_pressed("ui_down"):
		mov.y += 1
		$AnimatedSprite.flip_v=false
		$AnimatedSprite.play("parado")
	
	else:
		$AnimatedSprite.play("parado")
		friction = true
	
	
	
	
	"""
	position += mov * delta
	
	position.x = clamp(position.x,0,limit.x)
	position.y = clamp(position.y,0,limit.y)
	"""
	if is_on_floor():
		if Input.is_action_just_pressed("space"):
			mov.y += -velmax*5
		if friction == true:
			mov.x = lerp(mov.x, 0, 0.5)
	
	mov = move_and_slide(mov,UP)
	
	