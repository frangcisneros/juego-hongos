extends State

class_name dead_state_liana_enemy

@onready var Enemigo: StaticBody2D = get_parent().Enemigo

@onready var health = Enemigo.health
@export var corpse_timer: Timer

var StateActive: bool = false


func Enter():
	Enemigo.set_collision_layer_value(2, false)
	Enemigo.set_collision_mask_value(1, false)
	Enemigo.get_node("hitbox").set_collision_layer_value(2, false)
	Enemigo.set_collision_layer_value(5, false)
	corpse_timer.start()
	StateActive = true


func Exit():
	StateActive = false


func Update(_delta: float):
	if corpse_timer.is_stopped():
		Enemigo.queue_free()
	pass


func UpdatePhysics(_delta: float):
	pass
