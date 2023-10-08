extends CollisionShape2D
@onready var attack_timer = $AttackTimer
# creamos una funcion que nos modifica el ataque para que no se vea y este deshabilitado
func _ready():
	get_parent().get_parent().get_node("Marker2D").get_node("spriteAtaque").visible = false
	disabled = true
# esta funcion es llamada y detecta si la tecla presionada es la letra A y llamando al nodo "spriteAtaque" comprueba si NO es visible, si asi es, lo hace visible, lo habilita y empieza el timer de ataque
func _input(delta):
	if Input.is_key_pressed(KEY_A) and not get_parent().get_parent().get_node("Marker2D").get_node("spriteAtaque").visible:
			get_parent().get_parent().get_node("Marker2D").get_node("spriteAtaque").visible = true
			disabled = false
			attack_timer.start()

# una vez que el timer termina, o sea lo que dura la aparicion del ataque, se asegura que el sprite sea visible y entonces lo deja de mostrar y vuelve a deshabilitarlo
func _process(delta):
	if get_parent().get_parent().get_node("Marker2D").get_node("spriteAtaque").visible and attack_timer.is_stopped():
			get_parent().get_parent().get_node("Marker2D").get_node("spriteAtaque").visible = false
			disabled = true
