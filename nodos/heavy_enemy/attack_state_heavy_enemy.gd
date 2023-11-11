extends State


var StateActive : bool = false

@onready var Enemigo = get_parent().Enemigo
@export var attack_wait_timer : Timer
@export var stop_attack_timer : Timer
@onready var attack : CollisionShape2D = Enemigo.get_node("attack/CollisionShape2D")
@onready var vision : RayCast2D = get_parent().vision
var atacar = true

@onready var player = get_tree().get_nodes_in_group("player")[0]

var posicion_objetivo : Vector2 


func Enter():
	posicion_objetivo = player.position
	if posicion_objetivo.x - Enemigo.position.x >= 5:
		if Enemigo.velocity.x < 0:
			Enemigo.scale.x *= -1 
			vision.scale.x = - vision.scale.x
			get_parent().get_node("idle_state_heavy_enemy").right = true
	elif posicion_objetivo.x - Enemigo.position.x <= -5:
		if Enemigo.velocity.x > 0:
			Enemigo.scale.x *= -1 
			vision.scale.x = - vision.scale.x
		get_parent().get_node("idle_state_heavy_enemy").right = false
	
	Enemigo.velocity = Vector2.ZERO
	attack_wait_timer.start()
	StateActive = true

func Exit():
	atacar = true
	StateActive = false
	
func Update(_delta : float):
	if attack_wait_timer.is_stopped() and atacar:
		attack.disabled = false
		stop_attack_timer.start()
		atacar = false
	if stop_attack_timer.is_stopped() and not atacar:
		Transition.emit(self,"idle_state_heavy_enemy")

func UpdatePhysics(_delta : float):
	pass

