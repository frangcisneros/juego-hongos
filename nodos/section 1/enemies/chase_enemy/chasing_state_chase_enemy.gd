extends State

class_name chasing_state_chase_enemy
var StateActive: bool = false

@onready var Enemigo = get_parent().Enemigo
@onready var damage_area = Enemigo.get_node("damage_area/CollisionShape2D")
var aumento = 0.0
var creciendo = false


func Enter():
	StateActive = true


func Exit():
	StateActive = false


func Update(_delta: float):
	if Enemigo.health <= 0:
		Enemigo.set_rotation_degrees(180)
		Transition.emit(self, "dead_state_chase_enemy")


func UpdatePhysics(_delta: float):
	if not Enemigo.is_on_floor():
		Enemigo.velocity.y += Enemigo.gravity * _delta
	Enemigo.velocity.x = (
		(
			Enemigo.position.direction_to(
				Enemigo.get_node("state_machine_chase_enemy/idle_state_chase_enemy").player.position
			)
			* Enemigo.speed
		)
		. x
	)


func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		Transition.emit(self, "idle_state_chase_enemy")
