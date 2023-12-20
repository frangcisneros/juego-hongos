extends State

class_name explode_state_missile

@export var explode_wait_timer: Timer

var StateActive: bool = false
@onready var Proyectil: RigidBody2D = get_parent().Proyectil
@onready var damage_area = Proyectil.get_node("damage_area/CollisionShape2D")


func Enter():
	damage_area.set_deferred("disabled", false)
	Proyectil.get_node("Sprite2D").visible = false
	explode_wait_timer.start()
	StateActive = true


func Exit():
	StateActive = false


func Update(_delta: float):
	if explode_wait_timer.is_stopped():
		Proyectil.queue_free()
	pass


func UpdatePhysics(_delta: float):
	pass
