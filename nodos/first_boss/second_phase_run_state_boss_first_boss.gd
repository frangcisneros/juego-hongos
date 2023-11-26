extends State


@onready var Enemigo : CharacterBody2D = get_parent().Enemigo
@onready var point1 = Enemigo.get_node("point1").global_position
@onready var point2 = Enemigo.get_node("point2").global_position
@onready var player = get_tree().get_nodes_in_group("player")[0]
var actual_point = point1
var to_point = point2


var i = 1

var StateActive : bool = false

func Enter():
	i = 1
	if actual_point == point1:
		actual_point = point2
		to_point = point1
	else :
		actual_point = point1
		to_point = point2
	

	StateActive = true
	
func Exit():
	Enemigo.position2D.scale.x = abs(player.position.x) / player.position.x 
	StateActive = false
	
func Update(_delta : float):
	i = i + 0.01
	if abs(Enemigo.global_position.x - to_point.x) < 30:
		Transition.emit(self,"second_phase_initial_state_boss_first_boss") 
	if Enemigo.global_position.is_equal_approx(to_point):
		Transition.emit(self,"second_phase_initial_state_boss_first_boss") 
	pass
			
func UpdatePhysics(delta:float):
	Enemigo.global_position = Enemigo.global_position.lerp(to_point, delta * i)
	pass
