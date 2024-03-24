extends CharacterBody2D
class_name Player

signal surface_entered
signal mine_entered

@export var CONST_SPEED : float
@export var CONST_SPEEDUP : float

@onready var SPEED = CONST_SPEED
@onready var SPEEDUP= CONST_SPEED + CONST_SPEEDUP
@onready var Anim : AnimationTree = $AnimationTree
@onready var AnimState : AnimationNodeStateMachinePlayback = Anim.get("parameters/playback")
var taladrando= false
var input_direction = Vector2.ZERO
var last_move=Vector2.ZERO
var movement = true
var items_en_mano := Array()
var receta_en_mano = false: set = _set_receta
var modolento=false
var recienSalidoEscalera = false


func _ready() -> void:
	GlobalTiempo.iniciarDia.connect(iniciar_dia)
	GlobalTiempo.finalizarDia.connect(finalizar_dia)
	GlobalRecursos.bancarota.connect(gameover)

func gameover():
	visible = false
	position = Vector2(397,-21)

func iniciar_dia():
	movement = true
	taladrando=false
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position", Vector2(397,-21),0.1)

func finalizar_dia():
	movement = false
	input_direction = Vector2.ZERO
	last_move=Vector2.ZERO
	surface_entered.emit()

func _physics_process(_delta):
	input_direction = Vector2(int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
	-int(Input.is_action_pressed("ui_up")))
	if taladrando:
		#movimiento taladrando
		if input_direction==Vector2(0,-1)||input_direction==Vector2(1,-1)||input_direction==Vector2(-1,-1):
			input_direction=Vector2(0,-1)
			SPEED = CONST_SPEED + CONST_SPEEDUP
			AnimState.travel("Taladrando")
			Anim.set("parameters/Taladrando/blend_position", Vector2(input_direction.x,-input_direction.y))
			if recienSalidoEscalera:
				movement = false
				AnimState.travel("Escalera")
				SPEED = CONST_SPEED
				taladrando=false
				recienSalidoEscalera = false
				var tween :Tween = get_tree().create_tween()
				tween.tween_property(self, "position:x", $"../Area2DCasa".position.x, 0.4)
				tween.tween_property(self, "position:y", -21.2, 0.7)
				tween.tween_callback(_on_tween_callback)
				
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
	else:
		#movimiento superficie
		modolento=false#NO BORREN ESTO POR FAVOR QUE HACE LENTO EL JUEGO 😭
		if input_direction==Vector2(0,-1):
			input_direction=Vector2.ZERO
		if input_direction==Vector2(1,-1)||input_direction==Vector2(-1,-1):
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
			if GlobalTuto.tutorial && GlobalTuto.FlagEscaleraTaladrando:
				GlobalTuto.escalerasToTaladrando.emit()
				movement=false
				GlobalTuto.FlagEscaleraTaladrando=false
				await GlobalTuto.endTaladrando
				movement=true
				
				
		if modolento:
			SPEED=50
		else:
			SPEED=CONST_SPEED
		velocity = input_direction.normalized() * SPEED
		move_and_slide()
		
	else:
		AnimState.travel("Escaleras")
			


func _on_area_2d_body_entered(body):
	if body is Player and taladrando and movement and not recienSalidoEscalera:
		
		movement = false
		AnimState.travel("Escalera")
		SPEED = CONST_SPEED
		taladrando=false
		recienSalidoEscalera = false
		var tween :Tween = get_tree().create_tween()
		tween.tween_property(self, "position:x", $"../Area2DCasa".position.x, 0.4)
		tween.tween_property(self, "position:y", -21.2, 0.7)
		tween.tween_callback(_on_tween_callback)

func _on_tween_callback():
	
	surface_entered.emit()
	movement = true	
	SPEED = CONST_SPEED
#esto es de subir al seugndo piso, lmao	
func _on_ladder_finish():
	#print("escalera finalizada?")

	movement = true
	input_direction = Vector2.ZERO
	last_move = Vector2.ZERO

# Setters/Getters

func _set_receta(valor : int) -> int:
	var temp = $Receta.frame
	$Receta.frame = valor
	$Receta.visible = not $Receta.visible
	receta_en_mano = not receta_en_mano
	return temp

# Llamadas

func recibirObjeto(objeto : int):	
	if items_en_mano.size() < 3:
		items_en_mano.append(objeto)
		get_child(items_en_mano.size() - 1).frame = objeto # Ésto depende de que item 1, 2 y 3 sean child0, child1 y child2

func darObjetos() -> Array:
	var temp = items_en_mano.duplicate()
	items_en_mano.clear()
	for itemSprite in range(0, 3): # por
		get_child(itemSprite).frame = 11 # Ésto depende de que item 1, 2 y 3 sean child0, child1 y child2
	return temp
	
func darUnObjeto(objeto : int):
	
	var i = items_en_mano.find(objeto) # devuelve el indice
	items_en_mano.pop_at(i) 
	get_child(0).frame = 11
	get_child(1).frame = 11
	get_child(2).frame = 11
	
	
	for r in range(0, items_en_mano.size()):
		get_child(r).frame = items_en_mano[r]
	return # sé que no dará -1 por que en los cofres se verifica que el jugador si o sí tiene 1 en el inventario



func _on_area_2d_casa_body_exited(_body: Node2D) -> void:
	$Timer.start()


func _on_timer_timeout() -> void:
	recienSalidoEscalera = false
