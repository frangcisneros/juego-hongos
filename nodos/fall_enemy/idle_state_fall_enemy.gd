extends State

var StateActive : bool = false

@onready var Enemigo = get_parent().Enemigo
@onready var hitbox = Enemigo.get_node("hitbox")

func Enter():
	StateActive = true

func Exit():
	StateActive = false
	
func Update(_delta : float):
	pass

func UpdatePhysics(_delta : float):
	pass
