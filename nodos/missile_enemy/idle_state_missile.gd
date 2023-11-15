extends State

class_name idle_state_missile

var StateActive : bool = false
@onready var Proyectil : RigidBody2D = get_parent().Proyectil

func Enter():
	StateActive = true
	
	
func Exit():
	
	StateActive = false
	
func Update(_delta : float):
	Transition.emit(self,"launch_state_missile")
	pass
			
func UpdatePhysics(_delta:float):
	pass


