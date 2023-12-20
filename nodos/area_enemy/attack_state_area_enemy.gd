extends State

class_name atack_state_area_enemy

@onready var Enemigo = get_parent().Enemigo
var aumento = 0.0
var creciendo = false
@export var animation_tree : AnimationTree
@export var animation_player : AnimationPlayer
@onready var state_machine = animation_tree["parameters/playback"]
var StateActive : bool = false

func Enter():
	StateActive = true
	state_machine.travel("attack")
	animation_player.set("speed_scale", 1)
#	creciendo = true
#	sprite
#	sprite.scale.x = sprite_scale_x
#	sprite.scale.y = sprite_scale_y

func Exit():
	pass
		
func Update(_delta : float):
	if(Enemigo.health <= 0):
		Enemigo.set_rotation_degrees(180)
		Transition.emit(self, "dead_state_area_enemy")
		StateActive = false
#
#	if aumento < 50.0 and creciendo:
#		aumento += 1
#	elif aumento >= 50 and creciendo:
#		creciendo = false
#	elif (aumento - 0.5) > 0.0 and not creciendo:
#		aumento -= 1
#	elif aumento == 0 and not creciendo:
#		Transition.emit(self,"idle_state_area_enemy")
#	damage_area.shape.extents = Vector2(aumento,aumento)
#	sprite.scale.x =  (aumento/50) * sprite_scale_x
#	sprite.scale.y =  (aumento/50) * sprite_scale_y
#
