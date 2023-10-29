extends Control

var hearts = 5
var max_hearts = 5
@onready var player = get_tree().get_nodes_in_group("player")[0]

@onready var full_heart = $full_heart
@onready var empty_heart = $empty_heart

func _ready():
	self.max_hearts = player.max_health
	self.hearts = player.health

func _process(delta):
	hearts = player.health
	set_hearts(10)

func set_hearts(value):
	full_heart.size.x = 740 * hearts

func set_max_hearts(value):
	max_hearts = max(value,1)
	

	
