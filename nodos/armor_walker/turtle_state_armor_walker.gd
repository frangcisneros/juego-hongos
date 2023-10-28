extends State

class_name turtle_state_armor_walker

var StateActive : bool = false

@onready var Enemigo = get_parent().Enemigo
@export var turtle_timer : Timer
@onready var hitbox = Enemigo.get_node("hitbox/CollisionShape2D")

func Enter():
	Enemigo.velocity = Vector2.ZERO
	turtle_timer.start()
	StateActive = true
#	print(hitbox.disabled)

func Exit():
#	print(hitbox.disabled)
	StateActive = false
	
func Update(_delta : float):
	if turtle_timer.is_stopped():
		Transition.emit(self,"idle_state_armor_walker")

func UpdatePhysics(_delta : float):
	pass

