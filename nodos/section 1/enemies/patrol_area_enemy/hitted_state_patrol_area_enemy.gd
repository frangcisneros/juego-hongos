extends State

class_name hitted_state_patrol_area_enemy

@export var hitted_timer: Timer

@onready var Enemigo = get_parent().Enemigo
@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var rest_timer = Enemigo.get_node("rest")

var StateActive: bool = false
var hitted = false


func Enter():
	Enemigo.velocity.y = -200
	if player.marker2D.scale.x == 1:
		Enemigo.velocity.x = 200
	elif player.marker2D.scale.x == -1:
		Enemigo.velocity.x = -200
	StateActive = true


func Exit():
	rest_timer.stop()
	StateActive = false


func UpdatePhysics(_delta: float):
	if Enemigo.is_on_floor() and not hitted:
		Enemigo.velocity = Vector2.ZERO
		hitted_timer.start()
		hitted = true


func Update(_delta: float):
	if Enemigo.is_on_floor() and hitted_timer.is_stopped():
		Transition.emit(self, "idle_state_patrol_area_enemy")
