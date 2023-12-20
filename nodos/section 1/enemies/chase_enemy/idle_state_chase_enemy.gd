extends State

class_name idle_state_chase_enemy

var StateActive: bool = false
var player = null
var player_chase = false

@onready var Enemigo = get_parent().Enemigo
@onready var vision = Enemigo.get_node("vision_chase_enemy")


func Enter():
	Enemigo.velocity = Vector2.ZERO
	StateActive = true


func Exit():
	StateActive = false


func Update(_delta: float):
	if Enemigo.health <= 0:
		Enemigo.set_rotation_degrees(180)
		Transition.emit(self, "dead_state_chase_enemy")


func UpdatePhysics(_delta: float):
	if not Enemigo.is_on_floor():
		Enemigo.velocity.y += Enemigo.gravity * _delta


func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		player = body  # setea al player como el cuerpo que entro al area
		if vision.vision_player(body.position):
			Transition.emit(self, "chasing_state_chase_enemy")
