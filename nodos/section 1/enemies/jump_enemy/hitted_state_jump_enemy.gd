extends State

@export var hitted_timer : Timer


@onready var Enemigo = get_parent().Enemigo
@onready var player = get_tree().get_nodes_in_group("player")[0]

var StateActive : bool = false
var hitted = false

func Enter():
	Enemigo.velocity.y = -100
	if player.position2D.scale.x == 1:
		Enemigo.velocity.x = 150
	elif player.position2D.scale.x == -1:
		Enemigo.velocity.x = -150
	StateActive = true

func Exit():
	hitted = false
	StateActive = false

func UpdatePhysics(_delta:float):
	if Enemigo.is_on_floor() and not hitted:
		Enemigo.velocity = Vector2.ZERO
		hitted_timer.start()
		hitted = true

func Update(_delta : float):
	if Enemigo.is_on_floor() and hitted_timer.is_stopped():
		Transition.emit(self,"idle_state_jump_enemy")
