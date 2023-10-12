extends Area2D

@onready var damage_area = get_parent().get_node("damage_area").get_child(0)
@onready var tiempo_ataque = $tiempo_ataque
var atacar = false
var aumento = 0.0

func _ready():
	damage_area.shape.extents = Vector2(0,0)

func _on_body_entered(body):
	if body.has_method("player"):
		tiempo_ataque.start()
		atacar = true

func _on_body_exited(body):
	if body.has_method("player"):
		atacar = false

func ataque():
	if tiempo_ataque.is_stopped() and atacar:
		for i in 50:
			aumento += 0.01
	elif (aumento - 0.5) > 0.0:
		aumento -= 0.5	
	else:
		aumento = 0

func _process(delta):
	ataque()
	damage_area.shape.extents = Vector2(aumento,aumento)


