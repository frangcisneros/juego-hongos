extends State

class_name atack_state_area_enemy

@onready var Enemigo = get_parent().Enemigo
@onready var damage_area = Enemigo.get_node("damage_area/CollisionShape2D")
@onready var sprite = Enemigo.get_node("damage_area/CollisionShape2D/Sprite2D2")
@onready var sprite_scale_x = sprite.scale.x
@onready var sprite_scale_y = sprite.scale.y
var aumento = 0.0
var creciendo = false


func Enter():
	creciendo = true
	sprite.scale.x = sprite_scale_x
	sprite.scale.y = sprite_scale_y
	sprite.visible = true


func Exit():
	sprite.visible = false
	sprite.scale.x = 0
	sprite.scale.y = 0
	pass


func Update(_delta: float):
	if Enemigo.health <= 0:
		Enemigo.set_rotation_degrees(180)
		Transition.emit(self, "dead_state_area_enemy")

	if aumento < 50.0 and creciendo:
		aumento += 1
	elif aumento >= 50 and creciendo:
		creciendo = false
	elif (aumento - 0.5) > 0.0 and not creciendo:
		aumento -= 1
	elif aumento == 0 and not creciendo:
		Transition.emit(self, "idle_state_area_enemy")
	damage_area.shape.extents = Vector2(aumento, aumento)
	sprite.scale.x = (aumento / 50) * sprite_scale_x
	sprite.scale.y = (aumento / 50) * sprite_scale_y
