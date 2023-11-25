extends State


@onready var Enemigo : CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D
@export var first_phase_to_attack_timer : Timer
@onready var sprite_enemigo : Sprite2D = Enemigo.get_node("position2D/Sprite2D")

var attack_list = ["first_phase_attack1_state_first_boss","first_phase_attack2_state_first_boss"]
var next_attack : String
var break_ceiling : bool = false

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
	if Enemigo.health <= 75 and not break_ceiling:
		break_ceiling = true
		Transition.emit(self,"break_ceiling_state_first_boss")
	if Enemigo.health <= 50:
		Transition.emit(self,"second_phase_initial_state_boss_first_boss")
	pass
			
func UpdatePhysics(_delta:float):
	pass



