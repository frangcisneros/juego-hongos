# Author: Juanma Rodriguez, @juanmar0driguez, 1juanmartinrodriguez@gmail.com

@tool #so that it runs on the editor and you can see your animations in the animation player // para que corra en el editor y puedas ver tus animaciones en el animation player
extends AnimationTree #put thois code on an animation tree node // codigo para un animation tree node

@export_dir var animations_directory # Directory in which the animations are placed. The animations must be folders on their own and each frame for the animation must be a .png image with the name 0001, 0002, ... , 0010 and so on // Directiorio en el que estan las animaciones. Las animaciones deben estar cada una en su carpeta y cada frame de la animacion debe ser un archivo png con el nombre 0001,0002,...,0010, etcetera
@export var animation_player : AnimationPlayer #animation player where the animations will be loaded // animation player en el que se van a cargar las animaciones
@onready var animation_velocity = 24.0 #speed of the animation in fps // velocidad de la animacion en fps
@onready var time_between_keyframes= 1/animation_velocity #time between each frame of the animation // tiempo entre cada frame de la animacion
@onready var animation : Animation #placeholder animation node
@onready var animation_node : AnimationNodeAnimation #placeholder animationNodeAnimation node
@onready var number_of_files : float #will count how many frames are in each folder // va a contar cuantos archivos hay en cada carpeta
@onready var state_machine = self["tree_root"] #state machine of the animation tree // maquina de estado del animation tree
@onready var tex : CompressedTexture2D #placeholder compressedTexture node to load the textures for each frame // placeholder compressedTexture node que va a cargar las texturas para cada frame

func _ready():
	dir_contents(animations_directory) #call function dir_contents (called like that cause i copied it from internet and then modified it). It will do everything (loads the frames, creates the animations, the keyframes, etc).//llamada a la funcion dir_contents (se llama asi porque la copie de internet y despues la modifique. Hace todo (carga los frames, crea la animacion, los keyframes, etc)
	pass

func _process(delta):
	pass

func dir_contents(path):
	var dir = DirAccess.open(path) # from here... // desde aca...
	if dir: #
		dir.list_dir_begin() #
		var file_name = dir.get_next() #
		while file_name != "": #
			if dir.current_is_dir() and not animation_player.get_animation_library("").has_animation(file_name): #to here, its code that i copied from the internet. I dont really know how it works, but it accesses the directory and finds each folder in there. The "and not ..." in the if expression its mine. It prevents the code from loading one animation if its already loaded. If you want to rework your animation, delete it from the animation player and delete its node from the state machine in the animation tree. // hasta aca, es codigo que copie de internet. No entiendo muy bien como funciona, pero accede al directorio especificado y encuentra cada carpeta ahi. El "and not ..."  en este if es mio. Previene que el codigo cargue una animacion si ya se cargo antes. Para cambiar algo en la animacion, tenes que eliminarla de el animation player y eliminar su nodo de la state machine en el animation tree
				animation = Animation.new() # creates a new animation//creamos una nueva animacion 
				animation_node = AnimationNodeAnimation.new() # creates a new animationnodeanimation node // crea un nuevo animationnodeanimation node
				animation_player.get_animation_library("").add_animation(file_name, animation) # we acces the library of animations of the animation player and add the animation "animation" under the name saved in file_name (this name is the name of the current folder, so each animation will be named as the folder that contains it) // accedemos a la biblioteca de animaciones del animation player y añadimos la animacion "animation" bajo el nombre guardado en file_name (este nombre es el nombre de la carpeta actual, por lo tanto cada animacion se va a llamar como la carpeta que lo contiene)
				state_machine.add_node(file_name,animation_node,Vector2(0, 0)) #we add an animation node to the state machine with the same name as the file_name // añadimos un animation node a la maquina de estados con el mismo nombre que file_name
				state_machine.get_node(file_name).animation = file_name # we tell the animation node we just created that its animation will be the animation of the animation player that has the same name as itself // le decimos al animation node que acabamos de crear que su animacion va a ser la animacion del animation player que tiene el mismo nombre que el
				number_of_files = dir.get_files_at(path + "/" + file_name).size()/2 #the amount of frames in the folder. Its divided by two because godot creates an .import file for each png, so the total amount of files in the folder duplicates. // la cantidad de frames en la carpeta. Dividido dos porque godot crea un archivo .import por cada png, entonces se duplica la cantidad de archivos en la carpeta
				animation_player.get_animation(file_name).add_track(0) #we add a track in the animation//  añadimos un track en la animacion
				animation_player.get_animation(file_name).set_loop_mode(1) #loop mode
				animation_player.get_animation(file_name).value_track_set_update_mode(0,1) #update mode
				animation_player.get_animation(file_name).track_set_interpolation_loop_wrap(0, true) #interpolation wrap
				animation_player.get_animation(file_name).set_length(number_of_files*time_between_keyframes) #the length of the animation will be the amount of frames times the time each frame is shwon // la duracion de la animacion sera la cantidad de frames por el tiempo que se muestre cada frame
				animation_player.get_animation(file_name).track_set_interpolation_type(0,Animation.INTERPOLATION_LINEAR) #interpolation type
				animation_player.get_animation(file_name).track_set_path(0,"position2D/Sprite2D:texture") #here we set the path of the property we will change (the texture of the sprite in this case) // aca ponemos el path de la propiedad que vamos a cambiar (la textura del sprite, en este caso
				animation_player.get_animation(file_name).set_step(time_between_keyframes) #step size
				
				for i in number_of_files: #we cycle through each file in the folder (each frame) // por cada archivo en la carpeta (cada frame)
					tex = ResourceLoader.load(path + "/" + file_name + "/%04d"  % (i+1) + ".png") #we load the frame to a texture using resourceLoader so we load a compressed texture (MUCH faster to process for godot) // cargamos el frame a una textura usando resourceLoader para cargar una compressedTexture (MUCHO mas rapida de cargar para godot)
					animation_player.get_animation(file_name).track_insert_key(0,i*time_between_keyframes,tex) # we create a key in the animation at the corresponding time and pass the texture as the value of the key  // creamos una key en la animacion en el tiempo correrespondiente y pasamos la textura como el valor de la key
			else: #from here... // de aca...
				pass#
			file_name = dir.get_next()#
	else:#
		print("An error occurred when trying to access the path.")# to here, more code i copied from internet // hasta aca, mas codigo que copie de internet
