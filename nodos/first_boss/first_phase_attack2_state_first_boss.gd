extends State


@onready var Enemigo : CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D
@export var attack_to_first_phase_timer : Timer

var StateActive : bool = false

func Enter():
	attack_to_first_phase_timer.start()
	StateActive = true
	
func Exit():
	StateActive = false
	
func Update(_delta : float):
	if attack_to_first_phase_timer.is_stopped():
		Transition.emit(self,"first_phase_initial_state_boss_first_boss")
	pass
			
func UpdatePhysics(_delta:float):
	pass



