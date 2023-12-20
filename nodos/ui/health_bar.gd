extends Control

@export var game: game

@onready var heart = $heart
@onready var empty_heart = $empty_heart

var hearts = PlayerStats.health


func _ready():
	pass


func _process(delta):
	if game.game_run:
		show()
	else:
		hide()
	hearts = PlayerStats.health
	set_hearts(hearts)


func set_hearts(value):
	heart.size.x = 1280 * value
	if value <= 0:
		heart.hide()
	else:
		heart.show()
