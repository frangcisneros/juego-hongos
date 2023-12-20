extends RayCast2D

var view_distance = 2

@onready var player = get_tree().get_nodes_in_group("player")[0]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	vision_player(player.position)


func vision_player(position):
	force_raycast_update()
	set_target_position((position - get_parent().global_position) * view_distance)
	if is_colliding() and get_collider().has_method("player"):
		return true
	else:
		return false
