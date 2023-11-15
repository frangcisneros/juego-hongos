extends Node2D


@onready var player = get_tree().get_nodes_in_group("player")[0]

func _ready():
	player.visible = true
	player.position = Vector2(-1465,-64)
