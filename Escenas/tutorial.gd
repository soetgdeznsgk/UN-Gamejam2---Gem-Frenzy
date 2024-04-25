extends Control
@export var APtutorial:AnimationPlayer
var Taladrandoreproducido=false
var countertaladrando=0
# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalTuto.tutorial:
		GlobalTuto.recetaToOrden.connect(_on_receta_to_orden)
		GlobalTuto.ordenToEscaleras.connect(_on_orden_to_escalera)
		GlobalTuto.escalerasToTaladrando.connect(_on_escalera_to_taladrando)
		GlobalRecursos.actualizar_mineral(0,5)
		GlobalRecursos.actualizar_mineral(3,5)
	
		self.visible=true
		APtutorial.play("pancha_receta")
	pass # Replace with function body.

func _on_escalera_to_taladrando():
	set_last_state("escalera_to_taladrando")
	APtutorial.play("escalera_to_taladrando")
	
func _on_receta_to_orden():
	set_last_state("receta_to_entrega")
	APtutorial.play("receta_to_entrega")
	GlobalTuto.FlagRecetaOrden=false
func _on_orden_to_escalera():
	set_last_state("entrega_to_escalera")
	APtutorial.play("entrega_to_escalera")
	GlobalTuto.entregaTuto.emit()
	GlobalTuto.FlagOrdenEscalera=false
func set_last_state(transicion:String):
	var lastPosition=$"Pancha Gif/Control/Panchasprite".position
	var lastFrame=$"Pancha Gif/Control/Panchasprite".frame
	match transicion:
		"receta_to_entrega":
			APtutorial.get_animation("receta_to_entrega").track_insert_key(18,0,lastPosition)
			APtutorial.get_animation("receta_to_entrega").track_insert_key(0,0,lastFrame)
			APtutorial.get_animation("receta_to_entrega").track_insert_key(0,0.5,lastFrame)
			var cofreHframe=$"Pancha Gif/Cofres/Cofreh".frame
			APtutorial.get_animation("receta_to_entrega").track_insert_key(3,0,cofreHframe)
			var cofreCframe=$"Pancha Gif/Cofres/CofreC".frame
			APtutorial.get_animation("receta_to_entrega").track_insert_key(11,0,cofreCframe)
			var Hvisible=$"Pancha Gif/Control/Panchasprite/hierropancha".visible
			APtutorial.get_animation("receta_to_entrega").track_insert_key(5,0,Hvisible)	
			var Cvisible=$"Pancha Gif/Control/Panchasprite/carbonpancha".visible
			APtutorial.get_animation("receta_to_entrega").track_insert_key(8,0,Cvisible)
		"entrega_to_escalera":
			APtutorial.get_animation("entrega_to_escalera").track_insert_key(16,0,lastPosition)
			APtutorial.get_animation("entrega_to_escalera").track_insert_key(16,0.5,lastPosition)
			APtutorial.get_animation("entrega_to_escalera").track_insert_key(0,0,lastFrame)
			APtutorial.get_animation("entrega_to_escalera").track_insert_key(0,0.5,lastFrame)
		"escalera_to_taladrando":
			APtutorial.get_animation("escalera_to_taladrando").track_insert_key(1,0,lastPosition)
			APtutorial.get_animation("escalera_to_taladrando").track_insert_key(1,0.5,lastPosition)
			APtutorial.get_animation("escalera_to_taladrando").track_insert_key(0,0,lastFrame)
			APtutorial.get_animation("escalera_to_taladrando").track_insert_key(0,0.5,lastFrame)
			var Rvisible=$"Pancha Gif/Control/Panchasprite/Receta".visible
			APtutorial.get_animation("escalera_to_taladrando").track_insert_key(6,0,Rvisible)
		
		#"entrega_to_taladrando":
			
	print(lastPosition)
	#print(APtutorial.get_animation("receta_to_entrega").track_get_key_value(3,-1))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.

func emit_endtaladrando():
	if !Taladrandoreproducido:
		GlobalTuto.endTaladrando.emit()
		Taladrandoreproducido=true
		GlobalTuto.FlagendTaladrando=false
		$Objetivo.text=tr("MISSION_TEXT")
		
	if GlobalRecursos.minerales[3]>20:
		GlobalTuto.pausarpancha.emit()
		$"Pancha Gif".visible=false
		$"Tutorialfinalizao/Pancha finalizao".play("default")
		$"Tutorialfinalizao".visible=true
		$"AudioTutorial".play()
		$"AnimationPlayer".stop()
		
func animar_taladrando():
	APtutorial.play("pancha_taladrando")
func animar_entrega():
	APtutorial.play("pancha_entrega")
func animar_escalera():
	APtutorial.play("pancha_escalera")


func _on_botonterminar_pressed():
	GlobalTuto.tutorial=false
	#GlobalTiempo.diaActual=1
	GlobalRecursos.dinero = 5
	GlobalRecursos.reiniciar_minerales()
	GlobalMejoras.reiniciar_mejoras()
	GlobalRecursos.reiniciar_factura()
	GlobalMejoras._ready()
	GlobalTiempo.diaActual = 1
	GlobalTiempo.tiempoHoraDia = 8
	GlobalTiempo.tiempoMinutoDia = 0
	get_tree().change_scene_to_file("res://Escenas/MainJuego.tscn")
	pass # Replace with function body.
