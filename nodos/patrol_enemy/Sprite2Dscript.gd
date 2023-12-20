extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var img = Image.load_from_file("res://arte/Animaciones/Seccion 1 Musgo/patrulla/frames/death/0001.png")
	var tex = ImageTexture.create_from_image(img)
	self.texture = tex


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
