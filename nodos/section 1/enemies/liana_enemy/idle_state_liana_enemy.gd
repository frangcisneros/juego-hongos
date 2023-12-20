extends State

class_name idle_state_liana_enemy

#@export var cage : CollisionPolygon2D
@export var wait_timer: Timer

@onready var Enemigo: StaticBody2D = get_parent().Enemigo
@onready var health = Enemigo.health

var go = false
var StateActive: bool = false


func Enter():
	Enemigo.get_node("hitbox").set_collision_layer_value(2, false)
	wait_timer.start()
	StateActive = true


func Exit():
	StateActive = false


func Update(_delta: float):
	if wait_timer.is_stopped() and go:
		Transition.emit(self, "attack_state_liana_enemy")
	pass


func UpdatePhysics(_delta: float):
	pass


func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		wait_timer.start()
		go = true
