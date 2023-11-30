extends Node

class_name state_machine_player

@export var initial_state : State
@export var Player: CharacterBody2D
@onready var attack_position2D : Marker2D = Player.get_node("attack_position2D")
@onready var position2D : Marker2D = Player.get_node("position2D")
var states :  Dictionary = {}
var currentState : State

# un for que ciclee por los hijos del nodo y si son estados (if child is State) los agregue al diccionario (states[child.name] = child)
func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transition.connect(on_child_transition)
	if initial_state:
		initial_state.Enter()
		currentState = initial_state 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(currentState)
	if Player.player_alive == false:
		on_child_transition(currentState,"dead_state_player")
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


func _on_hitbox_player_body_entered(body):
	if body.has_method("enemy"):
		on_child_transition(currentState,"hurt_state_player")


func _on_hitbox_player_area_entered(area):
	if area.has_method("enemy"):
		on_child_transition(currentState,"hurt_state_player")

func _input(event):
	var just_pressed = event.is_pressed() and not event.is_echo()
	if Input.is_action_pressed("ui_up") and position2D.scale.x == 1:
		attack_position2D.rotation_degrees = -90
	elif Input.is_action_pressed("ui_up") and position2D.scale.x == -1:
		attack_position2D.rotation_degrees = 90
	if Input.is_key_pressed(KEY_Z) and just_pressed:
		on_child_transition(currentState, "attack_state_player")
