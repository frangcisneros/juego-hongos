extends State

class_name idle_state_missile_enemy

@onready var Enemigo = get_parent().Enemigo
@onready var vision = Enemigo.get_node("vision_missile_enemy")

var StateActive: bool = false


func Enter():
	StateActive = true


func Exit():
	StateActive = false


func Update(_delta: float):
	pass


func UpdatePhysics(_delta: float):
	if not Enemigo.is_on_floor():
		Enemigo.velocity.y += Enemigo.gravity * _delta


func _on_detection_area_body_entered(body):
	if body.has_method("player") and vision.vision_player(body.position):
		Transition.emit(self, "atack_state_missile_enemy")
