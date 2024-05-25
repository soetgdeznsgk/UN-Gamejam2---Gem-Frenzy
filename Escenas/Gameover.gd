extends PanelContainer
@onready var topPj = $VBoxContainer/VBoxContainer/VBoxContainerTopPlayers
var topScene : PackedScene = load("res://Logica/UI/h_box_name_and_day.tscn")
@onready var lineEditContaier = %LineEditSelfContainer
@onready var lineEdit = %LineEditSelfContainer
@onready var listHboxNames = [%HBoxNameAndDay1,%HBoxNameAndDay2,%HBoxNameAndDay3,%HBoxNameAndDay4,%HBoxNameAndDay5]
var mapOfDays : Dictionary

func _ready() -> void:
	GlobalRecursos.bancarota.connect(gameover)
	GlobalTiempo.winner.connect(winner)
	
func call_top_players():
	for hbox in listHboxNames:
		hbox.visible = false
	# create a query
	var query: FirestoreQuery = FirestoreQuery.new()
	# FROM a collection
	query.from("TOP_PLAYERS")
	# ORDER BY day, from the user with the best score to the latest
	query.order_by("day", FirestoreQuery.DIRECTION.DESCENDING)
	# LIMIT to the first 5 users
	query.limit(5)

	if GlobalFirebaseInfo.isAuth:
		var document_task : FirestoreTask = GlobalFirebaseInfo.collection.get_doc("map_of_days")
		var document: FirestoreDocument = await document_task.get_document
		mapOfDays = document.doc_fields
		
		
		var query_task: FirestoreTask = Firebase.Firestore.query(query)
		var indexCount = 0
		
		await query_task.task_finished
		var indexAct = 0
		for i in query_task.data.size():
			var doc_data = query_task.data[i]["doc_fields"]
			var newTop = listHboxNames[indexCount]
			newTop.day = doc_data["day"]
			newTop.playerName = doc_data["name"]
			newTop.visible = true
			indexCount += 1
			
			if doc_data["day"] >= GlobalTiempo.diaActual:
				indexAct = indexCount
			
		$VBoxContainer/VBoxContainer/VBoxContainerTopPlayers.move_child(lineEditContaier, indexAct)
		
		for child : Node in topPj.get_children():
			if child != %LineEditSelfContainer:
				child.number = child.get_index() + 1
				child.set_text()
			else:
				# if index de este es 6, usar el map days
				if child.get_index() + 1 != 6:
					%LbSelfPos.text = str(child.get_index() + 1) + '.'
				else:
					var searchNumber = 0
					for i in mapOfDays.keys():
						if int(i.replace("day","")) >= GlobalTiempo.diaActual:
							searchNumber += mapOfDays[i]
					%LbSelfPos.text = str(searchNumber) + '.'
	else:
		printerr("No sesion iniciada, error al recolectar el puntaje")

func gameover():
	#sube el record a leaderboard nw
	#TROOOOOOOOOL
	if GooglePlayHandler.nombreusuario!=null:
		%LineEdit.text=GooglePlayHandler.nombreusuario
	
	#EventsClient.increment_event("CgkIrs_-8_kCEAIEA",GlobalTiempo.tiempoJuegoTotal/60)
	#PlayersClient.display_name
	GlobalLogros.sendScore.emit()
	
	call_top_players()
	%LbSelfDia.text = tr("DAY") + " " + str(GlobalTiempo.diaActual)
	$AudioGameover.play(0)
	visible = true

func _on_btn_reintentar_pressed() -> void:
	upload_to_db()
	get_tree().call_deferred("change_scene_to_file","res://Escenas/MainJuego.tscn")


func _on_btn_home_pressed() -> void:
	upload_to_db()
	get_tree().call_deferred("change_scene_to_file","res://Escenas/game_start.tscn")

func winner():
	call_top_players()
	%Gameover/VBoxContainer/Label.text=tr("CONGRATS")
	%Gameover/VBoxContainer/Label.label_settings.font_color=Color("#13E65F")
	%LbSelfDia.text = tr("DAY") + " " + str(GlobalTiempo.diaActual)
	$VBoxContainer/HBoxContainer/Btn_reintentar.visible = false

func upload_to_db():

	# Crear nuevo doc con el dia
	if GlobalFirebaseInfo.isAuth:
		var nameN = %LineEdit.text if %LineEdit.text != "" else "No Name"  
		# El nombre del ID en vacio permite que sea autogenerado
		@warning_ignore("unused_variable")
		# Se agrega el nombre y dia para la tabla de top players
		# Edit: Se agrega tambien metadatos para nosotros hacer analisis de datos
		var add_task: FirestoreTask = GlobalFirebaseInfo.collection.add\
		("", {'day': GlobalTiempo.diaActual, 'name': nameN,
		 'utc-date': Time.get_date_string_from_system(true),
		'money' : GlobalRecursos.dinero,
		'upgrades' : str(GlobalMejoras.activas_mejoras),
		'total_game_time' : GlobalTiempo.tiempoJuegoTotal,
		'build-version' : 'rng-update'
		})
		
		#hace el get del mapa de dias para actualizar el mapa de dias
		var cantidadActualDelDia = 1
		if mapOfDays.has("day"+str(GlobalTiempo.diaActual)):
			cantidadActualDelDia = mapOfDays["day"+str(GlobalTiempo.diaActual)]
			cantidadActualDelDia += 1
			
		# Actualiza la cantidad de nombres en ese dia
		@warning_ignore("unused_variable")
		var update_map : FirestoreTask = GlobalFirebaseInfo.collection.update\
		("map_of_days", {"day" +str(GlobalTiempo.diaActual) : cantidadActualDelDia})
		
	GlobalRecursos.dinero = 5
	GlobalRecursos.reiniciar_minerales()
	GlobalMejoras.reiniciar_mejoras()
	GlobalMejoras._ready()
	GlobalTiempo.diaActual = 1
	GlobalTiempo.tiempoHoraDia = 8
	GlobalTiempo.tiempoMinutoDia = 0
	OrderManager.reiniciar_recetas()
	%factura/AnimationPlayer.play("RESET")
	
