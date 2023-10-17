extends template_enemy

const JUMP_VELOCITY = 100.0

var decabeza_gravity = - ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	health = 20
	sprite_enemigo = $Sprite2D
	add_to_group("enemys")


