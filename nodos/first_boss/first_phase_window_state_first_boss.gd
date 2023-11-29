extends State

@export var window_to_first_phase : Timer

@onready var Enemigo : CharacterBody2D = get_parent().Enemigo
@onready var sprite_enemigo : Sprite2D = Enemigo.get_node("position2D/Sprite2D")
@onready var position2D = get_parent().position2D
@onready var hitbox = Enemigo.get_node("hitbox")
var StateActive : bool = false

func Enter():
	Enemigo.set_collision_layer_value(2,true)
	hitbox.set_collision_mask_value(6,true)
	hitbox.set_collision_layer_value(2,true)
	sprite_enemigo.visible = true
	window_to_first_phase.start()
	StateActive = true
	
func Exit():
	StateActive = false
	
func Update(_delta : float):
	if window_to_first_phase.is_stopped():
		Transition.emit(self,"first_phase_initial_state_boss_first_boss")
	pass
			
func UpdatePhysics(_delta:float):
	Enemigo.velocity = Vector2.ZERO
	pass



