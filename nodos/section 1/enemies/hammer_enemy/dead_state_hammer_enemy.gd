extends State

@onready var Enemigo = get_parent().Enemigo
@export var corpse_timer: Timer
var StateActive: bool = false
# Called when the node enters the scene tree for the first time.


func Enter():
	Enemigo.set_collision_layer_value(2, false)
	Enemigo.set_collision_mask_value(1, false)
	Enemigo.set_rotation_degrees(180)
	corpse_timer.start()
	Enemigo.drop_coin(10)
	StateActive = true


func Update(_delta: float):
	if corpse_timer.is_stopped():
		Enemigo.queue_free()
