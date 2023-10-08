extends CharacterBody2D

class_name Enemy

var SPEED = 50
const JUMP_VELOCITY = -400.0
var right : bool = true
var stop : bool = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var health : float = 20

@onready var sprite_enemigo = $Sprite2D


func _ready():
	velocity.x = 15

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if not stop:
		if right:
			velocity.x = SPEED
		else:
			velocity.x = -SPEED
	else:
		velocity.x = 0 

	move_and_slide()

func enemy():
	pass

func _on_collision_query_body_exited(body):
	if body.has_method("plataforma") and is_on_floor():
		darse_vuelta()

func hit(damage: int):
	health -= damage
	sprite_enemigo.modulate = Color.from_hsv(0,1-health/20,1)
	
func _process(delta):
	if(health <= 0):
		sprite_enemigo.set_rotation_degrees(180)
		stop = true

func darse_vuelta():
	scale.x = -scale.x
	velocity.x = -velocity.x
	right = !right

