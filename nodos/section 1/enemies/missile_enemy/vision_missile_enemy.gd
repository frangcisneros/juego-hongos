extends RayCast2D

var view_distance = 1.05

@onready var player = get_tree().get_nodes_in_group("player")[0]


func _ready():
	pass


func _process(delta):
	vision_player(player.position)


func vision_player(position):
	force_raycast_update()
	set_target_position((position - get_parent().global_position) * view_distance)
	if is_colliding() and get_collider().has_method("player"):
		return true
	else:
		return false
