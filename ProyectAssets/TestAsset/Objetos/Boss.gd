extends KinematicBody2D

const caballero = preload("res://Jugador/caballero.tscn")
var vivo =1
var velmax = 50
var vida = 10
var mov = Vector2()
const UP = Vector2(0,-1)
var control = 1


func _ready():
	pass

func _process(delta):
	if vivo == 1:
		mov.y += 100
		mov = move_and_slide(mov,UP)
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
	if lado > 0: 
		mov.y = -800 
	else :
		mov.y = -800 

func _on_deteccion_cola_body_entered(body): #Detecta si hay enemigo en el radio de la cola y hace el ataque
	if control == 1 :
		if(body.has_method("dano")):
			$AnimationPlayer.play("ataquecola")
			$timer_cola.start()
			control = 0
	else:
		pass

func _on_area_ataque_cola_body_entered(body):#si la cola golpeo inflige daño
	if(body.has_method("dano")):
		body.dano(position.x)


func _on_deteccion_fuego_body_entered(body): #Detecta si hay enemigo en el radio del fuegoy ataca
	if control == 1:
		if(body.has_method("dano")):
			$AnimationPlayer.play("ataquefuego")
			$timer_fuego.start()
			control = 0
	else:
		pass

func _on_area_ataque_fuego_body_entered(body):
	if(body.has_method("dano")):
		body.dano(position.x)


func _on_timer_cola_timeout():
	print("ASSA")
	control = 1

func _on_timer_fuego_timeout():
	print("ASSA")
	control = 1
