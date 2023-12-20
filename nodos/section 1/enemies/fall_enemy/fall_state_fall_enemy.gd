extends State

var StateActive: bool = false

@onready var Enemigo = get_parent().Enemigo
@onready var hitbox = Enemigo.get_node("hitbox")
@onready var body: CollisionShape2D = Enemigo.get_node("hitbox/CollisionShape2D")
var aumento = 0


func Enter():
	StateActive = true
	aumento = 0
	Enemigo.gravity = -Enemigo.gravity


func Exit():
	Enemigo.gravity = -(Enemigo.gravity)
	StateActive = false


func Update(_delta: float):
	Enemigo.velocity.x = 0
	aumento += 0.1
	body.shape.extents.y += aumento
	body.get_parent().position.y -= aumento
	if Enemigo.is_on_floor():
		Transition.emit(self, "back_state_fall_enemy")
	pass


func UpdatePhysics(_delta: float):
	Enemigo.velocity.y += Enemigo.gravity * _delta
	pass

#
#func _on_hitbox_body_entered(body):
#	if body.has_method("plataforma"):
#		Transition.emit(self,"idle_state_fall_enemy")
