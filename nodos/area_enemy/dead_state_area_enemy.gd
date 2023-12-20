extends State

class_name dead_state_area_enemy

@onready var Enemigo = get_parent().Enemigo
@export var corpse_timer : Timer

@export var animation_tree : AnimationTree
@export var animation_player : AnimationPlayer
@onready var state_machine = animation_tree["parameters/playback"]
var StateActive : bool = false
# Called when the node enters the scene tree for the first time.
func Enter():
	StateActive = true
	state_machine.travel("death")
	animation_player.set("speed_scale", 1)
	corpse_timer.start()
	StateActive = true

func Update(_delta : float):
	if corpse_timer.is_stopped():
		Enemigo.queue_free()
