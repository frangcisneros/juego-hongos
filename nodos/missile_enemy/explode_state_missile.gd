extends State

class_name explode_state_missile

var StateActive : bool = false

func Enter():
	StateActive = true

func Exit():
	StateActive = false
	
func Update(_delta : float):
	pass
			
func UpdatePhysics(_delta:float):
	pass


