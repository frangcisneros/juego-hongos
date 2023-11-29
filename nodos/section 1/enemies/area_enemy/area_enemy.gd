extends template_enemy

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	health = 25
	sprite_enemigo = $Sprite2D
