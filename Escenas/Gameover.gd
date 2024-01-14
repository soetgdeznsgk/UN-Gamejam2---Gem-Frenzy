extends PanelContainer
@onready var topPj = $VBoxContainer/VBoxContainer/VBoxContainerTopPlayers
var topScene : PackedScene = load("res://Logica/UI/h_box_name_and_day.tscn")
#@onready var firestore_collection : FirestoreCollection = Firebase.Firestore.collection('TOP_PLAYERS')
@onready var nameAct = $VBoxContainer/VBoxContainer/VBoxContainerTopPlayers/HBoxContainer/MarginContainer/LineEdit
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalRecursos.bancarota.connect(gameover)

func gameover():
	$VBoxContainer/VBoxContainer/VBoxContainerTopPlayers/HBoxContainer/Label5.text = \
	tr("Dia") + " " + str(GlobalTiempo.diaActual)
	$AudioGameover.play(0)
		# create a query
	var query: FirestoreQuery = FirestoreQuery.new()
	# FROM a collection
	query.from("TOP_PLAYERS")
	# ORDER BY day, from the user with the best score to the latest
	query.order_by("day", FirestoreQuery.DIRECTION.DESCENDING)
	# LIMIT to the first 5 users
	query.limit(5)
	
	# Issue the query
	if GlobalFirebaseInfo.isAuth:
		var query_task: FirestoreTask = Firebase.Firestore.query(query)
		var adder = 1
		var indexCount = 0
		
		await query_task.task_finished
		var indexAct = query_task.data.size()-1
		for i in query_task.data.size():
			var doc_data = query_task.data[i]["doc_fields"]
			
			if doc_data["day"] >= GlobalTiempo.diaActual:
				var newTop = topScene.instantiate()
				newTop.number = i + adder
				newTop.day = doc_data["day"]
				newTop.playerName = doc_data["name"]
				topPj.add_child(newTop)
				topPj.move_child(newTop,indexCount)
				indexCount+=1
			else:
				adder+=1
				indexAct = indexCount
				indexCount += 1
		move_child($VBoxContainer/VBoxContainer/VBoxContainerTopPlayers/HBoxContainer, indexAct)
	else:
		print("No sesion iniciada, error al recolectar el puntaje")
	visible = true

func _on_btn_reintentar_pressed() -> void:
	# Crear nuevo doc con el dia
	if GlobalFirebaseInfo.isAuth:
		var add_task: FirestoreTask = \
		GlobalFirebaseInfo.collection.add("", {'day': GlobalTiempo.diaActual, 'name': nameAct.text})
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
