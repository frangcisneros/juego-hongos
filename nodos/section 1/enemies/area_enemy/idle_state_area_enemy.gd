extends State

class_name idle_state_area_enemy

var StateActive: bool = false

@onready var Enemigo = get_parent().Enemigo
@onready var damage_area = Enemigo.get_node("damage_area/CollisionShape2D")
@onready var sprite: Sprite2D = Enemigo.get_node("damage_area/CollisionShape2D/Sprite2D2")
@onready
var detection_area_cs: CollisionShape2D = Enemigo.get_node("detection_area/CollisionShape2D2")
@onready var tiempo_ataque: Timer = Enemigo.get_node("tiempo_ataque")

var atacar = false


func Enter():
	detection_area_cs.set_deferred("disabled", false)
	damage_area.shape.extents = Vector2(0, 0)
	StateActive = true


func Exit():
	detection_area_cs.set_deferred("disabled", true)
	atacar = false
	StateActive = false


func Update(_delta: float):
	if tiempo_ataque.is_stopped() and atacar:
		Transition.emit(self, "attack_state_area_enemy")
	if Enemigo.health <= 0:
		Enemigo.set_rotation_degrees(180)
		Transition.emit(self, "dead_state_area_enemy")


func UpdatePhysics(_delta: float):
	if not Enemigo.is_on_floor():
		Enemigo.velocity.y += Enemigo.gravity * _delta


func _on_detection_area_body_entered(body):
	if body.has_method("player") and StateActive:
		atacar = true
		tiempo_ataque.start()
