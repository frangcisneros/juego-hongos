extends State

class_name ReposoState

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
		Transition.emit(self, "DeadState")
#	print(Enemigo.health)

func UpdatePhysics(_delta : float):
	pass

func _on_detection_area_body_entered(body):
	if body.has_method("player") and StateActive:
		Transition.emit(self, "AtacarState")
