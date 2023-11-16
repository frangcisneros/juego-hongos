extends Node2D


@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var game : game = get_parent()

func _ready():
	player.visible = true
	player.position = Vector2(0,-50)


func _on_transition_area_body_entered(body):
	if body.has_method("player"):
		game.load_level("/section_1/first_zone")
