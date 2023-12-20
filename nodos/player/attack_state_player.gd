extends State

var StateActive: bool = false
var direction
var jumped: bool

@onready var Player = get_parent().Player
@onready var attack_collision: CollisionShape2D = Player.get_node(
	"attack_position2D/attack_area/collision_attack"
)
@onready var attack_sprite: Sprite2D = Player.get_node("attack_position2D/attack_area/sprite_attack")
@onready var attack_position2D: Marker2D = Player.get_node("attack_position2D")
@onready var position2D: Marker2D = Player.get_node("position2D")
@onready var attack_sound: AudioStreamPlayer2D = Player.get_node("attack_sound")
@onready var shake_timer: Timer = $"../../player_camera/shake_timer"


func Enter():
	Player.velocity.x = 0
	shake_timer.start()
	if not Player.attack_position2D.get_node("attack_area/sprite_attack").visible:
		Player.attack_position2D.get_node("attack_area/sprite_attack").visible = true
		attack_collision.disabled = false
		Player.get_node("attack_timer").start()

	StateActive = true
	attack_sound.play()
	jumped = false


func Exit():
	attack_collision.disabled = true
	attack_position2D.get_node("attack_area/sprite_attack").visible = false
	StateActive = false


func Update(_delta: float):
	pass


func UpdatePhysics(_delta: float):
	#direction = Input.get_axis("ui_left", "ui_right")
	#if direction > 0:
	#Player.position2D.scale.x = 1
	#elif direction < 0:
	#Player.position2D.scale.x = -1
	#if direction:
	#Player.velocity.x = direction * Player.SPEED
	#else:
	#Player.velocity.x = move_toward(Player.velocity.x, 0, Player.SPEED / 5)
	#
	#if Input.is_action_just_pressed("ui_select") and Player.is_on_floor():
	#jumped = true
	#Player.velocity.y = Player.JUMP_VELOCITY
	if attack_sprite.visible and Player.get_node("attack_timer").is_stopped():
		attack_sprite.visible = false
		attack_collision.disabled = true
		if jumped:
			Transition.emit(self, "fall_state_player")
		else:
			Transition.emit(self, "walk_state_player")
	pass
