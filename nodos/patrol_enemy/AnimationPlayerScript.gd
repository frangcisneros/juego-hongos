extends AnimationPlayer

@export_dir var animations_directory
@export var animation_tree : AnimationTree
@onready var animations_dic :  Dictionary = {}
@onready var animation_velocity = 24 #in fps
@onready var time_between_keyframes = 1/animation_velocity
@onready var animation : Animation
@onready var number_of_files : int
@onready var img = Image.new()
@onready var tex = ImageTexture.new()
@onready var state_machine = animation_tree["tree_root"]
@onready var state_machine_playback = animation_tree["parameters/playback"]

signal Ended
#@onready var animation_library : AnimationLibrary
# Called when the node enters the scene tree for the first time.
func _ready():
	dir_contents(animations_directory)
	print(get_animation_list())
	Ended.emit()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(state_machine_playback.get_current_node())
#	pass

func dir_contents(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
#				print("Found directory: " + file_name)
				animation = Animation.new()
				get_animation_library("").add_animation(file_name, animation)
				state_machine.add_node(file_name,get_animation(file_name))
				number_of_files = dir.get_files_at(path + "/" + file_name).size()/2
				animation.add_track(0)
				animation.track_set_path(0,"position2D/Sprite2D:texture")
				for i in number_of_files:
					img.load(path + "/" + file_name + "/%04d"  % i + ".png")
					tex.create_from_image(img)
					animation.track_insert_key(0,time_between_keyframes*i,tex)
			else:
				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
