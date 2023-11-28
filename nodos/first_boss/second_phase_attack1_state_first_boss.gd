extends State



@onready var Enemigo : CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D
@onready var player = get_tree().get_nodes_in_group("player")[0]
@export var attack_to_second_phase : Timer
@onready var attack_1 : Area2D = Enemigo.get_node("position2D/attack_1")
var initial_position : Vector2

var StateActive : bool = false


func Enter():
	
	
	initial_position = attack_1.position
	attack_1.visible = true
	attack_1.set_deferred("monitoring",true)
	attack_1.set_deferred("monitorable",true)
	
	attack_to_second_phase.start()
	
	StateActive = true
	
func Exit():
	attack_1.position = initial_position
	attack_1.set_deferred("monitoring",false)
	attack_1.set_deferred("monitorable",false)
	StateActive = false
	
func Update(_delta : float):
	if attack_to_second_phase.is_stopped():
		Transition.emit(self,"second_phase_initial_state_boss_first_boss")
	
	attack_1.global_position.x += (0.5 * Enemigo.position2D.scale.x)
	pass
			
func UpdatePhysics(_delta:float):
	pass



