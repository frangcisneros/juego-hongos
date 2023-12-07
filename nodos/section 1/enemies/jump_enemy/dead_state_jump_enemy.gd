extends State


@onready var Enemigo : CharacterBody2D = get_parent().Enemigo
@onready var hitbox : Area2D = Enemigo.get_node("hitbox")

@export var corpse_timer : Timer
@export var animation_player : AnimationPlayer
@export var animation_tree : AnimationTree

var StateActive : bool = false


func Enter():
	off_hitbox()
	Enemigo.velocity.x = 0
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
