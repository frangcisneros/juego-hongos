extends State

class_name idle_state_player

var StateActive : bool = false
@onready var Player = get_parent().Player
var direction
#var enemigo_position = Vector2.ZERO

func Enter():
	StateActive = true

func Exit():
	StateActive = false
	
func Update(_delta : float):
	if Player.velocity.x != 0:
		Player.velocity.x = move_toward(Player.velocity.x, 0, Player.SPEED / 5)
	direction = Input.get_axis("ui_left", "ui_right")

func UpdatePhysics(_delta : float):
	if direction and Player.is_on_floor():
		Transition.emit(self,"walk_state_player")
	
	if Input.is_action_just_pressed("ui_select"):
		Player.jump_buffer_timer.start()

	if not Player.jump_buffer_timer.is_stopped() and (Player.is_on_floor() or not Player.coyote_timer.is_stopped()):
		Transition.emit(self,"jump_state_player")

#func _on_hitbox_player_body_entered(body):
#	if body.has_method("enemy"):
#		Transition.emit(self,"hurt_state_player")
