extends Control

var pause = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and not pause:
		show()
		pause = true
		Engine.time_scale = 0
	elif Input.is_action_just_pressed("ui_cancel") and pause:
		hide()
		pause = false
		Engine.time_scale = 1


func _on_resume_pressed():
	hide()
	pause = false
	Engine.time_scale = 1


func _on_quit_pressed():
	get_tree().quit()
