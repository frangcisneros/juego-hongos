extends State

class_name fall_state_player

var StateActive : bool = false
var direction

@onready var Player = get_parent().Player

func Enter():
#	print("Direccion al entrar al estado fall: ", direction)
	StateActive = true

func Exit():
	StateActive = false
	
func Update(_delta : float):
#	print("Direccion al principio de update, fall: ", direction)
	pass
		
#	print("Direccion al final de update, fall: ", direction)

func UpdatePhysics(_delta : float):	
#	print("Direccion al principio de update physics, fall: ", direction)
	if Player.is_on_floor():
		Transition.emit(self,"idle_state_player")
	if not Player.is_on_floor():
		direction = Input.get_axis("ui_left", "ui_right")
		if direction > 0:
			Player.position2D.scale.x = 1
			Player.attack_area.position.x = Player.attack_area.initial_position
		elif direction < 0:
			Player.position2D.scale.x = -1
			Player.attack_area.position.x = - Player.attack_area.initial_position
	if direction:
		Player.velocity.x = direction * Player.SPEED
	else:
		Player.velocity.x = move_toward(Player.velocity.x, 0, Player.SPEED / 5)
	if Input.is_action_just_released("ui_select") and not Player.is_on_floor() and Player.velocity.y < 0: 
		Player.velocity.y /= Player.velocity.y
	if Player.is_on_floor():
		Transition.emit(self,"idle_state_player")
		
	if Input.is_action_just_pressed("ui_select"):
		Player.jump_buffer_timer.start()
	
	if not Player.jump_buffer_timer.is_stopped() and (Player.is_on_floor() or not Player.coyote_timer.is_stopped()):
		Transition.emit(self,"jump_state_player")
#	print("Direccion al final de update physics, fall: ", direction)
