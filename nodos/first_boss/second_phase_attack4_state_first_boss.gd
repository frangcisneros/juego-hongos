extends State


@onready var Enemigo : CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D
@onready var attack_4_cs : CollisionShape2D = Enemigo.get_node("position2D/attack_4/CollisionShape2D")

@export var attack_to_second_phase : Timer
@onready var attack_4 : Area2D = Enemigo.get_node("position2D/attack_4")

var StateActive : bool = false

func Enter():
	attack_4.visible = true
	attack_4.set_deferred("monitoring",true)
	attack_4.set_deferred("monitorable",true)
	
	attack_to_second_phase.start()
	StateActive = true
	
func Exit():
	attack_4_cs.shape.radius = 24
	attack_4.set_deferred("monitoring",false)
	attack_4.set_deferred("monitorable",false)
	StateActive = false
	
func Update(_delta : float):
	if attack_to_second_phase.is_stopped():
		Transition.emit(self,"second_phase_initial_state_boss_first_boss")
	if attack_4_cs.shape.radius != 70.0:
		attack_4_cs.shape.radius += 1
	pass
			
func UpdatePhysics(_delta:float):
	pass



