extends template_enemy

var speed = 250

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	health = 20
	sprite_enemigo = $Sprite2D
