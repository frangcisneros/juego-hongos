extends State

class_name atack_state_missile_enemy

@onready var Enemigo = get_parent().Enemigo
@onready var vision = Enemigo.get_node("vision_missile_enemy")
@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var missile = preload("res://nodos/missile_enemy/missile_missile_enemy.tscn")

var StateActive : bool = false
var player_position : Vector2 = Vector2.ZERO

func Enter():
	StateActive = true
	Enemigo.add_child(missile.instantiate())

func Exit():
	StateActive = false
	
func Update(_delta : float):
	pass
			
func UpdatePhysics(_delta:float):
	pass

func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		Transition.emit(self,"idle_state_missile_enemy")
