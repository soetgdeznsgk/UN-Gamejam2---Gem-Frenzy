extends PanelContainer
@onready var topPj = $VBoxContainer/VBoxContainer/VBoxContainerTopPlayers
var topScene : PackedScene = load("res://Logica/UI/h_box_name_and_day.tscn")
#@onready var firestore_collection : FirestoreCollection = Firebase.Firestore.collection('TOP_PLAYERS')

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalRecursos.bancarota.connect(gameover)

func gameover():
	visible = true
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
	var query_task: FirestoreTask = Firebase.Firestore.query(query)
	await query_task.task_finished
	print(query_task.data)
	
	#for
	var newTop = topScene.instantiate()
	#newTop.number
	#newTop.day
	#newTop.playerName
	topPj.add_child(newTop)

func _on_btn_reintentar_pressed() -> void:
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
