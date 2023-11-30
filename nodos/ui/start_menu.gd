extends Control

@export var game : game

@onready var start_menu_ui = $Panel/VBoxContainer
@onready var load_menu_ui = $Panel/VBoxContainer2
@onready var level_menu_ui = $Panel/VBoxContainer3
@onready var level2_menu_ui = $Panel/VBoxContainer4

func _ready():
	start_menu_ui.show()
	load_menu_ui.hide()
	level_menu_ui.hide()
	level2_menu_ui.hide()

func _on_new_game_pressed():
	game.load_level("test_world")
	hide()
	game.game_run = true


func _on_load_game_pressed():
	start_menu_ui.hide()
	load_menu_ui.show()


func _on_options_pressed():
	pass 


func _on_quit_pressed():
	pass 


func _on_section_1_pressed():
	load_menu_ui.hide()
	level_menu_ui.show()


func _on_section_2_pressed():
	load_menu_ui.hide()
	level2_menu_ui.show()

func _on_starting_area_pressed():
	game.load_level("/section_1/starting_area")
	hide()


func _on_first_zone_pressed():
	game.load_level("/section_1/first_zone")
	hide()


func _on_second_zone_pressed():
	game.load_level("/section_1/second_zone")
	hide()


func _on_rock_zone_pressed():
	game.load_level("/section_1/rock_zone")
	hide()


func _on_final_zone_pressed():
	game.load_level("/section_1/final_zone")
	hide()


func _on_boss_arena_pressed():
	game.load_level("/section_2/boss_arena")
	hide()

func _on_last_game_pressed():
	pass # Replace with function body.
