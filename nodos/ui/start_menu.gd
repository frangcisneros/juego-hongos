extends Control

@export var game : game

@onready var start_menu_ui = $Panel/VBoxContainer
@onready var load_menu_ui = $Panel/VBoxContainer2

func _ready():
	start_menu_ui.show()
	load_menu_ui.hide()

func _on_new_game_pressed():
	game.load_level("test_world")
	hide()
	game.game_run = true


func _on_load_game_pressed():
	start_menu_ui.hide()
	load_menu_ui.show()


func _on_options_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	pass # Replace with function body.


func _on_level_1_pressed():
	game.load_level("test_1")
	hide()


func _on_level_2_pressed():
	game.load_level("test_2")
	hide()
