extends State

var StateActive : bool = false

@onready var Enemigo = get_parent().Enemigo
@onready var hitbox = Enemigo.get_node("hitbox")
@onready var body : CollisionShape2D = Enemigo.get_node("hitbox/CollisionShape2D")
var aumento = 0

func Enter():
	aumento = 0
	StateActive = true


func Exit():
	body.shape.size.y = 48
	body.get_parent().position.y = 0
	StateActive = false
	
func Update(_delta : float):
	Enemigo.velocity.x = 0
	aumento -= 0.08
	body.shape.extents.y += aumento
	body.get_parent().position.y -= aumento
	if Enemigo.is_on_ceiling():
		Transition.emit(self,"idle_state_fall_enemy")
	pass

func UpdatePhysics(_delta : float):
	Enemigo.velocity.y += Enemigo.gravity * _delta
	pass



