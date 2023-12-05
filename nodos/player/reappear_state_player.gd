extends State


var StateActive : bool = false

@onready var Player = get_parent().Player
@onready var checkpoints = Player.get_parent().get_node("checkpoints")
@onready var checkpoint : Marker2D
@onready var hitbox_player_cs : CollisionShape2D = Player.get_node("hitbox_player/CollisionShape2D")

func Enter():
	Player.global_position = Player.get_parent().level_instance.spawn.global_position
	Player.visible = true
	StateActive = true

func Exit():
	Player.player_alive = true
	
func Update(_delta : float):
	Transition.emit(self,"idle_state_player")
	pass

func UpdatePhysics(_delta : float):
	pass
