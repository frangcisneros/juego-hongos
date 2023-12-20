extends State

var StateActive: bool = false

@onready var Player = get_parent().Player
@onready var reappear_timer: Timer = Player.get_node("reappear_timer")
@onready var checkpoints
@onready var checkpoint
@onready var hitbox_player_cs: CollisionShape2D = Player.get_node("hitbox_player/CollisionShape2D")


func Enter():
	PlayerStats.health = 5
	reappear_timer.start()
	Player.visible = false
	StateActive = true


func Exit():
	Player.gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	StateActive = false


func Update(_delta: float):
	Player.velocity = Vector2.ZERO
	Player.gravity = 0
	if reappear_timer.is_stopped():
		Transition.emit(self, "reappear_state_player")

	pass


func UpdatePhysics(_delta: float):
	pass
