extends State

@export var attack_to_first_phase_timer : Timer
@export var attack_1_lines : Timer

@onready var Enemigo : CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D
@onready var first_phase_attack1_area : Area2D = Enemigo.get_node("first_phase_attack1_area")


var StateActive : bool = false
@onready var lines : Array = first_phase_attack1_area.get_children()
var activated_line : Node2D
var previous_activated_line : Node2D

func Enter():
	attack_to_first_phase_timer.start()
	StateActive = true
	attack_1_lines.start()
	activated_line = activate_line(lines)
	previous_activated_line = activated_line
	
		
func Exit():
	StateActive = false
	activated_line.visible = false
	
func Update(_delta : float):
	if attack_1_lines.is_stopped():
		activated_line = activate_line(lines)
		previous_activated_line.visible = false
		previous_activated_line = activated_line
		attack_1_lines.start()
	
	if attack_to_first_phase_timer.is_stopped():
		Transition.emit(self,"first_phase_initial_state_boss_first_boss")
	pass
			
func UpdatePhysics(_delta:float):
	pass

func activate_line(lines):
	var random_line = randi()%(lines.size() - 1)+0
	var this_line
	if not lines[random_line].visible:
		lines[random_line].visible = true
		this_line = lines[random_line]
	elif random_line - 1 != 0:
		lines[random_line - 1].visible = true
		this_line = lines[random_line - 1]
	else:
		lines[random_line + 1].visible = true 
		this_line = lines[random_line + 1]
	return this_line
		
	
