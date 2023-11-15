extends State

class_name jump_state_player

var StateActive : bool = false
var direction = false
var stop_jump = false

@onready var Player = get_parent().Player

func Enter():
	Player.jump_buffer_timer.stop()
	Player.velocity.y = Player.JUMP_VELOCITY
	Player.coyote_timer.stop()
	StateActive = true

func Exit():
	StateActive = false
	Player.velocity.x = 0
	
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
	if Input.is_action_just_released("ui_select") and not Player.is_on_floor() and Player.velocity.y < 0: 
		Player.velocity.y /= Player.velocity.y
	if Player.is_on_floor():
		Transition.emit(self,"idle_state_player")
		
	if Input.is_action_just_pressed("ui_select"):
		Player.jump_buffer_timer.start()
	
	if not Player.jump_buffer_timer.is_stopped() and (Player.is_on_floor() or not Player.coyote_timer.is_stopped()):
		Transition.emit(self,"jump_state_player")

#func _on_hitbox_player_body_entered(body):
#	if body.has_method("enemy"):
#		Transition.emit(self,"hurt_state_player")
