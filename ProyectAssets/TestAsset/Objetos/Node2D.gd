extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mov = Vector2()
var velmax = 300
var limit
var vivo = 1
var direc = 1
var knock = 50

var vida = 3
onready var tiempo_invulnerabilidad = $contador_invul

const UP = Vector2(0,-1)
export(int) var vel
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("HUD/HUDCanvasLayer").actualizar(vida)
	limit = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	

	if vivo == 1:
		var friction = false
		mov.y += 100
		if Input.is_action_pressed("ui_right"):
			direc = 1
			mov.x = velmax
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("lado")
			$espada/espada/Sprite.flip_h = false
		
		
		elif Input.is_action_pressed("ui_left"):
			direc = -1
			mov.x = -velmax
			$espada/espada.position *= Vector2(-1,0)
			$AnimatedSprite.play("lado")
			$AnimatedSprite.flip_h = true
			$espada/espada/Sprite.flip_h = true
			
		
		
		
		else:
			$AnimatedSprite.play("parado")
			friction = true
		
		
		
		
		"""
		position += mov * delta
		
		position.x = clamp(position.x,0,limit.x)
		position.y = clamp(position.y,0,limit.y)
		"""
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				mov.y += -velmax*5
			if friction == true:
				mov.x = lerp(mov.x, 0, 0.5)
		if Input.is_action_just_pressed("space"):
			if direc == 1:
				$espada/espada/AnimationPlayer.play("golpe")
			else:
				$espada/espada/AnimationPlayer.play("golpe_izquierda")
		
		mov = move_and_slide(mov,UP)
	else:
		pass
	
func dano(lado,monto = 1):
	lado = position.x - lado
	vida -= monto
	if lado > 0:
		mov.x = 500 
		mov.y = -600 
	else :
		mov.x = -500 
		mov.y = -600 
	get_node("HUD/HUDCanvasLayer").actualizar(vida)
	if vida == 0:
		kill()
	else:
		$AnimationPlayer.play("dano")
	
func kill():
	print("Game Over Man!")
	vivo = 0
	$AnimationPlayer.play("muerto")
	$AnimatedSprite.play("parado")
	

