extends State

class_name idle_state_area_enemy

var StateActive : bool = false

@onready var Enemigo = get_parent().Enemigo
@onready var damage_area = Enemigo.get_node("damage_area/CollisionShape2D")


func Enter():
	damage_area.shape.extents = Vector2(0,0)
	StateActive = true

func Exit():
	StateActive = false
	
func Update(_delta : float):
#	print("Reposo")
	if(Enemigo.health <= 0):
		Enemigo.set_rotation_degrees(180)
		Transition.emit(self, "dead_state_area_enemy")
#	print(Enemigo.health)

func UpdatePhysics(_delta : float):
	if not Enemigo.is_on_floor():
		Enemigo.velocity.y += Enemigo.gravity * _delta

func _on_detection_area_body_entered(body):
	if body.has_method("player") and StateActive:
		Transition.emit(self, "attack_state_area_enemy")
