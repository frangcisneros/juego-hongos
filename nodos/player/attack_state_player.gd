extends State

var StateActive : bool = false
var direction
var jumped : bool

@onready var Player = get_parent().Player
@onready var attack_collision: CollisionShape2D = Player.get_node("attack_position2D/attack_area/collision_attack")
@onready var attack_sprite : Sprite2D = Player.get_node("attack_position2D/attack_area/sprite_attack")
@onready var attack_position2D : Marker2D = Player.get_node("attack_position2D")
@onready var position2D : Marker2D = Player.get_node("position2D")
@onready var attack_sound : AudioStreamPlayer2D = Player.get_node("attack_sound")

func Enter():
	if not Player.attack_position2D.get_node("attack_area/sprite_attack").visible:
		Player.attack_position2D.get_node("attack_area/sprite_attack").visible = true
		attack_collision.disabled = false
		attack_collision.get_node("attack_timer").start()
	
	if not Input.is_action_pressed("ui_up"):
		attack_position2D.rotation_degrees = 0
		
	
	StateActive = true
	attack_sound.play()
	jumped = false

func Exit():
	attack_position2D.rotation_degrees = 0
	StateActive = false
	
func Update(_delta : float):
	pass

func UpdatePhysics(_delta : float):	
	if Input.is_action_just_pressed("ui_up") and position2D.scale.x == 1:
		attack_position2D.rotation_degrees = -90
	elif Input.is_action_just_pressed("ui_up") and position2D.scale.x == -1:
		attack_position2D.rotation_degrees = 90
	
	direction = Input.get_axis("ui_left", "ui_right")
	if direction > 0:
		Player.position2D.scale.x = 1
		Player.attack_area.position.x = Player.attack_area.initial_position
	elif direction < 0:
		Player.position2D.scale.x = -1
		Player.attack_area.position.x = - Player.attack_area.initial_position
	if direction:
		Player.velocity.x = direction * Player.SPEED
	else:
		Player.velocity.x = move_toward(Player.velocity.x, 0, Player.SPEED / 5)
	
	if Input.is_action_just_pressed("ui_select") and Player.is_on_floor():
		jumped = true
		Player.velocity.y = Player.JUMP_VELOCITY
	if attack_sprite.visible and attack_collision.get_node("attack_timer").is_stopped():
			attack_sprite.visible = false
			attack_collision.disabled = true
			if jumped:
				Transition.emit(self,"fall_state_player")
			else:
				Transition.emit(self,"walk_state_player")
#func _on_hitbox_player_body_entered(body):
#	if body.has_method("enemy"):
#		Transition.emit(self,"hurt_state_player")
