extends Node

class_name state_machine_missile_enemy

@export var initial_state : State
@export var Enemigo: CharacterBody2D

var is_dead = false

var states :  Dictionary = {}
var currentState : State
# Called when the node enters the scene tree for the first time.
func _ready():
#	Enemigo.hitted.connect(on_hit_transition)
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transition.connect(on_child_transition)
	if initial_state:
		initial_state.Enter()
		currentState = initial_state 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	currentState.Update(delta)
	if(Enemigo.health <= 0) and not is_dead:
		Enemigo.set_rotation_degrees(180)
		Enemigo.velocity.x = 0
		on_child_transition(currentState, "dead_state_missile_enemy")
		is_dead = true
	

func _physics_process(delta):
	currentState.UpdatePhysics(delta)

func on_child_transition(state, new_state_name):
	if state != currentState:
		return
	
	var new_state = states.get(new_state_name.to_lower())

	if !new_state:
		print("El estado al que quisiste pasar no existe")
		return

	if currentState:
		currentState.Exit() #si actualmente estas en un estado, salis del estado actual (podria ser que no estes en un estado definido, por ejemplo, al arrancar el programa)

	new_state.Enter() #entras la nuevo estado

	currentState = new_state #haces que el nuevo estado sea el estado actual

#func on_hit_transition():
#	on_child_transition(currentState, "hitted_state_patrol_area_enemy")