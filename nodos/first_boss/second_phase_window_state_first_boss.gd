extends State

@export var window_to_first_phase: Timer

@onready var Enemigo: CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D

var StateActive: bool = false


func Enter():
	window_to_first_phase.start()
	StateActive = true


func Exit():
	StateActive = false


func Update(_delta: float):
	if window_to_first_phase.is_stopped():
		Transition.emit(self, "second_phase_initial_state_boss_first_boss")
	pass


func UpdatePhysics(_delta: float):
	pass
