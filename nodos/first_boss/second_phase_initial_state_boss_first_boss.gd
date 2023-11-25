extends State

@export var second_phase_to_attack_timer : Timer

@onready var Enemigo : CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D
@onready var platforms = Enemigo.get_parent().get_node("boss_platforms").get_children()
var attack_list = ["second_phase_attack1_state_first_boss","second_phase_attack2_state_first_boss","second_phase_attack3_state_first_boss","second_phase_attack4_state_first_boss"]

@onready var player = get_tree().get_nodes_in_group("player")[0]

@onready var attack_1 = Enemigo.get_node("position2D/attack_1")
@onready var attack_2 = Enemigo.get_node("position2D/attack_2")
@onready var attack_3 = Enemigo.get_node("position2D/attack_3")
@onready var attack_4 = Enemigo.get_node("position2D/attack_4")
var random_attack : int

var StateActive : bool = false

func Enter():
	Enemigo.position2D.scale.x = abs(player.position.x) / player.position.x 
	random_attack = randi()%(attack_list.size() - 1)+0
	platforms = Enemigo.get_parent().get_node("boss_platforms").get_children()
	delete_platforms(platforms)
	
	Enemigo.set_collision_mask_value(4,true)
	Enemigo.set_collision_layer_value(2,true)
	
	
	
	attack_1.visible = false
	attack_2.visible = false
	attack_3.visible = false
	attack_4.visible = false
	
	attack_list.shuffle()
	second_phase_to_attack_timer.start()
	
	StateActive = true
	
func Exit():
	StateActive = false
	
func Update(_delta : float):
	if second_phase_to_attack_timer.is_stopped():
		Transition.emit(self,attack_list[random_attack])

	pass
			
func UpdatePhysics(_delta:float):
	if not Enemigo.is_on_floor():
		Enemigo.velocity.y += Enemigo.gravity * _delta
	pass

func delete_platforms(platforms):
	for i in platforms:
		i.queue_free()

