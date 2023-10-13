extends CharacterBody2D

class_name EnemigoPatrulla

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var walking_speed : float = 50
@export var running_speed : float = 75
@export var health : float = 20
@onready var sprite_enemigo = $Sprite2D

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
	
func enemy():
	pass

func hit(damage: int):
	health -= damage
	sprite_enemigo.modulate = Color.from_hsv(0,1-health/20,1)
