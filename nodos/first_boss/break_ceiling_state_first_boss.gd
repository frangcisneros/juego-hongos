extends State


@onready var Enemigo : CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D
@onready var picos = Enemigo.get_parent().get_node("ceiling").get_children()
@onready var platforms = Enemigo.get_parent().get_node("boss_platforms").get_children()

var StateActive : bool = false

func Enter():
	StateActive = true
	
func Exit():
	StateActive = false
	
func Update(_delta : float):
	for pico in picos:
		pico.gravity_scale = 1
	break_platforms(platforms,[1,3])
	Transition.emit(self,"first_phase_initial_state_boss_first_boss")
	pass
			
func UpdatePhysics(_delta:float):
	pass

func break_platforms(platforms,platforms_to_delete):
	for i in platforms_to_delete:
		if is_instance_valid(platforms[i]):
			platforms[i].queue_free()

