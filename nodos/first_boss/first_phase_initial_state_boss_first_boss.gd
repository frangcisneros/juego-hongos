extends State


@onready var Enemigo : CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D
@export var first_phase_to_attack_timer : Timer
@onready var sprite_enemigo : Sprite2D = Enemigo.get_node("position2D/Sprite2D")

@onready var attack_1 : Area2D = Enemigo.get_node("position2D/attack_1")
@onready var attack_2 : Area2D = Enemigo.get_node("position2D/attack_2")
@onready var attack_3 : Area2D = Enemigo.get_node("position2D/attack_3")
@onready var attack_4 : Area2D = Enemigo.get_node("position2D/attack_4")

@onready var first_phase_attack2_area : Area2D = Enemigo.get_node("first_phase_attack2_area")
@onready var first_phase_attack1_area : Area2D = Enemigo.get_node("first_phase_attack1_area")
@onready var big_damage_area = Enemigo.get_parent().get_node("big_damage_area")

var attack_list = ["first_phase_attack1_state_first_boss","first_phase_attack2_state_first_boss"]
var next_attack : String
var break_ceiling : bool = false

var StateActive : bool = false

func Enter():
	first_phase_to_attack_timer.start()
	
	# seteamos el primer ataque de la primera fase
	first_phase_attack1_area.visible = false
	first_phase_attack1_area.set_deferred("monitorable",false)
	first_phase_attack1_area.set_deferred("monitoring",false)
	
	first_phase_attack2_area.visible = false
	big_damage_area.set_deferred("monitorable",false)
	big_damage_area.set_deferred("monitoring",false)
	
	attack_1.visible = false
	attack_2.visible = false
	attack_3.visible = false
	attack_4.visible = false
	
	sprite_enemigo.visible = true
	
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



