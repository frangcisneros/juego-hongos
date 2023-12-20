extends State

@onready var Enemigo: CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D
@export var first_phase_to_attack_timer: Timer
@onready var sprite_enemigo: Sprite2D = Enemigo.get_node("position2D/Sprite2D")

@onready var attack_1_cs: CollisionShape2D = Enemigo.get_node("position2D/attack_1/CollisionShape2D")
@onready var attack_2_cs: CollisionShape2D = Enemigo.get_node("position2D/attack_2/CollisionShape2D")
@onready var attack_3_cs: CollisionShape2D = Enemigo.get_node(
	"position2D/attack_3/RigidBody2D/CollisionShape2D"
)
@onready var attack_4_cs: CollisionShape2D = Enemigo.get_node("position2D/attack_4/CollisionShape2D")

@onready var first_phase_attack2_area: Area2D = Enemigo.get_node("first_phase_attack2_area")
@onready
var first_phase_attack1_area: Area2D = Enemigo.get_parent().get_node("first_phase_attack1_area")
@onready var big_damage_area_cs = Enemigo.get_parent().get_node("big_damage_area/CollisionShape2D")
@onready var hitbox = Enemigo.get_node("hitbox")

var attack_list = ["first_phase_attack1_state_first_boss", "first_phase_attack2_state_first_boss"]
var next_attack: String
var break_ceiling: bool = false

var StateActive: bool = false
@onready var tp_first_phase = Enemigo.get_parent().get_node("tp_first_phase")
@onready var random_tp_first_phase: Array = tp_first_phase.get_children()


func Enter():
	hitbox.set_collision_mask_value(6, true)

	random_tp_first_phase.shuffle()
	Enemigo.global_position = random_tp_first_phase[0].global_position

	first_phase_to_attack_timer.start()

	# seteamos el primer ataque de la primera fase
	first_phase_attack1_area.visible = false
	first_phase_attack1_area.set_deferred("monitorable", false)
	first_phase_attack1_area.set_deferred("monitoring", false)

	first_phase_attack2_area.visible = false
	big_damage_area_cs.set_deferred("disabled", true)

	attack_1_cs.disabled = true
	attack_2_cs.disabled = true
	attack_3_cs.disabled = true
	attack_4_cs.disabled = true

	attack_1_cs.visible = false
	attack_2_cs.visible = false
	attack_3_cs.visible = false
	attack_4_cs.visible = false

	sprite_enemigo.visible = true

	attack_list.shuffle()
	StateActive = true


func Exit():
	StateActive = false


func Update(_delta: float):
	if first_phase_to_attack_timer.is_stopped():
		Transition.emit(self, attack_list[0])
#		Transition.emit(self,"first_phase_attack2_state_first_boss")
	if Enemigo.health <= 75 and not break_ceiling:
		break_ceiling = true
		Transition.emit(self, "break_ceiling_state_first_boss")

	pass


func UpdatePhysics(_delta: float):
	pass
