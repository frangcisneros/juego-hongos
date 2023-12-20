extends Camera2D

@onready var shake_timer = $shake_timer
@onready var player = get_parent()


func _ready():
	pass


func _process(delta):
	if not shake_timer.is_stopped() and player.is_on_floor():
		shake_camera()
	pass


func shake_camera():
	offset = Vector2(randf_range(-1, 1) * 2, randf_range(-1, 1) * 2)
