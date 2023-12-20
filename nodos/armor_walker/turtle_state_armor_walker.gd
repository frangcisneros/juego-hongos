extends State


var StateActive : bool = false

@onready var Enemigo = get_parent().Enemigo
@export var turtle_timer : Timer
@onready var hitbox = Enemigo.get_node("hitbox/CollisionShape2D")
@export var animation_tree : AnimationTree
@export var animation_player : AnimationPlayer

@onready var state_machine = animation_tree["parameters/playback"]

func Enter():
	state_machine.travel("walking")
	animation_player.set("speed_scale", 1)
	Enemigo.velocity = Vector2.ZERO
	turtle_timer.start()
	StateActive = true

func Exit():
	StateActive = false
	
func Update(_delta : float):
	if turtle_timer.is_stopped():
		Transition.emit(self,"idle_state_armor_walker")

func UpdatePhysics(_delta : float):
	pass

