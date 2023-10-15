extends State

class_name AtacarState_cabezaEnemigo

var StateActive : bool = false

@onready var Enemigo = get_parent().Enemigo
#@onready var player_position = Enemigo.get_node("stateMachine_cabezaEnemy/reposoState_cabezaEnemy").player_position

func Enter():
	StateActive = true

func Exit():
	StateActive = false
	
func Update(_delta : float):
	pass
	
func UpdatePhysics(_delta : float):
	Enemigo.velocity = Enemigo.position.direction_to(Enemigo.get_node("stateMachine_cabezaEnemy/reposoState_cabezaEnemy").player_position) * Enemigo.JUMP_VELOCITY


func _on_hitbox_body_entered(body):
	Transition.emit(self,"back_state_flip_enemy")
