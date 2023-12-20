extends template_enemy

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var walking_speed: float = 50
@export var running_speed: float = 75


func _ready():
	health = 20
	sprite_enemigo = $Sprite2D


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	super._physics_process(delta)


func _process(delta):
	super._process(delta)
