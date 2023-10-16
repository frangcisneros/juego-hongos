extends State

class_name back_state_flip_enemy

var StateActive : bool = false

@onready var Enemigo = get_parent().Enemigo


func Enter():
	pass

func Exit():
	pass
	
func Update(_delta : float):
	pass

func UpdatePhysics(_delta : float):
	Enemigo.velocity = Enemigo.position.direction_to(Enemigo.get_node("stateMachine_cabezaEnemy/reposoState_cabezaEnemy").posicion_inicial) * Enemigo.JUMP_VELOCITY
	if Enemigo.is_on_ceiling():
		Transition.emit(self,"ReposoState_cabezaEnemy")
	
