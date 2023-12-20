extends Area2D

@export var spawn: Marker2D


func _on_body_entered(body):
	if body.has_method("player"):
		spawn.global_position = self.global_position
