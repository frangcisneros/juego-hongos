extends CharacterBody2D

class_name molde_enemigo
var health : int
var sprite_enemigo : Sprite2D

func hit(damage: int):
	health -= damage
	sprite_enemigo.modulate = Color.from_hsv(0,1-health/20,1)

func enemy():
	pass

func _physics_process(delta):
	move_and_slide()
