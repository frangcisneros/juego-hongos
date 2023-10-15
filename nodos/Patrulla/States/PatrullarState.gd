extends State

class_name PatrullarState

@export var Enemigo : CharacterBody2D # = get_parent().get_parent()
@export var animation_tree : AnimationTree
@export var animation_player : AnimationPlayer

@onready var right : bool = true
@onready var speed : float = Enemigo.walking_speed
@onready var health = Enemigo.health
@onready var vision = Enemigo.get_node("vision")
@onready var rest_timer = Enemigo.get_node("rest")

var StateActive : bool = false

func Enter():
	rest_timer.start()
	
	StateActive = true
	animation_tree.set("parameters/Patrulla/blend_position",0)
	animation_player.set("speed_scale", 1)

func Exit():
	StateActive = false
	
func Update(_delta : float):
	if not rest_timer.is_stopped():
		Enemigo.get_node("detection area").monitoring = false
	elif rest_timer.is_stopped():
		Enemigo.get_node("detection area").monitoring = true
	if(Enemigo.health <= 0):
		Enemigo.set_rotation_degrees(180)
		Transition.emit(self, "DeadState")
			
func UpdatePhysics(_delta:float):
	if right:
		Enemigo.velocity.x = speed
	else:
		Enemigo.velocity.x = -speed
func _on_collision_query_body_exited(body):
	if body.has_method("plataforma") and Enemigo.is_on_floor() and StateActive:
		Enemigo.scale.x = -Enemigo.scale.x
		Enemigo.velocity.x = -Enemigo.velocity.x
		right = !right
		vision.scale.x = - vision.scale.x

func _on_detection_area_body_entered(body):
	if body.has_method("player") and StateActive:
		if vision.vision_player(body.position) and rest_timer.is_stopped():
			Transition.emit(self, "atacarState")
