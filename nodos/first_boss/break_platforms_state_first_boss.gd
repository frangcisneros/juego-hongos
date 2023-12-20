extends State

@onready var Enemigo: CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D

@onready var big_damage_area = Enemigo.get_parent().get_node("big_damage_area")
@onready var platforms = Enemigo.get_parent().get_node("boss_platforms").get_children()

var StateActive: bool = false


func Enter():
	if (
		big_damage_area
		and Enemigo.get_parent().get_node("first_phase_attack1_area")
		and Enemigo.get_node("first_phase_attack2_area")
	):
		big_damage_area.queue_free()
		Enemigo.get_parent().get_node("first_phase_attack1_area").queue_free()
		Enemigo.get_node("first_phase_attack2_area").queue_free()

	platforms = Enemigo.get_parent().get_node("boss_platforms").get_children()
	for platform in platforms:
		platform.queue_free()

	StateActive = true


func Exit():
	StateActive = false


func Update(_delta: float):
	pass


func UpdatePhysics(_delta: float):
	if not Enemigo.is_on_floor():
		Enemigo.velocity.y += Enemigo.gravity * _delta
	else:
		Transition.emit(self, "second_phase_run_state_boss_first_boss")

	pass
