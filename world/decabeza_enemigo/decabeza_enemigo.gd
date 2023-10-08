extends CharacterBody2D

const JUMP_VELOCITY = 100.0

var decabeza_gravity = - ProjectSettings.get_setting("physics/2d/default_gravity")
var lanzarse = false
var stop = false
var player = null 
var player_position = null
var first_detection = false

@export var health : float = 20
@onready var sprite_enemigo = $Sprite2D
@onready var raycast = $RayCast2D

#var initial_position = position

func _ready():
	pass
#	var initial_position = position

func _physics_process(delta):
	if is_on_ceiling():
		global_position = raycast.posicion_inicial
	if not is_on_ceiling() and not lanzarse and raycast.primera_posicion:
		velocity.y += decabeza_gravity * delta
	elif not is_on_ceiling() and not lanzarse and not raycast.primera_posicion:
		volver_inicio(raycast.posicion_inicial)
	if lanzarse and not stop:
		velocity = position.direction_to(player_position) * JUMP_VELOCITY

	move_and_slide()

func _on_deteccion_body_entered(body):
	if body.has_method("player") and not first_detection and is_on_ceiling():
		player = body # setea al player como el cuerpo que entro al area
		player_position = body.position
		lanzarse = true # setea el siguimiento como verdadero
		first_detection = true

func _on_hitbox_body_entered(body):
	if body.has_method("plataforma"):
		player = null
		player_position = null
		lanzarse = false
		first_detection = false
		
		

func enemy():
	pass

func hit(damage: int):
	health -= damage
	sprite_enemigo.modulate = Color.from_hsv(0,1-health/20,1)

func volver_inicio(posicion_inicial):
	if position != posicion_inicial:
		velocity = position.direction_to(posicion_inicial) * JUMP_VELOCITY

func _process(delta):

#	print(velocity)
	if(health <= 0):
		sprite_enemigo.set_rotation_degrees(180)







