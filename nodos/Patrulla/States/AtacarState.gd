extends State

class_name AtacarState

@onready var Enemigo : CharacterBody2D= get_parent().Enemigo

@export var detection_area : Area2D 

@export var attack_timer : Timer
@onready var speed : float = Enemigo.running_speed
@onready var health : float= Enemigo.health
@onready var scale_x : float = Enemigo.scale.x
var StateActive : bool = false
var posicion_objetivo : Vector2 

func Enter():
	for body in detection_area.get_overlapping_bodies():
		if body is Player:
			posicion_objetivo = body.position
	if posicion_objetivo.x - Enemigo.position.x >= 5:
		if Enemigo.velocity.x < 0:
			Enemigo.scale.x *= -1 
		get_parent().get_node("PatrullarState").right = true
	elif posicion_objetivo.x - Enemigo.position.x <= -5:
		if Enemigo.velocity.x > 0:
			Enemigo.scale.x *= -1 
		get_parent().get_node("PatrullarState").right = false
#	Enemigo.velocity.x = 30
	attack_timer.start()
	StateActive = true

func Exit():
	StateActive = false
	
func Update(_delta : float):
	
	if(Enemigo.health <= 0):
		Enemigo.set_rotation_degrees(180)
		Transition.emit(self, "DeadState")
	elif attack_timer.is_stopped():
		Transition.emit(self,"PatrullarState")

func UpdatePhysics(_delta : float):
	if posicion_objetivo.x - Enemigo.position.x >= 5:
		Enemigo.velocity.x = speed
	elif posicion_objetivo.x - Enemigo.position.x <= -5:
		Enemigo.velocity.x = -speed
	else:
		attack_timer.stop()
