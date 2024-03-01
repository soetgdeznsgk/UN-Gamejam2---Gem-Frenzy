extends Control
@export var APtutorial:AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalTuto.tutorial:
		GlobalRecursos.actualizar_mineral(0,2)
		GlobalRecursos.actualizar_mineral(3,2)
		#GlobalTuto.actualizarrecursostutorial.emit()
		#print("señal emitida")
		self.visible=true
		APtutorial.play("pancha_receta")
	pass # Replace with function body.

func animar_taladrando():
	APtutorial.play("pancha_taladrando")
func animar_entrega():
	APtutorial.play("pancha_entrega")
func set_last_state(transicion:String):
	var lastPosition=$"Pancha Gif/Panchasprite".position
	var lastFrame=$"Pancha Gif/Panchasprite".frame
	match transicion:
		"receta_to_entrega":
			APtutorial.get_animation("receta_to_entrega").track_insert_key(18,0,lastPosition)
			APtutorial.get_animation("receta_to_entrega").track_insert_key(0,0,lastFrame)
			
			var cofreHframe=$"Pancha Gif/Cofres/Cofreh".frame
			APtutorial.get_animation("receta_to_entrega").track_insert_key(3,0,cofreHframe)
			var cofreCframe=$"Pancha Gif/Cofres/CofreC".frame
			APtutorial.get_animation("receta_to_entrega").track_insert_key(11,0,cofreCframe)
			var Hvisible=$"Pancha Gif/Panchasprite/hierropancha".visible
			APtutorial.get_animation("receta_to_entrega").track_insert_key(5,0,Hvisible)	
			var Cvisible=$"Pancha Gif/Panchasprite/carbonpancha".visible
			APtutorial.get_animation("receta_to_entrega").track_insert_key(8,0,Cvisible)
		#"entrega_to_taladrando":
			
	print(lastPosition)
	#print(APtutorial.get_animation("receta_to_entrega").track_get_key_value(3,-1))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		set_last_state("receta_to_entrega")
		APtutorial.play("receta_to_entrega")
	pass
