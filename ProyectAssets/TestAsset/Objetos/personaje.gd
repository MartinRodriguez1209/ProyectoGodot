extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mov = Vector2()
var velmax = 256
var limit
var grav = 100
export (float) var max_vida = 100
onready var vida = max_vida setget set_vida


const UP = Vector2(0,-1)
export(int) var vel
# Called when the node enters the scene tree for the first time.
func _ready():
	limit = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var friction = false
	
	mov = Vector2()
	mov.y = -20
	if Input.is_action_pressed("ui_right"):
		mov.x = velmax
	
	if Input.is_action_pressed("ui_left"):
		mov.x = -velmax
	
	if Input.is_action_pressed("ui_up"):
		mov.y -= 1
	
	if Input.is_action_pressed("ui_down"):
		mov.y += 1
	
	
	
	if mov.length() > 0:
		mov=mov.normalized() * vel
	
	
	
	position += mov * delta
	
	position.x = clamp(position.x,0,limit.x)
	position.y = clamp(position.y,0,limit.y)
	"""
	if mov.x != 0:
		$AnimatedSprite.animation = "lado"
		$AnimatedSprite.flip_h = mov.x < 0
	
	elif mov.y != 0:
		$AnimatedSprite.animation = "parado"
	
	else :
		$AnimatedSprite.animation = "parado"
	
	ParallaxBackground
	"""
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			mov.y = -velmax*2
		if friction == true:
			mov.x = lerp(mov.x, 0, 0.5)
	#if Input.is_action_just_pressed("space"):
		
	mov = move_and_slide(mov, UP) 
	
func dano(monto):
	set_vida(vida - monto)
	
func kill():
	pass
	
func set_vida(value):
	var vida_prev= vida
	vida = clamp(value, 0, max_vida)
	if vida != vida_prev:
		emit_signal("act_vida", vida)
		if vida == 0:
			kill()
			emit_signal("muerto")
	