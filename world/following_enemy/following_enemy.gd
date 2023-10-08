extends CharacterBody2D

var speed = 250
var player_chase = false # si esta persiguiendo o no al psje
var player = null 
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var stop = false

@export var health : float = 20

@onready var sprite_enemigo = $Sprite2D

func _ready():
	pass

func _physics_process(delta): # proceso fisico
	if not is_on_floor():
		velocity.y += gravity * delta
	if player_chase and not stop: # si esta perisguiendo al jugador
		velocity.x = (position.direction_to(player.position) * speed).x
#		position.x += (player.position.x - position.x) / speed # suma a su posicion los metros que lo separan dividido la velocidad en cada iteracion

	move_and_slide()

# detecta si un cuerpo a entrado al area de deteccion
func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		player = body # setea al player como el cuerpo que entro al area
		player_chase = true # setea el siguimiento como verdadero


# detecta si el cuerpo ha salido 
func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		player = null
		player_chase = false

func enemy():
	pass

func hit(damage: int):
	health -= damage
	sprite_enemigo.modulate = Color.from_hsv(0,1-health/20,1)
	
func _process(delta):
	if(health <= 0):
		sprite_enemigo.set_rotation_degrees(180)
		stop = true
