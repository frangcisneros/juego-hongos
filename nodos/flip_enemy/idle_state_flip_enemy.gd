extends State

class_name idle_state_flip_enemy

var StateActive : bool = false
#var player = null
#var player_vision = false

@export var player_position = Vector2.ZERO
@onready var Enemigo = get_parent().Enemigo

@onready var raycast = Enemigo.get_node("RayCast2D")
@onready var vision = Enemigo.get_node("vision_flip_enemy")

var decabeza_gravity = - ProjectSettings.get_setting("physics/2d/default_gravity")

var primera_vez = false

var first_object = false

var primera_posicion = false

var posicion_inicial = Vector2.ZERO

var first_detection = false


func Enter():
	StateActive = true

func Exit():
	StateActive = false
	
func Update(_delta : float):
	if(Enemigo.health <= 0):
		Enemigo.set_rotation_degrees(180)
		Transition.emit(self, "dead_state_flip_enemy")
	if raycast.get_collider_rid().is_valid() and not primera_vez:
		first_object = raycast.get_collider()
		primera_vez = true
	if Enemigo.is_on_ceiling() and not primera_posicion:
		posicion_inicial = Enemigo.global_position
		primera_posicion = true
	StateActive = true
	

func UpdatePhysics(delta : float):
	Enemigo.velocity.y += decabeza_gravity * delta
	if Enemigo.is_on_ceiling() and primera_posicion:
		Enemigo.position = posicion_inicial

func _on_deteccion_body_entered(body):
	if body.has_method("player") and not first_detection and Enemigo.is_on_ceiling():
		player_position = body.position
		if vision.vision_player(player_position):
			Transition.emit(self, "attack_state_flip_enemy")


