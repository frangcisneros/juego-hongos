extends State

class_name fall_state_player

var StateActive : bool = false
var direction = false

@onready var Player = get_parent().Player

func Enter():
	StateActive = true

func Exit():
	StateActive = false
	
func Update(_delta : float):
	pass

func UpdatePhysics(_delta : float):	
	pass
