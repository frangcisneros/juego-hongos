extends State


var StateActive : bool = false
var direction
var stop_jump = false

@onready var Player = get_parent().Player

func Enter():
	Player.jump_buffer_timer.stop()
	Player.velocity.y = Player.JUMP_VELOCITY
	Player.coyote_timer.stop()
	StateActive = true

func Exit():
	StateActive = false
	
func Update(_delta : float):
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
	else:
		Player.velocity.x = move_toward(Player.velocity.x, 0, Player.SPEED / 5)
	if Player.velocity.y > 0:
		Transition.emit(self,"fall_state_player")
#	if Player.is_on_floor():
#		Transition.emit(self,"idle_state_player")


