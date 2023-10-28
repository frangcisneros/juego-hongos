extends RigidBody2D

var rng = RandomNumberGenerator.new()
var magnet = false
var player = false

func _ready():
	linear_velocity = Vector2(rng.randf_range(-150,150),rng.randf_range(-150,-150)) 

func _process(delta):
	pass

func _physics_process(delta):
	if magnet:
		linear_velocity = (position.direction_to(player.position) * 300)

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		magnet = true
		player = body

func coin():
	pass
