extends State


var StateActive : bool = false
@onready var Player = get_parent().Player
var direction

func Enter():
	StateActive = true

func Exit():
	StateActive = false
	
func Update(_delta : float):
	if Player.velocity.x != 0:
		Player.velocity.x = move_toward(Player.velocity.x, 0, Player.SPEED / 5)
	direction = Input.get_axis("ui_left", "ui_right")

func UpdatePhysics(_delta : float):
	if Player.player_alive:
		if direction and Player.is_on_floor():
			Transition.emit(self,"walk_state_player")
		
		if direction and not Player.is_on_floor():
			Transition.emit(self,"fall_state_player")
		
		if Input.is_action_just_pressed("ui_select"):
			Player.jump_buffer_timer.start()

		if not Player.jump_buffer_timer.is_stopped() and (Player.is_on_floor() or not Player.coyote_timer.is_stopped()):
			Transition.emit(self,"jump_state_player")
	
func _input(event):
	var just_pressed = event.is_pressed() and not event.is_echo()
	if Input.is_key_pressed(KEY_C) and just_pressed and Player.player_alive:
		Transition.emit(self, "healing_state_player")
