extends Control

@export var game : game
@onready var start_menu = game.get_node("CanvasLayer/start_menu")

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


func _on_save_pressed():
	game.save()


func _on_load_pressed():
	game.load_data()


func _on_menu_pressed():
	hide()
	game.unload_level()
	game.get_node("player").visible = false
	game.game_paused = false
	game.game_run = false
	start_menu.for_ready()
