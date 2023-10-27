extends State

class_name hurt_state_player

var StateActive : bool = false

@onready var Player = get_parent().Player

func Enter():
	StateActive = true
	Player.health = Player.health - 1
	if Player.marker2D.scale.x == 1:
		Player.velocity.x = -1000
	else:
		Player.velocity.x = 1000
	Player.velocity.y = -200
	if Player.tiempo_invencibilidad.is_stopped():
		Player.tiempo_invencibilidad.start() 

func Exit():
	StateActive = false
	
func Update(_delta : float):
	Transition.emit(self,"idle_state_player")

func UpdatePhysics(_delta : float):
	pass
