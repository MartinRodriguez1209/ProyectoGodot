extends KinematicBody2D

var mov = Vector2()
var velmax = 50
var direc = 1
var vida = 2
var limit
var vivo = 1
var init
var fin
var posx
const UP = Vector2(0,-1)
export(int) var vel

func _ready():
	limit = get_viewport_rect().size
	connect("golpe",self,"_recibir_golpe")
	init = position.y
	posx=  position.x

func _physics_process(delta):
	
	position.x = posx
	
	if vivo == 1 : 
		
		if position.y <= init + 50:
			mov.y +=10
		if position.y >= init + 50:
			mov.y -= 10
			
		mov = move_and_slide(mov,UP)
		
		if is_on_wall():
			direc = direc *-1
			
		
		if direc == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
		
		$AnimatedSprite.play("cabeza flotando")
		
	else:
		$CollisionShape2D.disabled = true
		$Area_dano/CollisionShape2D.disabled = true 
		
func recibir_golpe(lado):
	lado = position.x - lado
	vida -= 1
	if(vida == 0):
		print("muerto")
		vivo = 0
		
	else:
		print("Ouch!")
 


func _on_Area_dano_body_entered(body):
	if (body.has_method("_golpe")):
		body._golpe()
	if(body.has_method("dano")):
		body.dano(position.x)
