extends CharacterBody2D
class_name Player

signal surface_entered
signal mine_entered

@export var CONST_SPEED : float
@export var CONST_SPEEDUP : float

@onready var SPEED = CONST_SPEED + CONST_SPEEDUP
@onready var SPEEDUP= CONST_SPEED + CONST_SPEEDUP
@onready var Anim : AnimationTree = $AnimationTree
@onready var AnimState : AnimationNodeStateMachinePlayback = Anim.get("parameters/playback")
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
		#movimiento taladrando
		
		if input_direction==Vector2(0,-1)||input_direction==Vector2(1,-1)||input_direction==Vector2(-1,-1):
			input_direction=Vector2(0,-1)		
			SPEED = CONST_SPEED + CONST_SPEEDUP
			AnimState.travel("Taladrando")
			Anim.set("parameters/Taladrando/blend_position", Vector2(input_direction.x,-input_direction.y))
		elif input_direction==Vector2(1,0):
			SPEED = CONST_SPEED
			input_direction=Vector2(1,1)
			last_move=Vector2(1,1)
			AnimState.travel("Taladrando")
			Anim.set("parameters/Taladrando/blend_position", Vector2(input_direction.x,-input_direction.y))
		elif input_direction==Vector2(-1,0):
			SPEED = CONST_SPEED
			input_direction=Vector2(-1,1)
			last_move=Vector2(-1,1)
			AnimState.travel("Taladrando")
			Anim.set("parameters/Taladrando/blend_position", Vector2(input_direction.x,-input_direction.y))
			
		else:
			#para que suba cuando no se oprime
			if last_move != Vector2.ZERO && input_direction!=Vector2(0,1)&& input_direction!=Vector2(1,-1)&&input_direction!=Vector2(-1,-1):
				input_direction=last_move+Vector2(0,-2)
				AnimState.travel("Taladrando")
				Anim.set("parameters/Taladrando/blend_position", Vector2(input_direction.x,-input_direction.y))
				#print("hola no se que hace esto")
	else:
		#movimiento superficie
		if input_direction==Vector2(0,-1)||input_direction==Vector2(1,-1)||input_direction==Vector2(-1,-1):
			input_direction=Vector2(input_direction.x,0)
			last_move=input_direction
			
			AnimState.travel("Walking_Superficie")
			Anim.set("parameters/Walking_Superficie/blend_position", input_direction.x)
			#cuando camina
		elif input_direction==Vector2(1,0)||input_direction==Vector2(-1,0):
			last_move=input_direction
			AnimState.travel("Walking_Superficie")
			Anim.set("parameters/Walking_Superficie/blend_position", input_direction.x)
		elif input_direction==Vector2.ZERO:
			AnimState.travel("Idle_Superficie")	
			Anim.set("parameters/Idle_Superficie/blend_position", last_move.x)
	if movement:
		if AnimState.get_current_node()=="Escaleras":
			AnimState.travel("Taladrando_Idle")	
		
		velocity = input_direction.normalized() * SPEED
		move_and_slide()
	else:
		AnimState.travel("Escaleras")


func _on_area_2d_body_entered(body):
	if body is Player and taladrando:
		AnimState.travel("Escalera")
		SPEED = CONST_SPEED + CONST_SPEEDUP
		taladrando=false
		position.y = -20.1
		surface_entered.emit()
