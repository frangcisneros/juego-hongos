extends State

@onready var Enemigo: CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D
@onready var player = get_tree().get_nodes_in_group("player")[0]
@export var attack_to_second_phase: Timer
@onready var attack_1_cs: CollisionShape2D = Enemigo.get_node("position2D/attack_1/CollisionShape2D")
var initial_position: Vector2

var StateActive: bool = false


func Enter():
	initial_position = attack_1_cs.position
	attack_1_cs.visible = true
	attack_1_cs.disabled = false

	attack_to_second_phase.start()

	StateActive = true


func Exit():
	attack_1_cs.position = initial_position
	attack_1_cs.shape.radius = 36
	attack_1_cs.visible = false
	attack_1_cs.disabled = true
	StateActive = false


func Update(_delta: float):
	if attack_to_second_phase.is_stopped():
		Transition.emit(self, "second_phase_initial_state_boss_first_boss")

	attack_1_cs.global_position.x += (0.6 * Enemigo.position2D.scale.x)
	attack_1_cs.shape.radius += 0.6
	pass


func UpdatePhysics(_delta: float):
	pass
