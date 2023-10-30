extends CharacterBody2D
class_name template_enemy

var health : int
var sprite_enemigo : Sprite2D
var coin = preload("res://nodos/collectables/coin_collectable.tscn")
@onready var player = get_tree().get_nodes_in_group("player")[0]

signal hitted

func hit(damage: int):
	hitted.emit()
	health -= damage
	sprite_enemigo.modulate = Color.from_hsv(0,1-health/20,1)


func _process(delta):
	print(velocity.x)

func enemy():
	pass

func _physics_process(delta):
	move_and_slide()

func drop_coin(amount):
	for i in range(amount):
		var coin_instance = coin.instantiate()
		coin_instance.global_position = self.global_position
		get_parent().add_child(coin_instance)
