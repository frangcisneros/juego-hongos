extends State

@export var second_phase_to_attack_timer : Timer

@onready var Enemigo : CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D
@onready var platforms = Enemigo.get_parent().get_node("boss_platforms").get_children()
var attack_list = ["second_phase_attack1_state_first_boss","second_phase_attack2_state_first_boss","second_phase_attack3_state_first_boss","second_phase_attack4_state_first_boss"]

@onready var player = get_tree().get_nodes_in_group("player")[0]

@onready var attack_1_cs : CollisionShape2D = Enemigo.get_node("position2D/attack_1/CollisionShape2D")
@onready var attack_2_cs : CollisionShape2D = Enemigo.get_node("position2D/attack_2/CollisionShape2D")
@onready var attack_3_cs : CollisionShape2D = Enemigo.get_node("position2D/attack_3/RigidBody2D/CollisionShape2D")
@onready var attack_4_cs : CollisionShape2D = Enemigo.get_node("position2D/attack_4/CollisionShape2D")

@onready var point1_x = Enemigo.get_parent().get_node("point1").global_position.x
@onready var point2_x = Enemigo.get_parent().get_node("point2").global_position.x

@onready var big_damage_area = Enemigo.get_parent().get_node("big_damage_area")

@onready var right : bool = true
@onready var speed : float = 100
@onready var run_area : Area2D = Enemigo.get_node("run_area")
@onready var hitbox = Enemigo.get_node("hitbox")
var random_attack : int
var amount_of_attacks = 0
var random_amount_of_attacks = randi()%(5)+2

var StateActive : bool = false
var starter_health = 50
var new_health = starter_health

func Enter():
	if big_damage_area and Enemigo.get_parent().get_node("first_phase_attack1_area") and Enemigo.get_node("first_phase_attack2_area"):
		big_damage_area.queue_free()
		Enemigo.get_parent().get_node("first_phase_attack1_area").queue_free()
		Enemigo.get_node("first_phase_attack2_area").queue_free()
	
	platforms = Enemigo.get_parent().get_node("boss_platforms").get_children()
	for platform in platforms:
		platform.queue_free()
	
	amount_of_attacks += 1
	run_area.set_deferred("monitoring",true)
	run_area.set_deferred("monitorable",true)
	random_attack = randi()%(attack_list.size() - 1)+0
	
	
	Enemigo.set_collision_mask_value(4,true)
	Enemigo.set_collision_layer_value(2,true)
	hitbox.set_collision_mask_value(6,true)
	
	attack_1_cs.visible = false
	attack_2_cs.visible = false
	attack_3_cs.visible = false
	attack_4_cs.visible = false
	
	attack_1_cs.disabled = true
	attack_2_cs.disabled = true
	attack_3_cs.disabled = true
	attack_4_cs.disabled = true
	
	attack_list.shuffle()
	second_phase_to_attack_timer.start()
	
	StateActive = true
	
func Exit():
	Enemigo.position2D.scale.x = abs(player.position.x) / player.position.x 
	run_area.set_deferred("monitoring",false)
	run_area.set_deferred("monitorable",false)
	Enemigo.position2D.scale.x = abs(player.global_position.x - Enemigo.global_position.x) / (player.global_position.x - Enemigo.global_position.x) 
	StateActive = false
	
func Update(_delta : float):
	if amount_of_attacks == random_amount_of_attacks:
		amount_of_attacks = 0
		random_amount_of_attacks = randi()%(4)+1		
		Transition.emit(self,"second_phase_run_state_boss_first_boss")
	
	to_window(5)
	if second_phase_to_attack_timer.is_stopped() and Enemigo.velocity.x == 0:
		Transition.emit(self,attack_list[random_attack])
		
		
	pass
			
func UpdatePhysics(_delta:float):
	if not Enemigo.is_on_floor():
		Enemigo.velocity.y = Enemigo.gravity * _delta * 1000
	pass

func to_window(amount_of_windows):
	if Enemigo.health <= new_health - (starter_health / amount_of_windows):
		new_health = new_health - (starter_health / amount_of_windows)
		Transition.emit(self,"second_phase_window_state_first_boss")

func _on_run_area_body_entered(body):
	if body.has_method("player"):
		Transition.emit(self,"second_phase_run_state_boss_first_boss")
