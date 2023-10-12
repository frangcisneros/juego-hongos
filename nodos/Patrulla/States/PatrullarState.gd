extends State

class_name PatrullarState

@export var Enemigo : CharacterBody2D # = get_parent().get_parent()

@onready var right : bool = true
@onready var speed : float = Enemigo.walking_speed
@onready var health = Enemigo.health
var StateActive : bool = false

func Enter():
	Enemigo.velocity.x = 15
	StateActive = true

func Exit():
	StateActive = false
	
func Update(_delta : float):
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

func _on_detection_area_body_entered(body):
	if body.has_method("player") and StateActive:
		Transition.emit(self, "atacarState")
