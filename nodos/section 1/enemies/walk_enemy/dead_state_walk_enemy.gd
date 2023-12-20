extends State

class_name dead_state_platform_enemy

@onready var Enemigo = get_parent().Enemigo
@onready var hitbox_cs = Enemigo.get_node("hitbox/CollisionShape2D")
@export var corpse_timer: Timer
var StateActive: bool = false
# Called when the node enters the scene tree for the first time.


func Enter():
	hitbox_cs.set_deferred("disabled", true)
	Enemigo.set_collision_mask_value(1, false)
	Enemigo.set_rotation_degrees(180)
	corpse_timer.start()
	StateActive = true


func Update(_delta: float):
	if corpse_timer.is_stopped():
		Enemigo.queue_free()
