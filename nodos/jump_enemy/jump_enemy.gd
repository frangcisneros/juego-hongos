extends template_enemy

var JUMP_VELOCITY = -400
var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	health = 20
	sprite_enemigo = $Sprite2D
