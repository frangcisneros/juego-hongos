extends State

var StateActive: bool = false

@onready var Player = get_parent().Player
@onready var heal_timer: Timer = Player.get_node("heal_timer")

var amount = 0


func Enter():
	heal_timer.start()
	StateActive = true


func Exit():
	amount = 0
	heal_timer.stop()
	StateActive = false


func Update(_delta: float):
	if heal_timer.is_stopped():
		amount += 1
		Player.soul -= 1
		heal_timer.start()

	if amount == 5 and PlayerStats.health < 5:
		PlayerStats.health += 1
		amount = 0

	if Player.soul <= 0:
		Transition.emit(self, "idle_state_player")

	pass


func UpdatePhysics(_delta: float):
	pass


func _input(event):
	if not Input.is_key_pressed(KEY_C) and not event.is_pressed() and not event.is_echo():
		Transition.emit(self, "idle_state_player")
