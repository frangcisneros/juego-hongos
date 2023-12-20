extends AnimationPlayer

#@export_dir var animations
var animations_dic :  Dictionary = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	dir_contents(animations)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func dir_contents(dir):
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
				animations_dic[file_name] = file_name
			else:
				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
