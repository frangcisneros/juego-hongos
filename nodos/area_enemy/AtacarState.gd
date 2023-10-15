extends State

class_name AtacarState_areaEnemy

@onready var Enemigo = get_parent().Enemigo
@onready var damage_area = Enemigo.get_node("damage_area/CollisionShape2D")
var aumento = 0.0
var creciendo = false

func Enter():
	creciendo = true

func Exit():
	pass
		
func Update(_delta : float):
	if(Enemigo.health <= 0):
		Enemigo.set_rotation_degrees(180)
		Transition.emit(self, "DeadState_areaEnemy")
		
	if aumento < 50.0 and creciendo:
		aumento += 1
	elif aumento >= 50 and creciendo:
		creciendo = false
	elif (aumento - 0.5) > 0.0 and not creciendo:
		aumento -= 1
	elif aumento == 0 and not creciendo:
		Transition.emit(self,"ReposoState_areaEnemy")
	damage_area.shape.extents = Vector2(aumento,aumento)
	