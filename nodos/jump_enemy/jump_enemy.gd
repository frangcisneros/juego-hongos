extends template_enemy

var JUMP_VELOCITY = -400
var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	health = 20
	sprite_enemigo = $Sprite2D

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	super._physics_process(delta)

func _process(delta):
	super._process(delta)
