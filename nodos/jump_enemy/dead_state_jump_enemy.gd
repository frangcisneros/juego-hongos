extends State

class_name dead_state_jump_enemy

@onready var Enemigo = get_parent().Enemigo
@onready var hitbox : Area2D = Enemigo.get_node("hitbox")
@export var corpse_timer : Timer
var StateActive : bool = false
# Called when the node enters the scene tree for the first time.

func Enter():
	off_hitbox()
	Enemigo.set_rotation_degrees(180)
	corpse_timer.start()
	StateActive = true

func Update(_delta : float):
	if corpse_timer.is_stopped():
		Enemigo.queue_free()


func off_hitbox():
	Enemigo.set_collision_layer_value(2,false)
	Enemigo.set_collision_mask_value(1,false)
	hitbox.monitorable = false
	hitbox.monitoring = false
