extends State

var StateActive: bool = false
var stop: bool = false
var right: bool = true

@onready var Enemigo = get_parent().Enemigo
@onready var hitbox = Enemigo.get_node("hitbox")


func Enter():
	hitbox.monitorable = false
	Enemigo.velocity.x = 15
	StateActive = true


func Exit():
	hitbox.set_deferred("monitorable", true)
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


func _on_hitbox_area_entered(area):
	if area.has_method("attack"):
		Transition.emit(self, "turtle_state_armor_walker")


func _on_collision_query_2_body_entered(body):
	if body.has_method("plataforma") and Enemigo.is_on_floor():
		Enemigo.scale.x = -Enemigo.scale.x
		Enemigo.velocity.x = -Enemigo.velocity.x
		right = !right
