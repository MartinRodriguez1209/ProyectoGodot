extends KinematicBody2D

const caballero = preload("res://Jugador/caballero.tscn")
var vivo =1
var velmax = 40
var vida = 10
var mov = Vector2()
const UP = Vector2(0,-1)
var control = 1
var sentido = 1
var flag_caminar = 1
var flag_espera = 1
var sprite_sentido = -1

func _ready():
	pass

func _process(delta):
	
	if vivo == 1:
		if sentido == 1 :
			$area_ataque_cola.position.x = 25.698
			$area_ataque_fuego.position.x = 56.069
			$deteccion_cola.position.x = 36.313
			$deteccion_fuego.position.x = 125.351
			$area_dano.position.x = 0.353
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.position.x =22.647
		else:
			$area_ataque_cola.position.x = -25.698
			$area_ataque_fuego.position.x = -56.069
			$deteccion_cola.position.x = -36.313
			$deteccion_fuego.position.x = -125.351
			$area_dano.position.x = -0.353
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.position.x = -22.647
		if flag_caminar != 0:
			if flag_espera != 0:
				flag_espera = 0
				$timer_caminar.start()
			mov.y += 100
			mov.x = velmax * sentido
			mov = move_and_slide(mov,UP)
			$deteccion_cola.get_overlapping_bodies()
		if $deteccion_cola.get_overlapping_bodies().front() != null:
			_on_deteccion_cola_body_entered($deteccion_cola.get_overlapping_bodies().front())
		if $deteccion_fuego.get_overlapping_bodies().front() != null:
			_on_deteccion_fuego_body_entered($deteccion_fuego.get_overlapping_bodies().front())
	else:
		pass

func _on_area_dano_body_entered(body):
	if (body.has_method("_golpe")):
		body._golpe()
	if(body.has_method("dano")):
		body.dano(position.x)

func recibir_golpe(lado):
	lado = position.x - lado
	vida -= 1
	if(vida == 0):
		print("muerto")
		$AnimationPlayer.play("muerte")
		vivo = 0
		$AnimatedSprite.play("muerto")
	else:
		$AnimationPlayer.play("dano")
		mov.y = -800

func _on_deteccion_cola_body_entered(body): #Detecta si hay enemigo en el radio de la cola y hace el ataque
	if control == 1 :
		if(body.has_method("dano")):
			control = 0
			$AnimationPlayer.play("ataquecola")
			$AnimatedSprite.play("ataquecola")
			$timer_cola.start()
	else:
		pass

func _on_area_ataque_cola_body_entered(body):#si la cola golpeo inflige daño
	if(body.has_method("dano")):
		body.dano(position.x)

func _on_deteccion_fuego_body_entered(body): #Detecta si hay enemigo en el radio del fuegoy ataca
	if control == 1:
		if(body.has_method("dano")):
			control = 0
			$AnimationPlayer.play("ataquefuego")
			$AnimatedSprite.play("fuego")
			$AudioStreamPlayer.play()
			$timer_fuego.start()
	else:
		pass

func _on_area_ataque_fuego_body_entered(body):
	if(body.has_method("dano")):
		body.dano(position.x)

func _on_timer_cola_timeout():
	$timer_cola.stop()
	control = 1

func _on_timer_fuego_timeout():
	$timer_fuego.stop()
	control = 1

func position():
	return position.x

func _on_timer_caminar_timeout():
	flag_caminar = 0
	flag_espera = 0
	$timer_espera.stop()
	$timer_espera.start()

func _on_timer_espera_timeout():
	flag_caminar = 1
	flag_espera = 1
	$timer_espera.stop()