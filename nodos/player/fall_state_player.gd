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
	if Player.is_on_floor():
		Transition.emit(self,"idle_state_player")
	else:
		direction = Input.get_axis("ui_left", "ui_right")
		if direction > 0:
			Player.position2D.scale.x = 1
			Player.attack_area.position.x = Player.attack_area.initial_position
		elif direction < 0:
			Player.position2D.scale.x = -1
			Player.attack_area.position.x = - Player.attack_area.initial_position

func UpdatePhysics(_delta : float):	
	if direction:
		Player.velocity.x = direction * Player.SPEED
