extends State

class_name dead_state_patrol_area_enemy

@onready var Enemigo = get_parent().Enemigo
@onready var damage_area = Enemigo.get_node("damage_area/CollisionShape2D")
@export var corpse_timer : Timer
var StateActive : bool = false
var aumento = 0.0
var creciendo = false

func Enter():	
	creciendo = true
	Enemigo.velocity.x = 0;
	Enemigo.set_rotation_degrees(180)
	corpse_timer.start()
	StateActive = true

func Update(_delta : float):
	if aumento < 100.0 and creciendo:
		aumento += 1
	elif aumento >= 100 and creciendo:
		creciendo = false
	elif (aumento - 0.5) > 0.0 and not creciendo:
		aumento -= 1
	elif aumento == 0 and not creciendo and corpse_timer.is_stopped():
		Enemigo.queue_free()
	damage_area.shape.extents = Vector2(aumento,aumento)
	
	
	
