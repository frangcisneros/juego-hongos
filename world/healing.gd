extends ProgressBar

@export var game: game

@onready var Player = game.get_node("player")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game.game_run:
		show()
	else:
		hide()
	value = Player.get_node("state_machine_player/healing_state_player").amount
	pass
