extends State
@onready var player = get_tree().get_nodes_in_group("player")[0]

@onready var Enemigo : CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D

@export var attack_to_second_phase : Timer
@onready var attack_4_cs : CollisionShape2D = Enemigo.get_node("position2D/attack_4/CollisionShape2D")

var StateActive : bool = false

func Enter():
	
	attack_4_cs.visible = true
	attack_4_cs.disabled = false
	

	
	attack_to_second_phase.start()
	StateActive = true
	
func Exit():
	attack_4_cs.visible = false
	attack_4_cs.disabled = true
	attack_4_cs.shape.radius = 24
	StateActive = false
	
func Update(_delta : float):
	if attack_to_second_phase.is_stopped():
		Transition.emit(self,"second_phase_initial_state_boss_first_boss")
	if attack_4_cs.shape.radius != 70.0:
		attack_4_cs.shape.radius += 1
	pass
			
func UpdatePhysics(_delta:float):
	pass



