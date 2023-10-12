extends Enemy

@onready var jump_cd = $jump_cd
@onready var animacion = $AnimatedSprite2D
func _physics_process(delta):
	super._physics_process(delta)
	salto()

func _ready():
	super._ready()
	jump_cd.start()
func salto():
	if jump_cd.is_stopped() and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_cd.start()
		
func enemy():
	pass
