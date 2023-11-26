extends State

class_name idle_state_jump_enemy

var StateActive : bool = false
@onready var Enemigo = get_parent().Enemigo
@onready var jump_cd = Enemigo.get_node("jump_cd")
@onready var raycast = Enemigo.get_node("RayCast2D")

var first_object
var primera_vez = true
var right = true

func Enter():
	jump_cd.start()
	StateActive = true

func Exit():
	Enemigo.velocity.x = 0
	StateActive = false
	
func Update(_delta : float):
	if(Enemigo.health <= 0):
		Enemigo.set_rotation_degrees(180)
		Transition.emit(self, "dead_state_jump_enemy")
		
	if raycast.get_collider_rid().is_valid():
		if primera_vez:
			first_object = raycast.get_collider()
			primera_vez = false
		if raycast.get_collider() != first_object and raycast.get_collider().has_method("plataforma"):
			Enemigo.scale.x = - Enemigo.scale.x
			Enemigo.velocity.x = - Enemigo.velocity.x
			right = !right

func UpdatePhysics(_delta : float):
	if right:
		Enemigo.velocity.x = Enemigo.SPEED
	else:
		Enemigo.velocity.x = - Enemigo.SPEED
	if jump_cd.is_stopped() and Enemigo.is_on_floor():
		Enemigo.velocity.y = Enemigo.JUMP_VELOCITY
		jump_cd.start()

func _on_collision_query_body_exited(body):
	if body.has_method("plataforma") and Enemigo.is_on_floor():
		Enemigo.scale.x = - Enemigo.scale.x
		Enemigo.velocity.x = - Enemigo.velocity.x
		right = !right
