extends PanelContainer
@onready var topPj = $VBoxContainer/VBoxContainer/VBoxContainerTopPlayers
var topScene : PackedScene = load("res://Logica/UI/h_box_name_and_day.tscn")
@onready var lineEditContaier = %LineEditSelfContainer
@onready var lineEdit = %LineEditSelfContainer
@onready var listHboxNames = [%HBoxNameAndDay1,%HBoxNameAndDay2,%HBoxNameAndDay3,%HBoxNameAndDay4,%HBoxNameAndDay5]

var mapOfDays : Dictionary

func _ready() -> void:
	GlobalTiempo.iniciarDia.connect(call_top_players)
	GlobalRecursos.bancarota.connect(gameover)

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
		#TODO QUE LA POSICION DEL JUGADOR SE VEA REFLEJADA EN EL TOTAL Y NOSIEMPRE EL 6
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
		print("No sesion iniciada, error al recolectar el puntaje")

func gameover():
	%LbSelfDia.text = tr("Dia") + " " + str(GlobalTiempo.diaActual)
	$AudioGameover.play(0)
	visible = true

func _on_btn_reintentar_pressed() -> void:
	# Crear nuevo doc con el dia
	if GlobalFirebaseInfo.isAuth:
		var nameN = %LineEdit.text if %LineEdit.text != "" else "No Name"  
		# El nombre del ID en vacio permite que sea autogenerado
		var add_task: FirestoreTask = GlobalFirebaseInfo.collection.add\
		("", {'day': GlobalTiempo.diaActual, 'name': nameN})
		
		var cantidadActualDelDia = 1
		if mapOfDays.has("day"+str(GlobalTiempo.diaActual)):
			cantidadActualDelDia = mapOfDays["day"+str(GlobalTiempo.diaActual)]
			cantidadActualDelDia += 1
		# Actualiza la cantidad de nombres en ese dia
		var update_map : FirestoreTask = GlobalFirebaseInfo.collection.update\
		("map_of_days", {"day" +str(GlobalTiempo.diaActual) : cantidadActualDelDia})
		
	GlobalRecursos.dinero = 5
	GlobalRecursos.minerales = [0,0,0,0,0,0,0,0,0,0,0]
	GlobalMejoras.activas_mejoras = [0,0,0,0,0,0,0]
	GlobalMejoras._ready()
	GlobalTiempo.diaActual = 1
	GlobalTiempo.tiempoHoraDia = 8
	GlobalTiempo.tiempoMinutoDia = 0
	
	get_tree().call_deferred("change_scene_to_file","res://Escenas/game_start.tscn")


func _on_line_edit_text_changed(new_text: String) -> void:
	pass # Replace with function body.
