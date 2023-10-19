extends State

class_name dead_state_armor_walker

@onready var Enemigo = get_parent().Enemigo
@export var corpse_timer : Timer
var StateActive : bool = false
# Called when the node enters the scene tree for the first time.

func Enter():
	Enemigo.set_rotation_degrees(180)
	corpse_timer.start()
	StateActive = true

func Update(_delta : float):
	if corpse_timer.is_stopped():
		Enemigo.queue_free()
