extends RayCast2D

var first_object
var primera_vez = true
var posicion_inicial = Vector2.ZERO
var primera_posicion = true

@onready var decabeza_enemigo = get_parent()

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_collider_rid().is_valid() and primera_vez:
		first_object = get_collider()
		primera_vez = false
	if get_parent().is_on_ceiling() and primera_posicion:
		posicion_inicial = get_parent().position
		primera_posicion = false


