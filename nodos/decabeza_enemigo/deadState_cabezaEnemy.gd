extends State

class_name DeadState_cabezaEnemigo

var StateActive : bool = false

@onready var Enemigo = get_parent().Enemigo


func Enter():
	pass

func Exit():
	pass
	
func Update(_delta : float):
	pass

func UpdatePhysics(_delta : float):
	pass
