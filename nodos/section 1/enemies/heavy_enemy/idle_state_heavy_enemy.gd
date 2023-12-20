extends State

var StateActive: bool = false
var stop: bool = false
@onready var right: bool = true

@onready var Enemigo = get_parent().Enemigo
@onready var attack: CollisionShape2D = Enemigo.get_node("attack/CollisionShape2D")
@onready var vision: RayCast2D = get_parent().vision


func Enter():
	attack.disabled = true
	Enemigo.velocity.x = 15
	StateActive = true


func Exit():
	StateActive = false


func Update(_delta: float):
	pass


func UpdatePhysics(_delta: float):
	if not Enemigo.is_on_floor():
		Enemigo.velocity.y += Enemigo.gravity * _delta
	if right:
		Enemigo.velocity.x = Enemigo.SPEED
	else:
		Enemigo.velocity.x = -Enemigo.SPEED


func _on_collision_query_body_exited(body):
	if body.has_method("plataforma") and Enemigo.is_on_floor():
		Enemigo.scale.x = -Enemigo.scale.x
		Enemigo.velocity.x = -Enemigo.velocity.x
		right = !right


func _on_detection_area_body_entered(body):
	if body.has_method("player") and StateActive:
		if vision.vision_player(body.position):
			Transition.emit(self, "attack_state_heavy_enemy")
