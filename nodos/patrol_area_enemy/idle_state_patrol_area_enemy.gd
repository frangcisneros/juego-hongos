extends State

class_name idle_state_patrol_area_enemy

@export var Enemigo : CharacterBody2D
@export var detection_area : Area2D 

@onready var right : bool = true
@onready var speed : float = Enemigo.walking_speed
@onready var health = Enemigo.health
@onready var vision = Enemigo.get_node("vision_patrol_area_enemy")
@onready var rest_timer = Enemigo.get_node("rest")
@onready var damage_area = Enemigo.get_node("damage_area/CollisionShape2D")


var StateActive : bool = false

func Enter():
	damage_area.shape.extents = Vector2(0,0)
	StateActive = true

func Exit():
	StateActive = false
	
func Update(_delta : float):
	if not rest_timer.is_stopped():
		Enemigo.get_node("detection_area").set_deferred("monitoring",false)
	elif rest_timer.is_stopped():
		Enemigo.get_node("detection_area").set_deferred("monitoring",true)

	if(Enemigo.health <= 0):
		Enemigo.set_rotation_degrees(180)
		Transition.emit(self, "dead_state_patrol_area_enemy")
			
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
			Transition.emit(self, "atack_state_patrol_area_enemy")
