extends State

@onready var Enemigo: CharacterBody2D = get_parent().Enemigo
@onready var position2D = get_parent().position2D
@onready var wait_attack2_timer: Timer = Enemigo.get_node("wait_attack2_timer")
@onready var first_phase_attack2_area = Enemigo.get_node("first_phase_attack2_area")
@onready var boss_platforms = Enemigo.get_parent().get_node("boss_platforms")
@export var first_phase_to_window: Timer
@export var change_safe_areas_attack_2: Timer
@onready var sprite_enemigo: Sprite2D = Enemigo.get_node("position2D/Sprite2D")
var StateActive: bool = false
@onready var platforms: Array = boss_platforms.get_children()
@onready var safe_areas: Array = first_phase_attack2_area.get_children()
@onready var hitbox = Enemigo.get_node("hitbox")
@onready var big_damage_area_cs: CollisionShape2D = Enemigo.get_parent().get_node(
	"big_damage_area/CollisionShape2D"
)

var make_damage = true


func Enter():
	platforms = boss_platforms.get_children()

	Enemigo.set_collision_layer_value(2, false)
	hitbox.set_collision_mask_value(6, false)
	hitbox.set_collision_layer_value(2, false)

	sprite_enemigo.visible = false
	first_phase_attack2_area.visible = true

	first_phase_to_window.start()
	activate_platforms(platforms, safe_areas)
	wait_attack2_timer.start()
	StateActive = true


func Exit():
	first_phase_attack2_area.visible = false
	StateActive = false


func Update(_delta: float):
	if wait_attack2_timer.is_stopped() and make_damage:
		big_damage_area_cs.set_deferred("disabled", false)

	if change_safe_areas_attack_2.is_stopped():
		activate_platforms(platforms, safe_areas)
		change_safe_areas_attack_2.start()

	if first_phase_to_window.is_stopped():
		Transition.emit(self, "first_phase_window_state_first_boss")
	pass


func UpdatePhysics(_delta: float):
	pass


func activate_platforms(platforms, safe_areas):
	platforms.shuffle()
	safe_areas.shuffle()
	for i in range(safe_areas.size()):
		safe_areas[i].global_position = platforms[i].global_position


func _on_first_phase_attack_2_area_body_entered(body):
	if body.has_method("player"):
		make_damage = false
		big_damage_area_cs.set_deferred("disabled", true)


func _on_first_phase_attack_2_area_body_exited(body):
	if body.has_method("player"):
		make_damage = true
		wait_attack2_timer.start()
