extends Node

class_name game

signal toggle_game_paused(is_paused: bool)

var level_instance = null
var level_name: String
var save_path = "res://save_files/save_file.save"
var player_global_position = Vector2.ZERO
var spawn_global_position = Vector2.ZERO
var checkpoint = false

var game_paused: bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_paused", game_paused)

var game_run = false


func unload_level():
	if is_instance_valid(level_instance):
		level_instance.queue_free()
	level_instance = null


func load_level(level_name: String):
	unload_level()
	var level_path = "res://world/%s.tscn" % level_name
	var level_resource = load(level_path)
	if level_resource:
		level_instance = level_resource.instantiate()
		self.add_child(level_instance)


func _ready():
	get_node("player").visible = false
	pass


func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel") and game_run:
		game_paused = !game_paused


func _process(delta):
	pass


func save():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	player_global_position = get_node("player").global_position
	file.store_var(player_global_position)
	file.store_var(level_name)
	file.store_var(PlayerStats.health)
	spawn_global_position = level_instance.get_node("spawn").global_position
	file.store_var(spawn_global_position)


func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		player_global_position = file.get_var()
		level_name = file.get_var()
		load_level(level_name)
		get_node("player").global_position = player_global_position
		PlayerStats.health = file.get_var()
		spawn_global_position = file.get_var()
		level_instance.get_node("spawn").global_position = spawn_global_position

	else:
		print("no data saved")
