extends Control

@export var game : game

func _ready():
	hide()
	game.connect("toggle_game_paused",_on_game_toggle_game_paused)

func _process(delta):
	pass

func _on_game_toggle_game_paused(is_paused : bool):
	if is_paused:
		show()
	else:
		hide()


func _on_resume_pressed():
	game.game_paused = false

func _on_quit_pressed():
	get_tree().quit()
