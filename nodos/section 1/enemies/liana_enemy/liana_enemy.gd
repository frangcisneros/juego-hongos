extends StaticBody2D

var health = 5

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	pass


func hit(damage: int):
	health -= damage
