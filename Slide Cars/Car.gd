tool
extends KinematicBody2D

var x : bool = false
var y : bool = false
export var speed : float = 1
export (Texture) var texture setget setTexture, getTexture 
var collision_box : CollisionShape2D
var selected = false

func setTexture (value:Texture) -> void:
	$CarTexture.texture =value	
	
func getTexture () -> Texture:
	return 	$CarTexture.texture 
		

func _ready():
	# auto assign drag direction
	if rotation_degrees == 0:
		print(self.to_string()+" is horizontal")
		x = true
		y = false
	else:
		print(self.to_string()+" is vertical")
		x = false
		y = true
	#	
	# assign texture 
	if texture: 
		print("Loading "+texture.to_string())
		setTexture(texture)	
	#
	# auto scale Collision box
		collision_box = CollisionShape2D.new()
		var car_size = RectangleShape2D.new()
		var img_size = texture.get_rect()
		car_size.set_extents(img_size)
		collision_box.shape = car_size
		
		pass
	
func _on_Car_input_event(viewport, event, shape_idx):
	print("click !")
	if Input.is_action_just_pressed("click"):
		print("Selected: "+ self.to_string())
		selected = true
 
func _physics_process(delta):
	if selected:
		if x:
			global_position.x = lerp(global_position.x, get_global_mouse_position().x, speed * delta)
		elif y:
			global_position.y = lerp(global_position.y, get_global_mouse_position().y, speed * delta)
		
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
