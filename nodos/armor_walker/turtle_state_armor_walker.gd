extends State

class_name turtle_state_armor_walker

var StateActive : bool = false

@onready var Enemigo = get_parent().Enemigo


func Enter():
	StateActive = true

func Exit():
	StateActive = false
	
func Update(_delta : float):
	if(Enemigo.health <= 0):
		Enemigo.set_rotation_degrees(180)
		Enemigo.velocity.x = 0
		Transition.emit(self, "dead_state_walk_enemy")

func UpdatePhysics(_delta : float):
	pass
