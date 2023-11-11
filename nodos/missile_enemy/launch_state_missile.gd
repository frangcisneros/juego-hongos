extends State

class_name launch_state_missile
var StateActive : bool = false
@onready var Proyectil : RigidBody2D = get_parent().Proyectil

@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var path : Path2D = Proyectil.get_node("Path2D")
@onready var path_follow : PathFollow2D = path.get_node("PathFollow2D")

var player_position
var angle
var velocity
var local_player_position
var accelerate : bool = false

func Enter():
	player_position = player.global_position
	local_player_position = player_position - Proyectil.global_position
	
	path.curve.set_point_position(2,local_player_position)
	StateActive = true

func Exit():
	StateActive = false
	
func Update(_delta : float):
	if Proyectil.position.y <= path.curve.get_point_position(1).y:
		
		accelerate = true
		
	if not accelerate:
		path_follow.progress += 1
	else:
		path_follow.progress += 5

	Proyectil.position = path_follow.position
	if path_follow.progress_ratio == 1:
		path_follow.progress = 0
		Proyectil.linear_velocity = Vector2.ZERO
		Proyectil.gravity_scale = 0
		Transition.emit(self,"explode_state_missile")
	pass

func UpdatePhysics(_delta:float):
	pass


func _on_hitbox_body_entered(body):
	if body.has_method("player"):
		path_follow.progress = 0
		Proyectil.linear_velocity = Vector2.ZERO
		Proyectil.gravity_scale = 0
		Transition.emit(self,"explode_state_missile")
