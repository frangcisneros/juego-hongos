extends State

@export var first_phase_to_window : Timer
@export var attack_1_lines : Timer

@onready var Enemigo : CharacterBody2D = get_parent().Enemigo
@onready var hitbox = Enemigo.get_node("hitbox")
@onready var position2D = get_parent().position2D
@onready var first_phase_attack1_area : Area2D = Enemigo.get_parent().get_node("first_phase_attack1_area")
@onready var sprite_enemigo : Sprite2D = Enemigo.get_node("position2D/Sprite2D")

var StateActive : bool = false
@onready var lines : Array = first_phase_attack1_area.get_children()
var activated_line : Node2D
var previous_activated_line : Node2D

func Enter():
	first_phase_attack1_area.set_deferred("monitorable",true)
	first_phase_attack1_area.set_deferred("monitoring",true)
	first_phase_attack1_area.visible = true
	
	for line in (lines):
		line.visible = false
		line.disabled = true
		
	
	Enemigo.set_collision_layer_value(2,false)
	hitbox.set_collision_layer_value(2,false)	
	hitbox.set_collision_mask_value(5,false)
	
	sprite_enemigo.visible = false
	first_phase_to_window.start()
	StateActive = true
	attack_1_lines.start()
	
	activated_line = activate_line(lines)
	previous_activated_line = activated_line
	
		
func Exit():
	StateActive = false
	activated_line.visible = false
	activated_line.disabled = true

func Update(_delta : float):
	if attack_1_lines.is_stopped():
		previous_activated_line = activated_line
		activated_line = activate_line(lines)
		previous_activated_line.visible = false
		previous_activated_line.disabled = true
		attack_1_lines.start()
	
	if first_phase_to_window.is_stopped():
		Transition.emit(self,"first_phase_window_state_first_boss")
	pass
			
func UpdatePhysics(_delta:float):
	pass

func activate_line(lines):
	var random_line = randi()%(lines.size() - 1)+0
	var this_line
	if not lines[random_line].visible:
		lines[random_line].visible = true
		lines[random_line].disabled = false
		this_line = lines[random_line]
	elif random_line - 1 != 0:
		lines[random_line - 1].visible = true
		lines[random_line - 1].disabled = false
		this_line = lines[random_line - 1]
	else:
		lines[random_line + 1].visible = true 
		lines[random_line + 1].disabled = false
		this_line = lines[random_line + 1]
	return this_line
