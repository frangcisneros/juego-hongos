extends template_enemy

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var walking_speed : float = 50
@export var running_speed : float = 100
@export var position2D : Marker2D
@onready var animation_tree = $AnimationTree

func _ready():
	animation_tree.active = true	
	health = 20
	sprite_enemigo = $position2D/Sprite2D

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	super._physics_process(delta)

func _process(delta):
	super._process(delta)
