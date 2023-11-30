extends State


var StateActive : bool = false

@onready var Player = get_parent().Player
@onready var reappear_timer : Timer = Player.get_node("reappear_timer")
@onready var checkpoints
@onready var checkpoint : Marker2D
@onready var hitbox_player : Area2D = Player.get_node("hitbox_player")

func Enter():
	if Player.get_parent().level_instance:
		checkpoints = Player.get_parent().level_instance.get_node("checkpoints").get_children()
	for i in checkpoints:
		if Player.global_position > i.global_position:
			checkpoint = i
		else:
			checkpoint = checkpoints[0]
	reappear_timer.start()
	Player.velocity = Vector2.ZERO
	Player.visible = false
	PlayerStats.health = 5
	
	StateActive = true

func Exit():
	StateActive = false
	
func Update(_delta : float):
	if reappear_timer.is_stopped():
		Player.global_position = checkpoint.global_position
		Transition.emit(self,"reappear_state_player")
	pass

func UpdatePhysics(_delta : float):
	pass
