extends Node2D

@onready var Camara : Camera2D = get_node("Protagonista/Camera2D")
@onready var Rectangulo : CollisionShape2D =  get_node("limitesCamara/limitesCamaraShape")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	Camara.limit_left = -Rectangulo.shape.size.x/2+Rectangulo.position.x
	Camara.limit_right = Rectangulo.shape.size.x/2+Rectangulo.position.x
	Camara.limit_top = -Rectangulo.shape.size.y/2+Rectangulo.position.y
	Camara.limit_bottom = Rectangulo.shape.size.y/2+Rectangulo.position.y
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
