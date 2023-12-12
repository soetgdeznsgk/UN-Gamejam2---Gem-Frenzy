extends CharacterBody2D
class_name Player

signal surface_entered
signal mine_entered

@export var CONST_SPEED : float
@export var CONST_SPEEDUP : float

@onready var SPEED = CONST_SPEED + CONST_SPEEDUP
@onready var SPEEDUP= CONST_SPEED + CONST_SPEEDUP
var taladrando= false
var input_direction = Vector2.ZERO
var last_move=Vector2.ZERO
var movement = true

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	input_direction = Vector2(int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
	-int(Input.is_action_pressed("ui_up")))
	#print(input_direction)
	#print(SPEED)
	if taladrando:
		if input_direction==Vector2(0,-1)||input_direction==Vector2(1,-1)||input_direction==Vector2(-1,-1):
			input_direction=Vector2(0,-1)		
			SPEED = CONST_SPEED + CONST_SPEEDUP
		
		elif input_direction==Vector2(1,0):
			SPEED = CONST_SPEED
			input_direction=Vector2(1,1)
			last_move=Vector2(1,1)
		elif input_direction==Vector2(-1,0):
			SPEED = CONST_SPEED
			input_direction=Vector2(-1,1)
			last_move=Vector2(-1,1)
			
		else:
			#para que suba cuando no se oprime
			if last_move != Vector2.ZERO && input_direction!=Vector2(0,1)&& input_direction!=Vector2(1,-1)&&input_direction!=Vector2(-1,-1):
				input_direction=last_move+Vector2(0,-2)
				#print("hola no se que hace esto")
	else:
		if input_direction==Vector2(0,-1)||input_direction==Vector2(1,-1)||input_direction==Vector2(-1,-1):
			input_direction=Vector2(input_direction.x,0)
			
			
	if movement:
		velocity = input_direction.normalized() * SPEED
		move_and_slide()


func _on_area_2d_body_entered(body):
	if body is Player and taladrando:
		SPEED = CONST_SPEED + CONST_SPEEDUP
		taladrando=false
		position.y = -20.1
		surface_entered.emit()
