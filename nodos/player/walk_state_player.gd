extends State

class_name walk_state_player

var StateActive : bool = false
var direction
var was_on_floor = false

@onready var Player = get_parent().Player

func Enter():
	if Player.is_on_floor():
		was_on_floor = true
	StateActive = true
	Player.coyote_timer.stop()
	
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
		Transition.emit(self,"idle_state_player")
	
	if was_on_floor && !Player.is_on_floor():
		was_on_floor = false
		Player.coyote_timer.start()
	
	if Input.is_action_just_pressed("ui_select"):
		Player.jump_buffer_timer.start()
	
	if not Player.jump_buffer_timer.is_stopped() and (Player.is_on_floor() or not Player.coyote_timer.is_stopped()):
		Transition.emit(self,"jump_state_player")

#func _on_hitbox_player_body_entered(body):
#	if body.has_method("enemy"):
#		Transition.emit(self,"hurt_state_player")
