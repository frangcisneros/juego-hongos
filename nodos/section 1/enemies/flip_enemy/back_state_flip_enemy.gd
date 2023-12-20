extends State

class_name back_state_flip_enemy

var StateActive: bool = false

@onready var Enemigo = get_parent().Enemigo


func Enter():
	pass


func Exit():
	pass


func Update(_delta: float):
	pass


func UpdatePhysics(_delta: float):
	if Enemigo.health <= 0:
		Enemigo.set_rotation_degrees(180)
		Transition.emit(self, "dead_state_flip_enemy")
	Enemigo.velocity = (
		Enemigo.position.direction_to(
			Enemigo.get_node("state_machine_flip_enemy/idle_state_flip_enemy").posicion_inicial
		)
		* Enemigo.JUMP_VELOCITY
	)
	if Enemigo.is_on_ceiling():
		Transition.emit(self, "idle_state_flip_enemy")
