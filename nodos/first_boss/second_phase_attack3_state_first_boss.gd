extends State

@onready var Enemigo: CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D
@onready var attack_3_rigidbody: RigidBody2D = Enemigo.get_node("position2D/attack_3/RigidBody2D")
@onready var player = get_tree().get_nodes_in_group("player")[0]
@export var attack_to_second_phase: Timer
@onready var attack_3: Area2D = Enemigo.get_node("position2D/attack_3")
@onready var attack_3_cs: CollisionShape2D = Enemigo.get_node(
	"position2D/attack_3/RigidBody2D/CollisionShape2D"
)

var initial_position: Vector2
var initial_global_position: Vector2

var StateActive: bool = false


func Enter():
	attack_3_rigidbody.linear_velocity = Vector2(0.1, 0.1)
	attack_3_rigidbody.sleeping = false
	attack_3_rigidbody.freeze = false
	initial_position = attack_3.position
	initial_global_position = attack_3_rigidbody.global_position

	attack_3.set_deferred("monitoring", true)
	attack_3.set_deferred("monitorable", true)
	attack_3_cs.visible = true
	attack_3_cs.disabled = false

	attack_to_second_phase.start()

	attack_3_rigidbody.apply_force(Vector2(Enemigo.position2D.scale.x * 9000, 0))
	StateActive = true


func Exit():
	attack_3.position = initial_position
	attack_3_rigidbody.sleeping = true
	attack_3_rigidbody.freeze = true
	attack_3_rigidbody.global_transform.origin = initial_global_position
	attack_3_rigidbody.global_rotation = 0
	attack_3.set_deferred("monitoring", false)
	attack_3.set_deferred("monitorable", false)
	StateActive = false


func Update(_delta: float):
	if attack_3_rigidbody.linear_velocity == Vector2.ZERO:
		Transition.emit(self, "second_phase_initial_state_boss_first_boss")
	pass


func UpdatePhysics(_delta: float):
	pass
