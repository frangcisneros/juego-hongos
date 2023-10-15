extends molde_enemigo

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	health = 25
	sprite_enemigo = $Sprite2D

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()

