extends PanelContainer
@onready var topPj = $VBoxContainer/VBoxContainer/VBoxContainerTopPlayers
var topScene : PackedScene = load("res://Logica/UI/h_box_name_and_day.tscn")
@onready var lineEditContaier = %LineEditSelfContainer
@onready var lineEdit = %LineEditSelfContainer
@onready var listHboxNames = [%HBoxNameAndDay1,%HBoxNameAndDay2,%HBoxNameAndDay3,%HBoxNameAndDay4,%HBoxNameAndDay5]

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
	
	
	# create a query
	var query2: FirestoreQuery = FirestoreQuery.new()
	# FROM a collection
	query.from("TOP_PLAYERS")
	# ORDER BY day, from the user with the best score to the latest
	query.order_by("day", FirestoreQuery.DIRECTION.DESCENDING)
	# LIMIT to the first 5 users
	query.limit(5)
	# Issue the query
	if GlobalFirebaseInfo.isAuth:
		var query_task: FirestoreTask = Firebase.Firestore.query(query)
		var indexCount = 0
		
		await query_task.task_finished
		var indexAct = query_task.data.size() + 1
		for i in query_task.data.size():
			var doc_data = query_task.data[i]["doc_fields"]
			var newTop = listHboxNames[indexCount]
			#newTop.number = indexCount + 1
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
				%LbSelfPos.text = str(child.get_index() + 1) + '.'
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
