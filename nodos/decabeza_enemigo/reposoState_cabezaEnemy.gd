extends State

class_name ReposoState_cabezaEnemigo

var StateActive : bool = false
var player = null

@export var player_position = Vector2.ZERO
@onready var Enemigo = get_parent().Enemigo

@onready var raycast = Enemigo.get_node("RayCast2D")

var decabeza_gravity = - ProjectSettings.get_setting("physics/2d/default_gravity")

var primera_vez = false

var first_object = false

var primera_posicion = false

var posicion_inicial = Vector2.ZERO

var first_detection = false

func Enter():
	if raycast.get_collider_rid().is_valid() and not primera_vez:
		first_object = raycast.get_collider()
		primera_vez = true
	if Enemigo.is_on_ceiling() and not primera_posicion:
		posicion_inicial = Enemigo.global_position
		primera_posicion = true
	StateActive = true
	Enemigo.velocity = Enemigo.position.direction_to(posicion_inicial) * Enemigo.JUMP_VELOCITY

func Exit():
	StateActive = false
	
func Update(_delta : float):
	pass

func UpdatePhysics(delta : float):
	Enemigo.velocity.y += decabeza_gravity * delta
	

func _on_deteccion_body_entered(body):
	if body.has_method("player") and not first_detection and Enemigo.is_on_ceiling():
		player_position = body.position
		Transition.emit(self, "AtacarState_cabezaEnemy")
