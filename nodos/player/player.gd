extends CharacterBody2D


# variables
const SPEED = 300.0 # velocidad
const JUMP_VELOCITY = -600.0 # velocidad de salto
const initialPos = Vector2(519,554) # posicion inicial en el mundo para resetear luego
const FLOOR = Vector2.UP

var retroceso_vector = Vector2.ZERO
var retroceso_normal = 500

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") # obtiene la gravedad desde la configuracion global del proyecto

var player_alive = true
var enemigo_rango = false
#var enemigo_position = Vector2.ZERO

@onready var coyote_timer = $coyote_timer # asigna el nodo coyotetimer a una variable
@onready var jump_buffer_timer = $jump_buffer_timer # asigna el nodo jumpbuffertimer a una variable
@onready var position2D = $position2D # esto nos servira para ir dando vuelta los sprites
@onready var attack_position2D = $attack_position2D
@onready var attack_area = $attack_position2D/attack_area
@onready var retroceso_tiempo = $knockback_timer
@onready var hitbox = $hitbox_player
@onready var tiempo_invencibilidad = $invincibility_timer

func _ready():
	add_to_group("player")

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			global_position = get_global_mouse_position()

func _process(delta):
	invencibilidad()

func _physics_process(delta):
	if PlayerStats.health <=0:
		player_alive = false
#		PlayerStats.health = 0
	#print(velocity.x)
	if not is_on_floor():
		if velocity.y < 0: # cuando cae este es afectado por la gravedad
			velocity.y += gravity * delta
		else:
			velocity.y += gravity * 1.75 * delta # cuando salta, es afectado por la gravedad para que caiga mas rapido y no tan suave
			velocity.y = clamp(velocity.y, 0, 1000)
	move_and_slide()

func player():
	pass

func invencibilidad():
	if not tiempo_invencibilidad.is_stopped() or not player_alive: #si le pegaron al pj lo hacemos invencible
		# esto es lo que uso para cambiar como interactuan los objetos
		hitbox.set_collision_mask_value(2,false)
		hitbox.set_collision_layer_value(1,false)
		set_collision_layer_value(1,false)
		set_collision_mask_value(2,false) 
		set_collision_layer_value(5,true)
	else: #si no le pegaron en los ultimos X segundos, no es invencible
		hitbox.set_collision_mask_value(2,true)
		hitbox.set_collision_layer_value(1,true)
		set_collision_layer_value(1,true)
		set_collision_mask_value(2,true) 
		set_collision_layer_value(5,false) 

func _on_hitbox_player_body_entered(body):
	if body.has_method("coin"):
		body.queue_free()
