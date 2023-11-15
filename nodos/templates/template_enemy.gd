extends CharacterBody2D
class_name template_enemy

var health : int
@onready var sprite_enemigo : Sprite2D
var coin = preload("res://nodos/collectables/coin_collectable.tscn")
@onready var player : CharacterBody2D

signal hitted

func hit(damage: int):
	hitted.emit()
	health -= damage
	sprite_enemigo.modulate = Color.from_hsv(0,1-health/20,1)


func _process(delta):
	pass

func enemy():
	pass

func _physics_process(delta):
	move_and_slide()

func drop_coin(amount):
	for i in range(amount):
		var coin_instance = coin.instantiate()
		coin_instance.global_position = self.global_position
		get_parent().add_child(coin_instance)
