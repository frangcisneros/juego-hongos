extends SubViewport


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Wait 1 frame so everything is drawn
	await get_tree().process_frame  

#Make a "screenshot" of the viewport
	var backgroundSnapshot:Image = get_viewport().get_texture().get_image() 

#Create an ImageTexture with it  
	var backgroundImage := ImageTexture.create_from_image(backgroundSnapshot)  

#Add it to the scene in a Sprite2D  
	var background := Sprite2D.new()    
	background.texture = backgroundImage  
	add_child(background)  
