extends State

var StateActive : bool = false
var direction
var jumped : bool

@onready var Player = get_parent().Player
@onready var attack_collision: CollisionShape2D = Player.get_node("attack_area/collision_attack")
@onready var attack_sprite : Sprite2D = Player.get_node("position2D/sprite_attack")

func Enter():
	if not Player.position2D.get_node("sprite_attack").visible:
			Player.position2D.get_node("sprite_attack").visible = true
			attack_collision.disabled = false
			attack_collision.get_node("attack_timer").start()
	StateActive = true
	jumped = false

func Exit():
	StateActive = false
	
func Update(_delta : float):
	direction = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_just_pressed("ui_select") and Player.is_on_floor():
		jumped = true
		Player.velocity.y = Player.JUMP_VELOCITY
	if direction > 0:
		Player.position2D.scale.x = 1
		Player.attack_area.position.x = Player.attack_area.initial_position
	elif direction < 0:
		Player.position2D.scale.x = -1
		Player.attack_area.position.x = - Player.attack_area.initial_position
	if attack_sprite.visible and attack_collision.get_node("attack_timer").is_stopped():
			attack_sprite.visible = false
			attack_collision.disabled = true
			if jumped:
				Transition.emit(self,"fall_state_player")
			else:
				Transition.emit(self,"walk_state_player")

func UpdatePhysics(_delta : float):	
	if direction:
		Player.velocity.x = direction * Player.SPEED
#func _on_hitbox_player_body_entered(body):
#	if body.has_method("enemy"):
#		Transition.emit(self,"hurt_state_player")
