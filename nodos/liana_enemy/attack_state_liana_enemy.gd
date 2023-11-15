extends State

class_name attack_state_liana_enemy

@onready var Enemigo : StaticBody2D = get_parent().Enemigo
@export var cage : CollisionPolygon2D
@onready var health = Enemigo.health
var go = false
@export var wait_timer : Timer

var StateActive : bool = false
var movimiento = 0

func Enter():
	Enemigo.set_collision_layer_value(2,true)
	Enemigo.get_node("hitbox").set_collision_layer_value(2,true)
	Enemigo.set_collision_layer_value(5,true)
	StateActive = true
	
func Exit():
	StateActive = false
	
func Update(_delta : float):
#	if wait_timer.is_stopped() and go:
#		Transition.emit(self,"idle_state_liana_enemy")
	pass

func UpdatePhysics(_delta:float):
	if not go:
		cage.position.y -= 1
		movimiento -= 1
		if movimiento == -50:
			go = true
	pass
		
