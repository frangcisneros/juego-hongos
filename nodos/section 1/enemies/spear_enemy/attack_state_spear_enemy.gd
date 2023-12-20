extends State

var StateActive: bool = false

@onready var Enemigo = get_parent().Enemigo
@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var path: Path2D = Enemigo.get_node("Path2D")
@onready var path_follow: PathFollow2D = path.get_node("PathFollow2D")

var player_position
var local_player_position
var accelerate: bool = false


func Enter():
	Enemigo.gravity = 0
	Enemigo.velocity = Vector2.ZERO
	player_position = player.global_position
	local_player_position = player_position - Enemigo.global_position
	path.curve.set_point_position(0, Enemigo.global_position)
	path.curve.set_point_position(1, player_position)
	StateActive = true


func Exit():
	Enemigo.gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	path.curve.set_point_position(0, Vector2.ZERO)
	StateActive = false


func Update(_delta: float):
	path_follow.progress += 5
	Enemigo.position = path_follow.position
	if path_follow.progress_ratio == 1:
		path_follow.progress = 0
		Enemigo.velocity = Vector2.ZERO
		print("fdakjnsl")
		Transition.emit(self, "idle_state_spear_enemy")
	pass


func UpdatePhysics(_delta: float):
	pass


func _on_hitbox_body_entered(body):
	if body.has_method("player"):
		path_follow.progress = 0
		Enemigo.velocity = Vector2.ZERO
		Transition.emit(self, "idle_state_spear_enemy")
