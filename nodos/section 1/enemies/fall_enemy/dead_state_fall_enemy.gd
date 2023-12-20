extends State

var StateActive: bool = false

@onready var Enemigo = get_parent().Enemigo
@onready var hitbox = Enemigo.get_node("hitbox")
@export var corpse_timer: Timer


func Enter():
	StateActive = true
	corpse_timer.start()


func Exit():
	StateActive = false


func Update(_delta: float):
	if corpse_timer.is_stopped():
		Enemigo.queue_free()
	pass


func UpdatePhysics(_delta: float):
	pass
