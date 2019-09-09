extends KinematicBody2D

const daga = preload("res://Objetos/daga.tscn")
var mov = Vector2()
var velmax = 180
var limit
var vivo = 1
var direc = 1
var knock = 50
var disparos = 3
var control =1
var timer
var vida  = 3
onready var tiempo_invulnerabilidad = $contador_invul
const UP = Vector2(0,-1)
export(int) var vel

func _ready():
	timer = Timer.new()
	timer.set_wait_time(0.1)
	add_child(timer)
	get_node("HUD/HUDCanvasLayer").actualizar(vida)
	limit = get_viewport_rect().size
	timer.connect("timeout", self, "_on_Timer_timeout")

func _physics_process(delta):

	if vivo == 1:
		var friction = false
		mov.y += 100
		if control == 1:
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
			if is_on_floor():
				if Input.is_action_just_pressed("ui_up"):
					mov.y += -velmax*6
					$Salto.play()
				if friction == true:
					mov.x = lerp(mov.x, 0, 0.5)
			if Input.is_action_just_pressed("space"):
				if direc == 1:
					$espada/espada/AnimationPlayer.play("golpe")
				else:
					$espada/espada/AnimationPlayer.play("golpe_izquierda")
			if Input.is_action_just_pressed("A"):
				disparar()
		mov = move_and_slide(mov,UP)
		if position.y > limit.y:
			vivo=0
			kill()
			dano(3)
	else:
		mov.y = 400
		mov.x = 0
		mov = move_and_slide(mov,UP)
	
	

func dano(lado,monto = 1):
	lado = position.x - lado
	vida -= monto
	if lado > 0:
		mov.x = 400 
		mov.y = -600 
	else :
		mov.x = -400 
		mov.y = -600 
	control = 0
	timer.start()
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


func disparar():
	if disparos > 0:
		disparos -= 1
		var bala = daga.instance()
		bala.global_position = global_position
		bala.init(direc)
		get_parent().add_child(bala)
		bala.rotation = 80 * -direc

func _on_Timer_timeout():
	control = 1
