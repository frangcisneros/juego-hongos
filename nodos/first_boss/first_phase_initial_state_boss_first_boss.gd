extends State


@onready var Enemigo : CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D
@export var first_phase_to_attack_timer : Timer
@onready var sprite_enemigo : Sprite2D = Enemigo.get_node("position2D/Sprite2D")

var attack_list = ["first_phase_attack1_state_first_boss","first_phase_attack2_state_first_boss"]
var next_attack : String

var StateActive : bool = false

func Enter():
	sprite_enemigo.visible = true
	first_phase_to_attack_timer.start()
	attack_list.shuffle()
	StateActive = true
	
func Exit():
	StateActive = false
	
func Update(_delta : float):
	if first_phase_to_attack_timer.is_stopped():
		Transition.emit(self,attack_list[0])
#		Transition.emit(self,"first_phase_attack1_state_first_boss")
#		Transition.emit(self,"first_phase_attack2_state_first_boss")
	pass
			
func UpdatePhysics(_delta:float):
	pass



