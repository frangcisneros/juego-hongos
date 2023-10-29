extends Node2D

@onready var game = get_parent()

func _on_test_2_transition_point_body_entered(body):
	if body.has_method("player"):
		game.load_level("test_2")
