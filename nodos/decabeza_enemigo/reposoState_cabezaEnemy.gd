extends State

class_name ReposoState_cabezaEnemigo

var StateActive : bool = false
var player = null
#var player_vision = false

@export var player_position = Vector2.ZERO
@onready var Enemigo = get_parent().Enemigo

@onready var raycast = Enemigo.get_node("RayCast2D")
@onready var vision = Enemigo.get_node("vision")

var decabeza_gravity = - ProjectSettings.get_setting("physics/2d/default_gravity")

var primera_vez = false

var first_object = false

var primera_posicion = false

var posicion_inicial = Vector2.ZERO

var first_detection = false

var view_distance = 3

func Enter():
	
	StateActive = true

func Exit():
	StateActive = false
	
func Update(_delta : float):
#	print(posicion_inicial)
	if raycast.get_collider_rid().is_valid() and not primera_vez:
		first_object = raycast.get_collider()
		primera_vez = true
	if Enemigo.is_on_ceiling() and not primera_posicion:
		posicion_inicial = Enemigo.global_position
		primera_posicion = true
	StateActive = true
	pass

func UpdatePhysics(delta : float):
	Enemigo.velocity.y += decabeza_gravity * delta
	if Enemigo.is_on_ceiling() and primera_posicion:
		Enemigo.position = posicion_inicial



func _on_deteccion_body_entered(body):
	if body.has_method("player") and not first_detection and Enemigo.is_on_ceiling():
		player_position = body.position
		print(vision_player(player_position))
		print(vision.get_collider())
		vision.force_raycast_update()
		if vision_player(player_position):
			Transition.emit(self, "AtacarState_cabezaEnemy")

func vision_player(position):
	vision.set_target_position((position - Enemigo.global_position)*view_distance)
	if vision.is_colliding() and vision.get_collider().has_method("player"):
		return true
	else:
		return false	
