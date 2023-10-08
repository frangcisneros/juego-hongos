extends Area2D

@export var damage : int = 5 # export es para poder modificarla sin modificar codigo

const initial_position = 70

func _on_body_entered(body): # metodo que se llama automaticamente cuando el area colisiona con otro objeto fisico (el parametro body)
	if body.has_method("enemy"):
		body.hit(damage) # se llama al metodo hit donde se le pasa como parametro el daño
