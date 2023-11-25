extends State


@onready var Enemigo : CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D

var StateActive : bool = false

func Enter():
	Enemigo.get_node("first_phase_attack1_area").queue_free()
	Enemigo.get_node("first_phase_attack2_area").queue_free()
	StateActive = true
	
func Exit():
	StateActive = false
	
func Update(_delta : float):
	pass
			
func UpdatePhysics(_delta:float):
	pass



