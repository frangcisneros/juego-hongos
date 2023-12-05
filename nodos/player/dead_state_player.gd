extends State


var StateActive : bool = false

@onready var Player = get_parent().Player
@onready var reappear_timer : Timer = Player.get_node("reappear_timer")
@onready var checkpoints
@onready var checkpoint
@onready var hitbox_player : Area2D = Player.get_node("hitbox_player")

func Enter():
	reappear_timer.start()
	Player.velocity = Vector2.ZERO
	Player.visible = false
	PlayerStats.health = 5
	StateActive = true

func Exit():
	StateActive = false
	
func Update(_delta : float):
	if reappear_timer.is_stopped():
		Transition.emit(self,"reappear_state_player")		

	pass

func UpdatePhysics(_delta : float):
	pass
