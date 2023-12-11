extends CharacterBody2D


var SPEED = 300.0
var SPEEDUP= 400.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var input_direction = Vector2.ZERO

func _physics_process(delta):
	# Add the gravity.

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	input_direction = Vector2(int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
	-int(Input.is_action_pressed("ui_up")))
	if input_direction==Vector2(1,0):
		SPEED=SPEED
		input_direction=Vector2(1,1)
	elif input_direction==Vector2(-1,0):
		SPEED=SPEED
		input_direction=Vector2(-1,1)
	elif input_direction==Vector2(0,1):
		SPEED=SPEEDUP
	velocity = input_direction.normalized() * SPEED
	move_and_slide()
