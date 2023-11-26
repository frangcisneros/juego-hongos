extends State


@onready var Enemigo : CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D
@onready var point1 = Enemigo.get_node("point1").global_position
@onready var point2 = Enemigo.get_node("point2").global_position

var actual_point = point1
var to_point = point2
var i = 1

var StateActive : bool = false

func Enter():
	if Enemigo.global_position.x - point1.x < Enemigo.global_position.x - point2.x:
		actual_point = point1
		to_point = point2
	else:
		actual_point = point2
		to_point = point1
	StateActive = true
	
func Exit():
	StateActive = false
	
func Update(_delta : float):
	if (Enemigo.global_position.x - to_point.x) < 10:
		print("klfajns")
		Transition.emit(self,"second_phase_initial_state_boss_first_boss") 
	pass
			
func UpdatePhysics(delta:float):
	Enemigo.global_position = Enemigo.global_position.lerp(to_point, delta)
	pass
