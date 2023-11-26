extends Sprite2D

var player : CharacterBody2D
var main_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	main_scene = get_node("/root").get_child(1)
	player = main_scene.get_node("player")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if abs(player.position.x - self.position.x) <= 800:
		self.visible = true
	else: self.visible = false
