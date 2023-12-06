extends State


var StateActive : bool = false

@onready var Player = get_parent().Player
@onready var hurt_sound : AudioStreamPlayer2D = Player.get_node("hurt_sound")

func Enter():
	hurt_sound.play()
	StateActive = true
	PlayerStats.health = PlayerStats.health - 1
	if Player.position2D.scale.x == 1:
		Player.velocity.x = -1000
	else:
		Player.velocity.x = 1000
	Player.velocity.y = -200


func Exit():
	StateActive = false
	
func Update(_delta : float):
	Transition.emit(self,"idle_state_player")

func UpdatePhysics(_delta : float):
	pass
