extends RayCast2D

var view_distance = 0.4

@onready var player = get_tree().get_nodes_in_group("player")[0]


func _process(delta):
	vision_player(player.position)


func vision_player(position):
	force_raycast_update()

	set_target_position(
		Vector2(
			(
				get_parent().scale.x
				* (position.x - get_parent().get_parent().global_position.x)
				* view_distance
			),
			(position.y - get_parent().get_parent().global_position.y) * view_distance
		)
	)
	if is_colliding() and get_collider().has_method("player"):
		return true
	else:
		return false
#		*
