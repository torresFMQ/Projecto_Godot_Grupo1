tool
extends KinematicBody2D

var x : bool = false
var y : bool = false
#movement aid variables
var mx : float
var my : float
var mVec : Vector2
#
export var speed : float = 1
export var jitter : float = 5
export (Texture) var texture setget setTexture, getTexture 
var selected = false

func setTexture (value:Texture) -> void:
	print("Setting Texture for "+self.to_string()+" = "+value.to_string())
	$CarTexture.texture =value	
	setCollisionArea(value)
	
func getTexture () -> Texture:
	return 	$CarTexture.texture 
		
func setCollisionArea(value:Texture):
	# auto scale Collision box
		var car_size = RectangleShape2D.new()
		car_size.set_extents(value.get_size())
		
		$Collision.set_shape(car_size)
	
func _ready():
	# auto assign drag direction
	if rotation_degrees == 0:
		#print(self.to_string()+" is horizontal")
		x = true
		y = false
	else:
		#print(self.to_string()+" is vertical")
		x = false
		y = true
	
func _on_Car_input_event(viewport, event, shape_idx):
	#print("click !")
	if Input.is_action_just_pressed("click"):
		print("Selected: "+ self.to_string())
		selected = true
 
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false

func _physics_process(delta):
	if selected:
		var dir = (get_global_mouse_position()-global_position).normalized()
			
		if x:
		#HORIZONTAL
			dir.y=0
			#make it shake
			global_scale += Vector2(jitter/250,jitter/250)
			global_position.x += jitter/2
			global_position.y += jitter
			jitter *= -1
			
		elif y:
		#VERTICAL			
			dir.x=0
			#make it shake
			global_scale += Vector2(jitter/250,jitter/250)
			global_position.x += jitter
			global_position.y += jitter/2
			jitter *= -1
		
		move_and_slide(dir*delta*9000*speed)
