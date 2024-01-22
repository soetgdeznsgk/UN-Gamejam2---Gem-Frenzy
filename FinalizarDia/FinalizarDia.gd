extends PanelContainer

@onready var grid = $VBoxContainer/HbMejoras
var mejoraUI = preload("res://FinalizarDia/MejoraUI.tscn")
var infoMejorasDisponibles : Array

func _ready() -> void:
	GlobalTiempo.finalizarDia.connect(_on_finalizar_dia)
	GlobalRecursos.bancarota.connect(gameover)

func _on_finalizar_dia():
	if GlobalRecursos.dinero >= 0:
		infoMejorasDisponibles = GlobalMejoras.obtener_mejora_random_disponible()
		for i in infoMejorasDisponibles:
			var temp = mejoraUI.instantiate()
			temp.info = i
			grid.add_child(temp)
		$AudioFinDiaBien.play()
		%FinalizarDia.visible = true

func _on_btn_finalizar_dia_pressed() -> void:
	visible = false
	for child in grid.get_children():
		child.queue_free()
	GlobalTiempo.siguiente_dia()

func gameover():
	await get_tree().create_timer(0.1).timeout
	visible = false
