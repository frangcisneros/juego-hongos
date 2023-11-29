extends Area2D

@export var damage : int = 5 # export es para poder modificarla sin modificar codigo

const initial_position = 70

func _on_area_entered(area):
	if area.has_method("enemy") and area.get_parent().has_method("enemy"):
		area.get_parent().hit(damage) # se llama al metodo hit donde se le pasa como parametro el daño
		

func attack():
	pass
