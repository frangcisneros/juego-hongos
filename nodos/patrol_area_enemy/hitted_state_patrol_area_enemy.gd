extends State

class_name hitted_state_patrol_area_enemy

@onready var Enemigo = get_parent().Enemigo
@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var rest_timer = Enemigo.get_node("rest")

var StateActive : bool = false

func Enter():
	Enemigo.velocity.y = -200
	if player.marker2D.scale.x == 1:
		Enemigo.velocity.x = 200
	elif player.marker2D.scale.x == -1:
		Enemigo.velocity.x = -200
	StateActive = true

func Exit():
	rest_timer.stop()
	StateActive = false

func UpdatePhysics(_delta:float):
	pass

func Update(_delta : float):
	if Enemigo.is_on_floor():
		Transition.emit(self,"idle_state_patrol_area_enemy")
	
	
	
