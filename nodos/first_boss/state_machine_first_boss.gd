extends Node

@export var initial_state : State
@export var Enemigo: CharacterBody2D
@export var position2D : Marker2D

var states :  Dictionary = {}
var currentState : State

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transition.connect(on_child_transition)
	
	if initial_state:
		initial_state.Enter()
		currentState = initial_state 

func _process(delta):
	print(currentState)
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
		currentState.Exit()

	new_state.Enter()
	currentState = new_state


