extends State

class_name walk_state_player

var StateActive : bool = false
var direction = false
var was_on_floor = false

@onready var Player = get_parent().Player

func Enter():
	if Player.is_on_floor():
		was_on_floor = true
	direction = 0
	StateActive = true
	Player.coyote_timer.stop()
func Exit():
	StateActive = false
	
func Update(_delta : float):
	direction = Input.get_axis("ui_left", "ui_right")
	if direction > 0:
		Player.marker2D.scale.x = 1
		Player.ataque.position.x = Player.ataque.initial_position
	elif direction < 0:
		Player.marker2D.scale.x = -1
		Player.ataque.position.x = - Player.ataque.initial_position

func UpdatePhysics(_delta : float):
	if direction:
		Player.velocity.x = direction * Player.SPEED
	else:
		Transition.emit(self,"idle_state_player")
	
#	was_on_floor = Player.is_on_floor()
	print(was_on_floor, Player.is_on_floor())
	
	if was_on_floor && !Player.is_on_floor():
		was_on_floor = false
		Player.coyote_timer.start()
	
	if Input.is_action_just_pressed("ui_select") and (Player.is_on_floor() or not Player.coyote_timer.is_stopped()):
		Player.jump_buffer_timer.start()
		Transition.emit(self,"jump_state_player")

