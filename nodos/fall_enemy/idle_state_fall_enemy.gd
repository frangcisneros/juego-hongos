extends State

var StateActive : bool = false

@onready var Enemigo = get_parent().Enemigo
@onready var hitbox = Enemigo.get_node("hitbox")
@onready var body : CollisionShape2D = Enemigo.get_node("hitbox/CollisionShape2D")

func Enter():
	
	StateActive = true

func Exit():
	StateActive = false
	
func Update(_delta : float):
	Enemigo.velocity.x = 0
	pass

func UpdatePhysics(_delta : float):
	Enemigo.velocity.y += Enemigo.gravity * _delta
	pass



func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		Transition.emit(self,"fall_state_fall_enemy")
