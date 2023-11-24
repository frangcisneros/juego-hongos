extends State


@onready var Enemigo : CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D
@onready var first_phase_attack2_area = Enemigo.get_node("first_phase_attack2_area")
@onready var boss_platforms = Enemigo.get_parent().get_node("boss_platforms")
@export var attack_to_first_phase_timer : Timer
@export var change_safe_areas_attack_2 : Timer

var StateActive : bool = false
@onready var platforms : Array = boss_platforms.get_children()
@onready var safe_areas : Array = first_phase_attack2_area.get_children()

func Enter():
	attack_to_first_phase_timer.start()
	activate_platforms(platforms,safe_areas)	
	StateActive = true
	
func Exit():
	StateActive = false
	
func Update(_delta : float):
	if change_safe_areas_attack_2.is_stopped():
		activate_platforms(platforms,safe_areas)
		change_safe_areas_attack_2.start()
		
	if attack_to_first_phase_timer.is_stopped():
		Transition.emit(self,"first_phase_initial_state_boss_first_boss")
	pass
			
func UpdatePhysics(_delta:float):
	pass

func activate_platforms(platforms,safe_areas):
	var safe_platform1 = randi()%(platforms.size() - 1)+1
	var safe_platform2 = randi()%(platforms.size() - 1)+1
	var safe_platform3 = randi()%(platforms.size() - 1)+1
	print(platforms[safe_platform1])
	safe_areas[0].global_position = platforms[safe_platform1].global_position
	safe_areas[1].global_position = platforms[safe_platform2].global_position
	safe_areas[2].global_position = platforms[safe_platform3].global_position
