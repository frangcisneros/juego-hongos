extends State

class_name attack_state_flip_enemy

var StateActive : bool = false

@onready var Enemigo = get_parent().Enemigo

func Enter():
	StateActive = true

func Exit():
	StateActive = false
	
func Update(_delta : float):
	pass
	
func UpdatePhysics(_delta : float):
	if(Enemigo.health <= 0):
		Enemigo.set_rotation_degrees(180)
		Transition.emit(self, "dead_state_flip_enemy")
	Enemigo.velocity = Enemigo.position.direction_to(Enemigo.get_node("state_machine_flip_enemy/idle_state_flip_enemy").player_position) * Enemigo.JUMP_VELOCITY


func _on_hitbox_body_entered(body):
	Transition.emit(self,"back_state_flip_enemy")
