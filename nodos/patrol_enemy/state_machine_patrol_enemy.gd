extends Node

@export var initial_state : State
@export var Enemigo: CharacterBody2D
@export var position2D : Marker2D
@export var animation_tree : AnimationTree

var states :  Dictionary = {}
var currentState : State

func _ready():
	Enemigo.hitted.connect(on_hit_transition)
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transition.connect(on_child_transition)
	if initial_state:
			initial_state.Enter()
			currentState = initial_state

func _process(delta):
	currentState.Update(delta)

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

func on_hit_transition():
	if Enemigo.health < 0:
		on_child_transition(currentState, "hitted_state_patrol_enemy")
	else:
		on_child_transition(currentState, "hitted_state_patrol_enemy")
