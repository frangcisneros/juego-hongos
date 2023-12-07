extends Control

@export var game : game

@onready var start_menu_ui = $Panel/start_menu_ui
@onready var load_menu_ui = $Panel/load_menu_ui
@onready var level_menu_ui = $Panel/level_menu_ui
@onready var level2_menu_ui = $Panel/level2_menu_ui
@onready var options_menu = $Panel/options_menu
@onready var video_options = $Panel/video_options
@onready var audio_options = $Panel/audio_options

func _ready():
	for_ready()

func _process(delta):
	pass

func _on_new_game_pressed():
	game.level_name = "test_world"
	game.game_run = true
	game.load_level(game.level_name)
	hide()

func _on_load_game_pressed():
	start_menu_ui.hide()
	load_menu_ui.show()

func _on_back_load_pressed():
	start_menu_ui.show()
	load_menu_ui.hide()

func _on_options_pressed():
	start_menu_ui.hide()
	options_menu.show()

func _on_video_pressed():
	options_menu.hide()
	video_options.show()

func _on_audio_pressed():
	options_menu.hide()
	audio_options.show()


func _on_back_options_pressed():
	options_menu.hide()
	start_menu_ui.show()


func _on_quit_pressed():
	get_tree().quit()


func _on_section_1_pressed():
	load_menu_ui.hide()
	level_menu_ui.show()


func _on_section_2_pressed():
	load_menu_ui.hide()
	level2_menu_ui.show()

func _on_starting_area_pressed():
	game.level_name = "/section_1/starting_area"
	game.load_level(game.level_name)
	game.game_run = true
	hide()


func _on_first_zone_pressed():
	game.level_name = "/section_1/first_zone"
	game.load_level(game.level_name)
	game.game_run = true
	hide()


func _on_second_zone_pressed():
	game.level_name = "/section_1/second_zone"
	game.load_level(game.level_name)
	game.game_run = true
	hide()


func _on_rock_zone_pressed():
	game.level_name = "/section_1/rock_zone"
	game.load_level(game.level_name)
	game.game_run = true
	hide()


func _on_final_zone_pressed():
	game.level_name = "/section_1/final_zone"
	game.load_level(game.level_name)
	game.game_run = true
	hide()


func _on_boss_arena_pressed():
	game.level_name = "/section_2/boss_arena"
	game.load_level(game.level_name)
	game.game_run = true
	hide()

func _on_last_game_pressed():
	game.load_data()
	game.game_run = true
	hide()
	
func for_ready():
	show()
	start_menu_ui.show()
	load_menu_ui.hide()
	level_menu_ui.hide()
	level2_menu_ui.hide()
	options_menu.hide()
	video_options.hide()
	audio_options.hide()








func _on_back_video_pressed():
	video_options.hide()
	options_menu.show()


func _on_back_audio_pressed():
	audio_options.hide()
	options_menu.show()


func _on_back_level_1_pressed():
	level_menu_ui.hide()
	load_menu_ui.show()


func _on_back_level_2_pressed():
	level2_menu_ui.hide()
	load_menu_ui.show()


func _on_full_screen_toggled(button_pressed):
	if button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_vsync_toggled(button_pressed):
	if button_pressed:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		

func _on_master_value_changed(value):
	pass # Replace with function body.


func _on_music_value_changed(value):
	pass # Replace with function body.


func _on_sound_fx_value_changed(value):
	pass # Replace with function body.
