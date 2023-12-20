extends State

@onready var Enemigo = get_parent().Enemigo
@export var corpse_timer: Timer
var StateActive: bool = false


func Enter():
	StateActive = true


func Update(_delta: float):
	pass
