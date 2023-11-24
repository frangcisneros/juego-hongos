extends State


@onready var Enemigo : CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D
@export var first_phase_to_attack_timer : Timer

var attack_list = ["first_phase_attack1_state_first_boss","first_phase_attack2_state_first_boss"]
var next_attack : String

var StateActive : bool = false

func Enter():
	first_phase_to_attack_timer.start()
	next_attack = attack_list[randi() % attack_list.size()]
	StateActive = true
	
func Exit():
	StateActive = false
	
func Update(_delta : float):
	if first_phase_to_attack_timer.is_stopped():
#		Transition.emit(self,next_attack)
#		Transition.emit(self,"first_phase_attack1_state_first_boss")
		Transition.emit(self,"first_phase_attack2_state_first_boss")
	pass
			
func UpdatePhysics(_delta:float):
	pass



