extends CharacterBody2D

class_name Player

# variables
const SPEED = 300.0 # velocidad
const JUMP_VELOCITY = -400.0 # velocidad de salto
const initialPos = Vector2(519,554) # posicion inicial en el mundo para resetear luego
const FLOOR = Vector2.UP

var retroceso_vector = Vector2.ZERO
var retroceso_normal = 500

var hitted = false



var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") # obtiene la gravedad desde la configuracion global del proyecto
var health = 100
var player_alive = true
var enemigo_rango = false

var enemigo_position = Vector2.ZERO

@onready var coyote_timer = $CoyoteTimer # asigna el nodo coyotetimer a una variable
@onready var jump_buffer_timer = $JumpBufferTimer # asigna el nodo jumpbuffertimer a una variable
@onready var marker2D = $Marker2D # esto nos servira para ir dando vuelta los sprites
@onready var ataque = $Ataque
@onready var retroceso_tiempo = $retroceso_tiempo
@onready var hitbox = $hitbox
@onready var tiempo_invencibilidad = $tiempo_invencibilidad

func _ready():
	add_to_group("player")

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			global_position = get_global_mouse_position()

func _process(delta):
	update_health()
	invencibilidad()

func _physics_process(delta): # toda la logica fisica del personaje
#	update_health()
	
	if health <=0:
		player_alive = false
		health = 0
	
	if not is_on_floor():
		if velocity.y < 0: # cuando cae este es afectado por la gravedad
			velocity.y += gravity * delta
		else:
			velocity.y += gravity * 1.75 * delta # cuando salta, es afectado por la gravedad para que caiga mas rapido y no tan suave
			velocity.y = clamp(velocity.y, 0, 750)
		

# creamos la logica del jump buffer (que tome el boton de salto aunque no estemos en el suelo)
	if Input.is_action_just_pressed("ui_select"):
		jump_buffer_timer.start() # si presionamos saltar, empezamos el timer del jump buffer
	
	if not jump_buffer_timer.is_stopped() and (is_on_floor() or not coyote_timer.is_stopped()): # si el timer NO esta detenido Y estamos en el suelo O el timer coyote NO esta detenido, el personaje salta, este salto puede ser ingresado en el aire debido a que podemos iniciar el timer sin estar en el suelo 
		velocity.y = JUMP_VELOCITY
		jump_buffer_timer.stop() # y se detiene el timer del jump buffer
	if Input.is_action_just_released("ui_select") and not is_on_floor() and velocity.y < 0: # si soltamos el boton de saltar Y NO estamos en el suelo Y nuestra velocidad es menor a cero (el -1 es hacia arriba, o sea es si estabamos saltando) 
		velocity.y /= velocity.y # detiene la subida, asignando al valor de la velocidad su mismo valor dividida por ella misma

	var direction = Input.get_axis("ui_left", "ui_right") # obtenemos la direccion del jugador dependiendo la entrada
	
	# si la direccion es derecha, la escala del marker es 1, sino -1, esto da vuelta el sprite
	if retroceso_tiempo.is_stopped():
		if direction > 0:
			marker2D.scale.x = 1
			ataque.position.x = ataque.initial_position
		elif direction < 0:
			marker2D.scale.x = -1
			ataque.position.x = - ataque.initial_position
		
		# movimiento horizontal
		if direction: # ver si direction tiene un valor distinto a cero
			velocity.x = direction * SPEED # esto ya nos permite ir a la izquierda o a la derecha dependiendo de la direccion
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED / 10) # disminuye gradualmente la velocidad, que iria desde el valor de la velocidad, hasta cero con el paso dado por la rapidez
	
	var was_on_floor = is_on_floor() # define una variable con el mismo valor de is on floor

	
	move_and_slide() # metodo para moverse
	
	if was_on_floor && !is_on_floor(): # si las variables de estaba en el suelo es distinta a esta en el suelo (o sea el personaje esta en el aire) empieza el timer de coyote
		coyote_timer.start()
	
	# resetea si se cae
	if position.y >= 650:
		position = initialPos
		
	
func update_health():
	var healthbar = $healthbar
	healthbar.value = health

func player():
	pass

func _on_hitbox_body_entered(body):
	if body.has_method("enemy"):
		print("ay")
		health = health - 1
		enemigo_position = body.global_position
		retroceso_tiempo.start()
		retroceso_vector = (global_position - enemigo_position).normalized() * retroceso_normal
		velocity.x = retroceso_vector.x
		velocity.y = -200
		if tiempo_invencibilidad.is_stopped(): #si el personaje no es invencible
			tiempo_invencibilidad.start() #lo hacemos invencible por un tiempo
		

func _on_hitbox_body_exited(body): #conectado por las dudas
	pass # Replace with function body.


func _on_hitbox_area_entered(area):
	if area.has_method("enemy"):
#		enemigo_rango = true
		health = health - 1
		#hitted = true
		enemigo_position = area.global_position
		retroceso_tiempo.start()
		retroceso_vector = (global_position - enemigo_position).normalized() * retroceso_normal
		velocity.x = retroceso_vector.x
		velocity.y = -200
		if tiempo_invencibilidad.is_stopped(): #si el personaje no es invencible
			tiempo_invencibilidad.start() #lo hacemos invencible por un tiempo

func invencibilidad():
	if not tiempo_invencibilidad.is_stopped(): #si le pegaron al pj lo hacemos invencible
		# esto es lo que uso para cambiar como interactuan los objetos
		# deberia haber una forma de cambiar mas facil el tema de las hitbox
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

