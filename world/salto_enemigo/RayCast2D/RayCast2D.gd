extends RayCast2D

var first_object
var primera_vez = true

@onready var salto_enemigo = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_collider_rid().is_valid() and primera_vez:
		first_object = get_collider()
		primera_vez = false
	if get_collider() != first_object and get_collider().has_method("plataforma"):
		get_parent().darse_vuelta()

