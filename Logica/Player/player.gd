extends CharacterBody2D
class_name Player

var SPEED = 300.0
var SPEEDUP= 400.0
var taladrando= true
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var input_direction = Vector2.ZERO
var last_move=Vector2.ZERO
func _physics_process(delta):
	# Add the gravity.
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	input_direction = Vector2(int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
	-int(Input.is_action_pressed("ui_up")))
	#print(input_direction)
	print(SPEED)
	if taladrando:
		if input_direction==Vector2(0,-1):
			input_direction=Vector2(0,-1)
			
			SPEED=SPEEDUP
		elif input_direction==Vector2(1,0):
			SPEED=SPEED
			input_direction=Vector2(1,1)
			last_move=Vector2(1,1)
		elif input_direction==Vector2(-1,0):
			SPEED=SPEED
			input_direction=Vector2(-1,1)
			last_move=Vector2(-1,1)
		else:
			if last_move != Vector2.ZERO && input_direction!=Vector2(0,1):
				input_direction=last_move+Vector2(0,-2)
	else:
		if input_direction==Vector2(0,-1)||input_direction==Vector2(1,-1)||input_direction==Vector2(-1,-1):
			input_direction=Vector2(input_direction.x,0)
		if Input.is_action_just_pressed("ui_up"):
			print("soy una accion")
		
		
	velocity = input_direction.normalized() * SPEED
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body is Player:
		SPEED=300
		taladrando=false
	pass # Replace with function body.
