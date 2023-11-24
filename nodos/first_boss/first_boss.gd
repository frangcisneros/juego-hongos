extends template_enemy

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var position2D : Marker2D

func _ready():
	health = 20
	sprite_enemigo = $position2D/Sprite2D

func _physics_process(delta):
	super._physics_process(delta)

func _process(delta):
	super._process(delta)
