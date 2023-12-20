extends State

class_name dead_state_missile_enemy

@onready var Enemigo = get_parent().Enemigo
@export var corpse_timer: Timer
var StateActive: bool = false


func Enter():
	Enemigo.set_collision_layer_value(2, false)
	Enemigo.set_collision_mask_value(1, false)
	Enemigo.set_rotation_degrees(180)
	corpse_timer.start()
	StateActive = true


func Update(_delta: float):
	if corpse_timer.is_stopped():
		Enemigo.queue_free()
