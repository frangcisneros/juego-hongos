extends State

@export var hitted_timer: Timer
@export var rest_timer: Timer
@export var animation_player: AnimationPlayer
@export var animation_tree: AnimationTree

@onready var Enemigo = get_parent().Enemigo
@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var hitted_particles: GPUParticles2D = Enemigo.get_node("position2D/hitted_particles")
@onready var hurt_sound: AudioStreamPlayer2D = Enemigo.get_node("hurt_sound")

var StateActive: bool = false
var hitted = false


func Enter():
	hurt_sound.play()
	hitted_particles.emitting = true
	animation_tree.set("parameters/conditions/unhit", false)
	animation_tree.set("parameters/conditions/hit", true)
	Enemigo.velocity.y = -100
	if player.position2D.scale.x == 1:
		Enemigo.velocity.x = 150
	elif player.position2D.scale.x == -1:
		Enemigo.velocity.x = -150
	StateActive = true


func Exit():
	animation_tree.set("parameters/conditions/hit", false)
	animation_tree.set("parameters/conditions/unhit", true)
	rest_timer.stop()
	hitted = false
	StateActive = false


func UpdatePhysics(_delta: float):
	if Enemigo.is_on_floor() and not hitted:
		Enemigo.velocity = Vector2.ZERO
		hitted_timer.start()
		hitted = true


func Update(_delta: float):
	if Enemigo.is_on_floor() and hitted_timer.is_stopped():
		Transition.emit(self, "idle_state_patrol_enemy")
