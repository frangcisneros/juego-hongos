extends State

class_name atack_state_patrol_area_enemy

@onready var Enemigo : CharacterBody2D= get_parent().Enemigo

@export var detection_area : Area2D 

@export var attack_timer : Timer

@onready var speed : float = Enemigo.running_speed
@onready var health : float= Enemigo.health
@onready var scale_x : float = Enemigo.scale.x
@onready var vision = Enemigo.get_node("vision_patrol_area_enemy")
@onready var rest_timer = Enemigo.get_node("rest")

@onready var player = get_tree().get_nodes_in_group("player")[0]

var StateActive : bool = false
var posicion_objetivo : Vector2 

func Enter():
	posicion_objetivo = player.position
	if posicion_objetivo.x - Enemigo.position.x >= 5:
		if Enemigo.velocity.x < 0:
			Enemigo.scale.x *= -1 
			vision.scale.x = - vision.scale.x
		get_parent().get_node("idle_state_patrol_area_enemy").right = true
		Enemigo.velocity.x = speed
	elif posicion_objetivo.x - Enemigo.position.x <= -5:
		if Enemigo.velocity.x > 0:
			Enemigo.scale.x *= -1 
			vision.scale.x = - vision.scale.x
		get_parent().get_node("idle_state_patrol_area_enemy").right = false
		Enemigo.velocity.x = -speed
	attack_timer.start()
	StateActive = true

func Exit():
	rest_timer.start()
	StateActive = false
	
func Update(_delta : float):
	if(Enemigo.health <= 0):
		Enemigo.set_rotation_degrees(180)
		Transition.emit(self, "dead_state_patrol_area_enemy")
	elif attack_timer.is_stopped():
		Transition.emit(self,"idle_state_patrol_area_enemy")
