extends State


var StateActive : bool = false

@onready var Player = get_parent().Player
@onready var checkpoints = Player.get_parent().get_node("checkpoints")
@onready var checkpoint : Marker2D
@onready var hitbox_player_cs : CollisionShape2D = Player.get_node("hitbox_player/CollisionShape2D")

func Enter():
	print("reapareciendo")
	hitbox_player_cs.disabled = false
	Player.visible = true
	StateActive = true

func Exit():
	Player.set_collision_layer_value(1,true)
	Player.set_collision_mask_value(2,true)
#	Player.set_collision_mask_value(4,true)	
	Player.set_collision_mask_value(5,true)		
	StateActive = false
	
func Update(_delta : float):
	Transition.emit(self,"idle_state_player")
	pass

func UpdatePhysics(_delta : float):
	pass
