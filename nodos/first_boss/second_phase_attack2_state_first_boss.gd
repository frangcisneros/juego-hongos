extends State


@onready var Enemigo : CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D
@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var attack_2 : Area2D = Enemigo.get_node("position2D/attack_2")
@export var attack_to_second_phase_2 : Timer

var initial_position : Vector2

var StateActive : bool = false
var angle_to_player
var player_initial_position

func Enter():
	initial_position = attack_2.position
	attack_2.visible = true
	player_initial_position = player.global_position
	attack_2.set_deferred("monitoring",true)
	attack_2.set_deferred("monitorable",true)
	
	attack_to_second_phase_2.start()
	attack_2.look_at(player.global_position)
	StateActive = true
	
func Exit():
	attack_2.position = initial_position
	attack_2.set_deferred("monitoring",false)
	attack_2.set_deferred("monitorable",false)
	StateActive = false
	
func Update(_delta : float):
	if attack_to_second_phase_2.is_stopped():
		Transition.emit(self,"second_phase_initial_state_boss_first_boss")
	attack_2.global_position += (attack_2.global_position.direction_to(player_initial_position) * 5)
	pass
			
func UpdatePhysics(_delta:float):
	pass

func _on_attack_2_body_entered(body):
	if body.has_method("plataforma") or body.has_method("player"):
		Transition.emit(self,"second_phase_initial_state_boss_first_boss")
